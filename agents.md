# Agents Guide

## Purpose

This repository automates the provisioning of an Ubuntu development workstation using **Ansible**. It installs and configures development tools, editors, languages, and DevOps utilities via reusable roles.

## Repository Structure

```
dev-env/
├── desktop.yml          # Main Ansible playbook
├── requirements.txt     # Python dependencies (ansible)
├── roles/               # Ansible roles for each tool/component
│   ├── dev/             # Core dev packages (build-essential, jq, curl, etc.)
│   ├── vim/             # Vim editor with plugins and configs
│   ├── tmux/            # Tmux terminal multiplexer + tmuxinator
│   ├── go/              # Go language
│   ├── kube-client/     # kubectl and kubectx
│   ├── chrome/          # Google Chrome browser
│   ├── gnome-shell/     # GNOME desktop extensions
│   ├── fzf/             # Fuzzy finder
│   ├── k9s/             # Kubernetes TUI
│   ├── helm-client/     # Helm package manager
│   ├── helmfile/        # Helmfile for declarative Helm
│   ├── terraform/       # Terraform IaC
│   ├── vault/           # HashiCorp Vault
│   ├── packer/          # HashiCorp Packer
│   ├── vagrant/         # Vagrant VM management
│   ├── kvm/             # KVM virtualization
│   ├── virtualbox/      # VirtualBox
│   ├── chef/            # Chef configuration management
│   ├── xclip/           # Clipboard utility
│   └── cron-update-packages/  # Auto-update packages via cron
└── README.md            # Setup instructions
```

## Key Technologies

- **Ansible** — Configuration management and provisioning
- **Ubuntu** — Target operating system
- **Bash** — Shell configuration (`.bashrc` aliases)

## Common Tasks

### Adding a New Tool

1. Create a new role directory under `roles/<tool-name>/`
2. Add `tasks/main.yml` with installation steps
3. Optionally add `files/` for config files, `defaults/main.yml` for variables
4. Enable the role in `desktop.yml`

### Modifying Tool Configuration

- **Vim config** — `roles/vim/files/.vimrc`
- **Tmux config** — `roles/tmux/files/.tmux.conf`
- **Shell aliases** — `roles/dev/tasks/main.yml` (loop at bottom)

### Running the Playbook

```bash
source .venv/bin/activate
ansible-playbook -K desktop.yml
```

The `-K` flag prompts for sudo password.

### Testing a Single Role

```bash
ansible-playbook -K desktop.yml --tags <role-name>
```

Or limit to specific tasks:

```bash
ansible-playbook -K desktop.yml --start-at-task="<task name>"
```

## Role Anatomy

Each role follows standard Ansible structure:

```
roles/<name>/
├── tasks/
│   └── main.yml      # Entry point, can include other task files
├── files/            # Static files (configs, scripts)
├── defaults/
│   └── main.yml      # Default variables
└── templates/        # Jinja2 templates (optional)
```

## Notes for Agents

- Roles commented out in `desktop.yml` are disabled — uncomment to enable
- Most roles use `become: yes` for apt operations (requires sudo)
- Config files are symlinked from `roles/<name>/files/` to home directory
- The `dev` role sets up common environment: `EDITOR=vim`, bash aliases like `va`, `sg`
