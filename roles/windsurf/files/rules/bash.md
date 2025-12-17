---
trigger: model_decision
description: Applied when writing Bash scripts. Automation, error handling, portability.
globs: **/*.sh, **/Makefile
---

# Bash Scripting Rules

---

## Standards

| Setting | Value |
|---------|-------|
| Shebang | `#!/usr/bin/env bash` |
| Linter | shellcheck |
| Style | POSIX-compliant when possible |

---

## Script Header

```bash
#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Script description
# Usage: script.sh [options]
```

**Flags:**
- `set -e` — Exit on error
- `set -u` — Error on undefined variables
- `set -o pipefail` — Catch pipe failures

---

## Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Scripts | snake_case | `backup_database.sh` |
| Variables | UPPER_CASE | `LOG_DIR`, `MAX_RETRIES` |
| Functions | snake_case | `validate_input()` |
| Local vars | lower_case | `local file_count` |

---

## Variables

```bash
# Always quote variables
echo "${MY_VAR}"

# Use defaults
: "${LOG_DIR:=/var/log}"

# Declare local in functions
my_function() {
    local result
    result=$(some_command)
    echo "${result}"
}
```

---

## Error Handling

```bash
# Trap for cleanup
cleanup() {
    rm -f "${TEMP_FILE:-}"
}
trap cleanup EXIT

# Check command success
if ! command -v docker &> /dev/null; then
    echo "Error: docker not found" >&2
    exit 1
fi

# Validate inputs
if [[ -z "${1:-}" ]]; then
    echo "Usage: $0 <argument>" >&2
    exit 1
fi
```

---

## Functions

```bash
# Document functions
# Description: Validates environment
# Arguments: $1 - environment name
# Returns: 0 on success, 1 on failure
validate_environment() {
    local env="${1:?Environment required}"
    
    case "${env}" in
        dev|staging|prod) return 0 ;;
        *) return 1 ;;
    esac
}
```

---

## Argument Parsing

```bash
# Using getopts
while getopts ":hv:f:" opt; do
    case ${opt} in
        h) usage; exit 0 ;;
        v) VERBOSE=true ;;
        f) FILE="${OPTARG}" ;;
        \?) echo "Invalid option: -${OPTARG}" >&2; exit 1 ;;
        :) echo "Option -${OPTARG} requires argument" >&2; exit 1 ;;
    esac
done
shift $((OPTIND - 1))
```

---

## Logging

```bash
log() {
    local level="${1}"
    shift
    echo "[$(date -Iseconds)] [${level}] $*" >&2
}

log INFO "Starting process"
log ERROR "Failed to connect"
```

---

## Anti-Patterns (Avoid)

- ❌ Unquoted variables — always quote `"${var}"`
- ❌ `cd` without error check — use `cd dir || exit`
- ❌ Parsing `ls` output — use globs or `find`
- ❌ `cat file | grep` — use `grep pattern file`
- ❌ Hardcoded paths — use variables
- ❌ Missing error handling — use `set -euo pipefail`
- ❌ `eval` with user input — security risk
