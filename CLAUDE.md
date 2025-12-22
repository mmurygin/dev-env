# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

Ansible-based infrastructure-as-code project that automates provisioning of an Ubuntu desktop development environment. Enables reproducible workstation setup through modular, reusable roles.

## Essential Commands

### Initial Setup
```bash
# Install dependencies
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

# Run full playbook (requires sudo password)
ansible-playbook -K desktop.yml
```

### Running Specific Roles
```bash
# Run single role by tag
ansible-playbook -K desktop.yml --tags windsurf

# Resume from specific task (for debugging)
ansible-playbook -K desktop.yml --start-at-task="task name"
```

**Note**: The `-K` flag prompts for sudo password (required for apt operations and system configuration).

## Architecture

### Role-Based Structure

The codebase consists of 24 modular Ansible roles under `roles/`. Each role follows standard Ansible structure:

```
roles/<name>/
├── tasks/main.yml          # Task definitions (entry point)
├── defaults/main.yml       # Pinned versions and variables
├── files/                  # Static configs (symlinked to ~/)
└── templates/              # Jinja2 templates (optional)
```

### Role Activation

Roles are enabled/disabled in `desktop.yml` by commenting/uncommenting. Currently active roles: go, dev, xclip, cron-update-packages, vim, tmux, windsurf, kube-client.

### Common Patterns in Roles

1. **Version Checking**: Detect installed version before reinstalling
   ```yaml
   shell: which go && go version | grep {{ go_version }}
   register: go_is_installed
   failed_when: no
   changed_when: no
   ```

2. **Conditional Installation**: Skip if already present
   ```yaml
   when: go_is_installed.rc != 0
   ```

3. **Configuration Symlinks**: Link files from `roles/<name>/files/` to home directory
   - Example: `.vimrc`, `.tmux.conf` symlinked from role files

4. **Environment Setup**: Modify `.bashrc` for PATH, aliases, and environment variables
   ```yaml
   lineinfile:
     path: ~/.bashrc
     state: present
     line: "export PATH=$PATH:/usr/local/go/bin"
   ```

5. **Bash Completions**: Install auto-completion for CLI tools (kubectl, terraform, etc.)

### Version Pinning

Tool versions are declared in `roles/<name>/defaults/main.yml`:
- Go: 1.25.5
- Terraform: 1.0.7
- Tmux: 3.1c
- kubectl: v1.22.1

Update these files to change versions, not inline in tasks.

## Development Conventions

### Commit Message Format

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<prefix>: <summary>

- <change 1>
- <change 2>

Refs: #<issue> (optional)
```

**Prefixes**: `feat`, `fix`, `refactor`, `perf`, `test`, `docs`, `build`, `ci`, `chore`, `style`, `revert`

**Rules**:
- Summary: ~50 chars, imperative mood, no period
- Body: Bullet points listing actual changes from diff
- Always read `git diff --cached` before writing commit message
- Check for linked Jira tickets and add `Refs: PROJ-1234`

### Bash Scripting Standards

When writing or modifying bash scripts:

```bash
#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
```

- **Variables**: UPPER_CASE for globals, lower_case for locals, always quote `"${VAR}"`
- **Error handling**: Use `set -euo pipefail`, add trap cleanup, validate inputs
- **Functions**: snake_case names, document with comments
- **Linter**: shellcheck compliance required

### Test Strategy

When adding functionality requiring tests:

1. **Structure**: Use Given/When/Then format in test comments
2. **Coverage**: Normal cases + error cases + boundary conditions (0, min, max, empty, NULL)
3. **Error verification**: Check exception type and message
4. **External dependencies**: Mock failures, test retry/fallback logic

## Adding New Tools

1. Create role directory: `roles/<tool-name>/`
2. Add `tasks/main.yml` with installation steps
3. (Optional) Add `defaults/main.yml` for version variables
4. (Optional) Add `files/` for configuration files
5. Enable in `desktop.yml` by adding role to list
6. Test with: `ansible-playbook -K desktop.yml --tags <tool-name>`

## Modifying Configurations

- **Vim**: Edit `roles/vim/files/.vimrc`
- **Tmux**: Edit `roles/tmux/files/.tmux.conf`
- **Windsurf**: Edit `roles/windsurf/files/settings.json` or `keybindings.json`
- **Shell aliases**: Modify loop in `roles/dev/tasks/main.yml`

Changes take effect on next playbook run or by sourcing updated files manually.

## Known Issues

See `todo.md` in repository root. Current issue: executables not immediately available in PATH after installation (may require new shell session).

## Key Roles Overview

- **dev**: Core development packages (build-essential, python3-pip, jq, shellcheck), Python tools via pipx (ruff, black, mypy, yamllint), bash aliases (`va`, `p3`, `sg`)
- **go**: Go language (1.25.5) with golangci-lint and shfmt
- **vim/tmux**: Editors with custom configurations and plugins
- **windsurf**: AI-powered IDE with custom agent rules in `roles/windsurf/files/rules/`
- **kube-client**: kubectl + kubectx with bash completions
- **terraform/vault/packer**: Infrastructure tools with pinned versions
