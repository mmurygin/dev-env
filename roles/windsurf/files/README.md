# Windsurf Configuration Rules

Personal Windsurf rules optimized for LLM-assisted development.

## Overview

This repository contains two types of rules:

| Type | Location | Scope |
|------|----------|-------|
| **Global rules** | `global-rules.md` | Applied to every Windsurf session |
| **Repo rules** | `rules/` | Symlinked to individual repositories |

## Structure

```
configs/
├── README.md
├── global-rules.md          # Personal context (identity, Jira, Git, security)
└── rules/                   # Symlink this to your repos as .windsurf/rules
    ├── v5.md                # AI behavior, task classification, code quality
    ├── test-strategy.md     # Test design, coverage, anti-patterns
    ├── commit-message-format.md  # Conventional commits format
    ├── java.md              # Java/Spring Boot patterns
    ├── golang.md            # Go microservices, clean architecture
    ├── python.md            # Python automation, async, CLI
    ├── bash.md              # Bash scripting, error handling
    └── rest-api.md          # REST API design patterns
```

## How This Repo Was Created

These rules were derived from [windsurf-antigravity-rules](https://github.com/windsurf-antigravity-rules) and improved for practical LLM usage:

1. **Reduced verbosity** — LLMs work better with concise, direct instructions
2. **Added anti-patterns** — Explicit "don'ts" prevent common LLM mistakes
3. **Used tables over prose** — Faster parsing for both humans and AI
4. **Removed duplication** — Each rule file has a single responsibility
5. **Added glob triggers** — Language-specific rules activate only for relevant files

## Setup

### 1. Configure Global Rules

Add `global-rules.md` content to your Windsurf global memory or settings.

Alternatively, copy to your Windsurf config directory:
```bash
ln -sf ~/src/dev-env/roles/windsurf/files/global-rules.md ~/.codeium/windsurf/memories/global_rules.md
```

### 2. Symlink Repo Rules to Your Projects

For each repository where you want these rules:

```bash
# Navigate to your project
cd ~/src/your-project

# Create .windsurf directory if it doesn't exist
mkdir -p .windsurf

# Create symlink to rules directory
ln -s ~/src/dev-env/roles/windsurf/files/rules .windsurf/rules
```

#### Example

```bash
# Setup for multiple repos
for repo in ~/src/project-a ~/src/project-b ~/src/project-c; do
  mkdir -p "$repo/.windsurf"
  ln -s ~/src/windsurf/configs/rules "$repo/.windsurf/rules"
done
```

### 3. Verify Setup

```bash
# Check symlink is correct
ls -la .windsurf/rules

# Should show:
# rules -> /home/mmurygin/src/windsurf/configs/rules
```

## Rule Files

### `v5.md` (always_on)
Foundation rules for all coding tasks:
- Task classification (🟢 Light / 🟡 Standard / 🔴 Critical)
- Tool selection guidance
- Code quality standards
- Response style

### `test-strategy.md` (model_decision)
Triggered when writing tests:
- Test perspective tables
- Given/When/Then structure
- Coverage targets
- Anti-patterns

### `commit-message-format.md` (model_decision)
Triggered when creating commits:
- Conventional Commits format
- Prefix reference table
- Examples with Jira references

### `java.md` (model_decision)
Triggered for `*.java`, `pom.xml`:
- Maven, Java 17+ patterns
- Google Java Style Guide
- Lombok, Optional, try-with-resources

### `python.md` (model_decision)
Triggered for `*.py`, `pyproject.toml`:
- Python 3.10+ patterns
- ruff, pytest, type hints
- CLI patterns (--dry-run, --verbose)

### `golang.md` (model_decision)
Triggered for `*.go`, `go.mod`:
- Go 1.22+ microservices patterns
- Clean architecture, dependency injection
- OpenTelemetry observability
- Table-driven tests

### `bash.md` (model_decision)
Triggered for `*.sh`, `Makefile`:
- Error handling with `set -euo pipefail`
- Argument parsing, logging patterns
- shellcheck validation

### `rest-api.md` (model_decision)
Triggered when designing APIs:
- Resource naming conventions
- HTTP methods and status codes
- Error response format

## Customization

### Adding Project-Specific Rules

Create additional rule files in your project's `.windsurf/rules/` directory (not the symlink):

```bash
# Create project-specific rules alongside symlinked rules
cat > .windsurf/project-rules.md << 'EOF'
---
trigger: always_on
description: Project-specific conventions
---
# Project Rules
- Use PostgreSQL for database
- Deploy to AWS EKS
- Feature flags via LaunchDarkly
EOF
```

### Overriding Rules

To override a symlinked rule for a specific project, create a file with the same name in a non-symlinked location that Windsurf reads first.

## Updating Rules

Since rules are symlinked, updating the source updates all projects:

```bash
cd ~/src/windsurf/configs
# Make changes to rules/
git add -A && git commit -m "chore: Update test strategy rules"
git push
```

## License

Personal configuration. Use and adapt as needed.
