---
trigger: model_decision
description: Applied when writing Python code. Automation, CLI tools, async patterns.
globs: **/*.py, **/pyproject.toml, **/requirements.txt
---

# Python Development Rules

---

## Standards

| Setting | Value |
|---------|-------|
| Version | 3.10+ (match statements, walrus operator) |
| Style | PEP 8 |
| Linter | ruff (preferred) or flake8 |
| Config | pyproject.toml |
| Testing | pytest + pytest-mock + pytest-asyncio |
| CLI | argparse or click/typer |
| Package mgmt | uv (preferred) or pip |

---

## Project Structure

```
src/
├── services/      # Business logic
├── utils/         # Helper functions
├── types/         # Models, schemas (Pydantic)
├── cli/           # CLI commands
└── tests/         # Test modules
```

---

## Required Practices

- Type hints on all function parameters and returns
- `dataclasses` or `Pydantic` for structured data
- `pathlib` over `os.path` for file operations
- f-strings for string formatting
- Early returns to reduce nesting
- Guard clauses at function top

---

## Async Patterns

```python
# Use async for I/O-bound operations
async def fetch_data(url: str) -> dict:
    async with httpx.AsyncClient() as client:
        response = await client.get(url)
        return response.json()

# Use def for CPU-bound operations
def process_data(data: dict) -> Result:
    ...
```

**Libraries:**
- `httpx` or `aiohttp` for async HTTP
- `asyncio` for concurrency
- `asyncssh` for SSH operations

---

## Subprocess & Commands

```python
# Safe command execution
import shlex
import subprocess

cmd = shlex.split("ls -la /path")
result = subprocess.run(cmd, capture_output=True, text=True, check=True)
```

- Use `subprocess.run()` over `os.system()`
- Use `shlex.split()` for safe command parsing
- Handle signals (SIGTERM, SIGINT) for long-running processes

---

## CLI Patterns

```python
@click.command()
@click.option("--dry-run", is_flag=True, help="Preview without changes")
@click.option("-v", "--verbose", is_flag=True, help="Verbose output")
def main(dry_run: bool, verbose: bool) -> None:
    ...
```

**Required flags for automation:**
- `--dry-run` for destructive operations
- `--verbose` / `-v` for debugging
- Return proper exit codes (0=success, non-zero=failure)

---

## Error Handling

```python
# Custom exceptions
class ValidationError(Exception):
    """Raised when input validation fails."""

# Guard clauses
def process(data: dict | None) -> Result:
    if data is None:
        raise ValidationError("Data required")
    if not data.get("id"):
        raise ValidationError("ID required")
    
    # Happy path last
    return Result(...)
```

- Structured logging with context (module, function, params)
- Map exceptions to user-friendly messages
- Never use bare `except:`

---

## Testing

**Command:** `pytest --cov=module_name`

**Patterns:**
- Use fixtures for reusable setup
- Mock external services (AWS, APIs, DB)
- Test edge cases: empty inputs, timeouts, permission errors
- Use `pytest-asyncio` for async tests

```python
@pytest.fixture
def sample_data() -> dict:
    return {"id": 1, "name": "test"}

def test_process(sample_data: dict) -> None:
    result = process(sample_data)
    assert result.success is True
```

---

## Security

- Never hardcode secrets — use env vars or secret managers
- Sanitize all external inputs
- Use secure defaults (TLS 1.2+)
- Set file permissions: `0o600` for sensitive files

---

## Anti-Patterns (Avoid)

- ❌ Missing type hints
- ❌ `os.system()` for shell commands
- ❌ Hardcoded secrets
- ❌ Bare `except:` clauses
- ❌ Mutable default arguments (`def fn(items=[])`)
- ❌ Nested conditionals — use guard clauses
- ❌ Blocking calls in async functions
