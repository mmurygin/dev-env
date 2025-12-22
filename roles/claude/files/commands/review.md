# Merge Request Review Command

You will conduct a thorough, systematic code review of a GitLab Merge Request. NEVER propose improvements if you are not sure they add value.

Follow this process:

## Step 1: Extract MR Information from URL

The user will provide a GitLab MR URL in one of these formats:
- `https://gitlab.com/owner/project/-/merge_requests/123`
- `https://gitlab.example.com/owner/project/-/merge_requests/456`

Extract:
- **project_id**: `owner/project` (e.g., `gitlab-org/gitlab`)
- **merge_request_iid**: The MR number (e.g., `123`)

## Step 2: Fetch MR Data

Use the GitLab MCP tools to gather comprehensive information:

1. **Get MR details**:
   ```
   mcp__gitlab__gitlab_get_merge_request(project_id, merge_request_iid)
   ```
   - Review: title, description, labels, source/target branches, author, reviewers

2. **Get code changes**:
   ```
   mcp__gitlab__gitlab_get_merge_request_diffs(project_id, merge_request_iid)
   ```
   - Analyze all file-level changes with context

3. **Get existing discussions**:
   ```
   mcp__gitlab__gitlab_get_merge_request_all_comments(project_id, merge_request_iid)
   ```
   - Review existing feedback to avoid duplication

## Step 3: Systematic Code Review

Conduct a comprehensive review across these dimensions:

### 🔒 Security Review (CRITICAL - Review First)

**Look for:**
- SQL injection vulnerabilities (unparameterized queries, string concatenation)
- XSS vulnerabilities (unescaped user input in HTML/JS)
- Authentication/authorization bypasses
- Hardcoded secrets, API keys, passwords, tokens
- Insecure cryptography (weak algorithms, hardcoded keys)
- Path traversal vulnerabilities (user-controlled file paths)
- Command injection (unsanitized input to shell commands)
- Insecure deserialization
- Missing input validation at system boundaries
- CSRF token absence in state-changing operations
- Excessive permissions or privilege escalation
- Sensitive data in logs or error messages
- Unsafe use of `eval()`, `exec()`, or similar
- Race conditions in security-critical code

**For each security issue found:**
- Severity: CRITICAL/HIGH/MEDIUM/LOW
- Specific line numbers
- Exploitation scenario
- Recommended fix with code example

### 🐛 Bug Detection

**Look for:**
- Null pointer/undefined reference errors
- Off-by-one errors in loops and array access
- Race conditions and concurrency issues
- Resource leaks (unclosed files, connections, streams)
- Infinite loops or recursion without termination
- Exception handling issues (swallowed exceptions, broad catches)
- Type mismatches and implicit conversions
- Logic errors in conditionals (wrong operators, inverted logic)
- Edge cases not handled (empty lists, zero values, boundary conditions)
- Incorrect algorithm implementation
- Data corruption scenarios
- State management issues

### ⚡ Performance & Scalability

**Look for:**
- N+1 query problems
- Inefficient algorithms (O(n²) where O(n log n) possible)
- Missing database indexes
- Unbounded loops or recursion
- Memory leaks
- Excessive object allocations
- Blocking operations in async code
- Missing pagination for large datasets
- Inefficient data structures
- Redundant computations
- Missing caching opportunities

### 🏗️ Architecture & Design

**Look for:**
- Violation of SOLID principles
- Tight coupling between modules
- Missing abstractions or wrong abstraction levels
- God classes/functions (too many responsibilities)
- Inconsistent with existing patterns
- Missing error boundaries
- Lack of separation of concerns
- Circular dependencies
- Hard-to-test code (testability issues)
- Missing interfaces/contracts

### 📝 Code Quality & Maintainability

**Look for:**
- Duplicate code (DRY violations)
- Magic numbers without constants
- Unclear variable/function names
- Functions longer than 50 lines
- High cyclomatic complexity
- Missing error messages or poor error handling
- Inconsistent code style
- Dead code or commented-out code
- TODOs without context or tickets
- Poor readability

### 🧪 Testing Coverage

