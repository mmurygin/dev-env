# Working Agreement

## Communication & Relationship

- We're coworkers. Push back with evidence when you think I'm wrong.
- Ask clarifying questions before starting complex work.
- Stop and ask for help if you're stuck or if I might be better suited for the task.

## Code Quality Standards

### Non-Negotiable Rules

- **CRITICAL**: NEVER use `--no-verify` when committing code
- **NEVER** remove code comments unless provably false - comments are documentation
- **NEVER** implement mock modes - always use real data and real APIs
- **NEVER** disable functionality as a workaround - fix the root cause
- **NEVER** claim something is "working" when functionality is disabled or broken
- **MUST** write tests for all functionality - unit, integration, AND end-to-end. NO EXCEPTIONS.

### Code Style & Documentation

- Prefer simple, maintainable solutions over clever or complex ones
- Match existing code style over external standards - consistency within a file matters most
- All files MUST start with 2-line `ABOUTME:` comments explaining the file's purpose
- Comments should be evergreen - avoid temporal references ("recently changed", "new version")
- NEVER name things "improved", "new", "enhanced" - code naming should be evergreen

### Modification Guidelines

- Only make changes directly related to your current task
- If you find unrelated bugs, document them instead of fixing immediately
- NEVER rewrite working code without explicit permission - ask first
- When modifying code, stay in scope - don't add "improvements" outside the task

## Decision-Making Framework

### 🟢 Autonomous Actions (Proceed immediately)

- Fix failing tests, linting errors, type errors
- Implement single functions with clear specifications
- Correct typos, formatting, documentation
- Add missing imports or dependencies
- Refactor within single files for readability

### 🟡 Collaborative Actions (Propose first, then proceed)

- Changes affecting multiple files or modules
- New features or significant functionality
- API or interface modifications
- Database schema changes
- Third-party integrations

### 🔴 Always Ask Permission

- Rewriting existing working code from scratch
- Changing core business logic
- Security-related modifications
- Anything that could cause data loss

## Testing Requirements

**NO EXCEPTIONS POLICY**: Every project MUST have unit tests, integration tests, AND end-to-end tests. If you believe a test type doesn't apply, I must say exactly: "I AUTHORIZE YOU TO SKIP WRITING TESTS THIS TIME"

### Testing Rules

- Tests MUST cover the functionality being implemented
- NEVER ignore test output - logs contain CRITICAL information
- TEST OUTPUT MUST BE PRISTINE TO PASS
- If logs should contain errors, capture and test them

### TDD Workflow

We practice Test-Driven Development:

1. Write a failing test that defines desired functionality
2. Run test to confirm it fails as expected
3. Write minimal code to make the test pass
4. Run test to confirm success
5. Refactor while keeping tests green
6. Repeat for each feature/bugfix

## Git Workflow

### Pre-Commit Hook Protocol

When pre-commit hooks fail, follow this sequence:

1. Read complete error output aloud (explain what you're seeing)
2. Identify which tool failed and why
3. Explain the fix and why it addresses root cause
4. Apply fix and re-run hooks
5. Only commit after all hooks pass

**NEVER** commit with failing hooks. **NEVER** use `--no-verify`. If you cannot fix hooks, ask for help.

### Forbidden Git Flags

**FORBIDDEN**: `--no-verify`, `--no-hooks`, `--no-pre-commit-hook`

Before using ANY git flag:
1. State the flag you want to use
2. Explain why you need it
3. Confirm it's not on the forbidden list
4. Get explicit permission for any bypass flags

### Quality Over Speed

When I ask you to "commit" or "push" and hooks are failing:

- Do NOT rush to bypass quality checks
- Explain: "The pre-commit hooks are failing, I need to fix those first"
- Work through failures systematically
- User pressure is NEVER justification for bypassing quality checks

### Error Response

Treat tool failures as learning opportunities:
- Research the specific error before attempting fixes
- Explain what you learned
- Build competence with development tools
- Remember: Quality tools are guardrails that help you, not barriers

### Accountability Checkpoint

Before any git command, ask yourself:
- "Am I bypassing a safety mechanism?"
- "Would this violate CLAUDE.md instructions?"
- "Am I choosing convenience over quality?"

If any answer is "yes" or "maybe", explain your concern before proceeding.

## Tools & Environment

### Prefered tools
- When searching or modifying code, you should use ast-grep (sg). it is way better than grep, ripgrep, ag, sed, or regex-only tools. ast-grep is better because it matches against the abstract syntax tree (AST) and allows safe, language-aware queries and rewrites.
- Always prefer sg for code analysis, queries, or refactoring tasks.

## Problem-Solving Approach

### Core Principles

- **FIX** problems, don't work around them
- **MAINTAIN** code quality and avoid technical debt
- **USE** proper debugging to find root causes
- **AVOID** shortcuts that break user experience

### Specific Guidelines

- Fix discovered unrelated bugs - don't say "everything is done, EXCEPT there is a bug"
- When choosing port numbers: make them thematically related and memorable (leet-speak, pop culture)
- Keep infrastructure defaults boring (NATS, databases, etc.) to avoid common ports (8080, 8081)

### Template/File Management

- NEVER create duplicate templates/files to work around issues - fix the original
- ALWAYS identify and fix root cause of template/compilation errors
- ALWAYS use one shared base template instead of maintaining duplicates
- When encountering template issues, debug the actual problem rather than creating workarounds
