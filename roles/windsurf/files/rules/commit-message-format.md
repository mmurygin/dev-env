---
trigger: model_decision
description: Applied when creating Git commit messages. Conventional Commits format with structured body.
globs:
---

# Git Commit Message Format

Based on [Conventional Commits](https://www.conventionalcommits.org/). All messages in English.

---

## Format

```
<prefix>: <summary>

- <change 1>
- <change 2>

Refs: #<issue> (optional)
BREAKING CHANGE: <details> (optional)
```

---

## Prefix

| Prefix | Use for |
|--------|---------|
| `feat` | New feature |
| `fix` | Bug fix |
| `refactor` | Code restructure (no behavior change) |
| `perf` | Performance improvement |
| `test` | Add/modify tests |
| `docs` | Documentation only |
| `build` | Build system, dependencies |
| `ci` | CI/CD configuration |
| `chore` | Tooling, scripts, maintenance |
| `style` | Formatting (no logic change) |
| `revert` | Revert previous commit |

Optional scope: `fix(auth): ...` or `feat(api): ...`

---

## Summary Line

- **~50 characters** or less
- Imperative mood: "Add feature" not "Added feature"
- No period at end
- Specific: what changed and why (briefly)

---

## Body

- Bullet points with `- `
- List actual changes from the diff
- For significant changes, include:
  - Impact scope
  - Migration steps (if any)
  - Risks / rollback notes

---

## Generation Rules

1. **Always read the diff first** — `git diff --cached` or `git diff`
2. **Describe what the diff shows** — not what you intended or the issue title says
3. **Each bullet = one logical change** — don't lump unrelated changes
4. Check if there is a linked Jira ticket and add it to the commit message

---

## Examples

```
feat: Add rate limiting to API endpoints

- Implement token bucket algorithm for /api/* routes
- Add X-RateLimit-* headers to responses
- Default: 100 requests/minute per IP

Refs: CRON-1234
```

```
fix: Prevent crash on empty user input

- Add null check before processing form data
- Return validation error instead of 500

Refs: CRON-5678
```

```
refactor: Extract database connection logic

- Move connection pooling to dedicated module
- No behavior changes
- Reduces duplication across 3 services

Refs: CRON-9999
```

---

## Prohibited

- ❌ Vague summaries: "update", "fix bug", "changes", "WIP"
- ❌ Long prose without bullet points
- ❌ Guessing changes from branch name or issue title
- ❌ Commits that only disable linting/checks without fixing underlying issues
- ❌ Multiple unrelated changes in one commit (split them)
