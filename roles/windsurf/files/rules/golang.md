---
trigger: model_decision
description: Applied when writing Go code. Microservices patterns, clean architecture, observability.
globs: **/*.go, **/go.mod, **/go.sum
---

# Go Development Rules

---

## Standards

| Setting | Value |
|---------|-------|
| Version | Go 1.22+ |
| Style | `go fmt`, `goimports` |
| Linter | golangci-lint |
| Testing | `go test` with table-driven tests |

---

## Project Structure

```
cmd/           # Application entrypoints
internal/      # Core logic (not exposed)
pkg/           # Shared utilities
api/           # gRPC/REST handlers
configs/       # Configuration schemas
test/          # Integration tests, mocks
```

---

## Clean Architecture

| Layer | Responsibility |
|-------|----------------|
| Handlers | HTTP/gRPC transport |
| Services | Business logic (use cases) |
| Repositories | Data access |
| Domain | Models, interfaces |

**Rules:**
- Public functions use interfaces, not concrete types
- Dependency injection via constructors
- Composition over inheritance

---

## Error Handling

```go
// Wrap errors with context
return fmt.Errorf("fetch user %d: %w", id, err)

// Check errors explicitly - never ignore
if err != nil {
    return nil, err
}
```

**Patterns:**
- Guard clauses at function top
- Wrap errors with `fmt.Errorf("context: %w", err)`
- Custom error types for domain errors
- Defer closing resources

---

## Concurrency

- Use `context.Context` for cancellation and deadlines
- Guard shared state with channels or sync primitives
- Avoid goroutine leaks — always have cancellation path
- Use `errgroup` for coordinated goroutines

---

## Observability (OpenTelemetry)

- Trace all incoming requests
- Propagate context through internal/external calls
- Use middleware to instrument HTTP/gRPC
- Log with trace IDs for correlation
- JSON-formatted structured logs

---

## Testing

**Patterns:**
- Table-driven tests with `t.Run()`
- Parallel execution with `t.Parallel()`
- Mock interfaces, not implementations
- Separate unit tests from integration tests

```go
func TestFunction(t *testing.T) {
    tests := []struct {
        name    string
        input   string
        want    string
        wantErr bool
    }{
        {"valid input", "foo", "bar", false},
        {"empty input", "", "", true},
    }
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            // test logic
        })
    }
}
```

---

## Security & Resilience

- Input validation on all external data
- Retries with exponential backoff on external calls
- Circuit breakers for service protection
- Rate limiting (consider distributed with Redis)
- Secure defaults (TLS 1.2+, strong ciphers)

---

## Anti-Patterns (Avoid)

- ❌ Ignoring errors with `_`
- ❌ Global state — use dependency injection
- ❌ Naked goroutines without cancellation
- ❌ Premature optimization — profile first
- ❌ Large interfaces — prefer small, focused ones
- ❌ `panic` for normal error handling
