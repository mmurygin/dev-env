---
trigger: model_decision
description: Applied when implementing or modifying test code. Rules for test design, Given/When/Then format, and coverage approach.
globs:
---

# Test Strategy Rules

Apply when writing or modifying tests. Scale rigor to task size.

---

## 1. When to Create a Test Perspective Table

Create a **test perspective table** when:
- Adding new functionality with multiple branches/conditions
- Implementing validation logic
- Working with boundary-sensitive operations (pagination, limits, ranges)

**Skip** for: trivial changes, single-branch fixes, message/label updates.

### Table Format

| Case | Input / Condition | Type | Expected | Notes |
|------|-------------------|------|----------|-------|
| TC-01 | Valid input | Normal | Success | - |
| TC-02 | Empty string | Boundary | Validation error | - |
| TC-03 | NULL | Boundary | Throws/rejects | - |
| TC-04 | Max+1 | Boundary | Overflow error | - |

**Type categories:**
- **Normal** – happy path, main scenarios
- **Boundary** – 0, min, max, ±1, empty, NULL
- **Error** – validation failures, exceptions, external failures

---

## 2. Test Implementation

### Required Coverage

1. **Normal cases** – at least one per main code path
2. **Error cases** – at least one per function (validation, exceptions)
3. **Boundaries** – when applicable: 0, min, max, ±1, empty, NULL

### Structure: Given / When / Then

Every test must have this structure (comments or code blocks):

```
// Given: [preconditions/setup]
// When:  [action under test]
// Then:  [expected outcome/assertions]
```

### Error Verification

For exception/error tests, verify:
- Exception **type** (class/name)
- Error **message** or code
- For validation: field name if available

---

## 3. Coverage Targets

| Task Type | Branch Coverage Target |
|-----------|------------------------|
| New feature | 80%+ (aim for 100%) |
| Bug fix | Cover the fixed path + regression |
| Refactor | Maintain existing coverage |

If 100% is impractical, prioritize:
1. Business-critical paths
2. Error handling branches
3. Security-related code

---

## 4. External Dependencies

When testing code with external dependencies (API, DB, messaging):

1. **Mock failures** – simulate timeouts, errors, unavailable states
2. **Verify retry/fallback** – if implemented
3. **Test happy + failure paths** – don't just test success

---

## 5. Workflow Integration

**Before Implementation:**
1. If complex: present test perspective table first
2. Identify test file location (follow project conventions)
3. Check existing test patterns in the codebase

**After Implementation:**
1. Run tests and provide the exact command used
2. Check coverage if tooling available
3. Summarize: tests added, coverage change, any gaps

---

## 6. Anti-Patterns (Avoid)

- ❌ Testing implementation details instead of behavior
- ❌ Brittle assertions on exact error messages that may change
- ❌ Skipping error cases because "it's obvious"
- ❌ Copy-pasting tests without understanding what they verify
- ❌ Mocking so heavily that no real code runs
- ❌ Tests that pass but don't actually assert anything meaningful
- ❌ Testing only the happy path

---

## 7. Quick Reference

**Minimum test set for any change:**
- ✅ At least 1 normal case
- ✅ At least 1 error/boundary case
- ✅ Given/When/Then structure
- ✅ Exception type + message verified (for error paths)

**For substantial features, also:**
- ✅ Test perspective table
- ✅ All boundary values considered
- ✅ External dependency failures mocked
- ✅ Coverage report reviewed