**Review:**
- Are there tests for new functionality?
- Are edge cases covered?
- Are error paths tested?
- Are tests testing behavior, not implementation?
- Are there integration tests where needed?
- Do tests have clear Given/When/Then structure?
- Are mocks used appropriately (not over-mocked)?
- Are test names descriptive?

### 📚 Documentation

**Check for:**
- Public API documentation
- Complex algorithm explanations
- Non-obvious business logic comments
- README updates if needed
- API/schema changes documented
- Migration guides for breaking changes
- Missing ABOUTME: comments in new files

### ✅ Best Practices Compliance

**Verify:**
- Follows language idioms and conventions
- Proper error handling patterns
- Appropriate logging levels
- Configuration externalized (no hardcoded values)
- Backwards compatibility maintained
- Accessibility standards (for UI changes)
- Internationalization considerations

## Step 4: Review MR Metadata

**Check:**
- Does title clearly describe the change?
- Is description complete with context and testing notes?
- Are labels appropriate?
- Is target branch correct?
- Are related issues linked?
- Is this a reasonable size for review (< 400 lines preferred)?

## Step 5: Generate Structured Review

Provide feedback in this format:

```markdown
# MR Review: [Title]

**Project**: [project_id]
**MR**: ![merge_request_iid](url)
**Author**: [author]
**Status**: [Approve / Request Changes / Comment]

## Executive Summary
[2-3 sentences: what changes, overall assessment, main concerns if any]

## Critical Issues 🔴
[Issues requiring immediate attention before merge - security, major bugs, data loss risks]

### Issue 1: [Title]
**Severity**: CRITICAL/HIGH
**File**: `path/to/file.ext:line_number`
**Problem**: [Clear description]
**Impact**: [What could go wrong]
**Fix**: [Specific recommendation with code example if possible]

## Important Findings 🟡
[Significant issues - bugs, performance problems, design concerns]

## Suggestions 🟢
[Nice-to-haves - code quality improvements, refactoring opportunities]

## Positive Highlights ✨
[What was done well - good patterns, solid tests, clear code]

## Testing Review
- [ ] Unit tests present and adequate
- [ ] Edge cases covered
- [ ] Error scenarios tested
- [ ] Integration tests if needed

## Security Checklist
- [ ] No hardcoded secrets
- [ ] Input validation at boundaries
- [ ] No SQL injection vulnerabilities
- [ ] No XSS vulnerabilities
- [ ] Authentication/authorization correct
- [ ] Sensitive data handled properly

## Questions ❓
[Clarifications needed from the author]

## Recommendation
**[APPROVE / REQUEST CHANGES / COMMENT]**

[Final verdict with reasoning]
```

## Step 6: Tone & Communication Guidelines

**Be:**
- **Constructive**, not critical - focus on the code, not the person
- **Specific** - reference exact line numbers and files
- **Educational** - explain *why* something is an issue
- **Balanced** - highlight good aspects, not just problems
- **Actionable** - provide clear next steps
- **Respectful** - assume good intent, ask questions

**Avoid:**
- Vague comments like "this could be better"
- Nitpicking on style (unless security/readability impact)
- Scope creep (suggest future work as separate issues)
- Being condescending or dismissive

## Step 7: Priority Guidelines

**CRITICAL Issues (Block Merge):**
- Security vulnerabilities
- Data loss risks
- Breaking changes without migration
- Crashes or exceptions in core paths
- Performance regressions > 50%

**Request Changes (Should Fix Before Merge):**
- Bugs in new functionality
- Missing tests for new code
- Significant performance issues
- Architecture violations
- Poor error handling

**Suggestions (Nice to Have):**
- Code quality improvements
- Refactoring opportunities
- Documentation enhancements
- Minor optimizations

## Step 8: Output

After completing the review, present the structured markdown review to the user and ask if they would like you to:
1. Post the review as a comment on the MR
2. Create individual threaded discussions for each issue
3. Just keep it local for now

---

**Remember**: The goal is to help ship high-quality, secure, maintainable code while supporting the author's growth. Be thorough but kind.
