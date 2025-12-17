---
trigger: model_decision
description: Applied when designing or implementing REST APIs. Naming, methods, status codes.
globs:
---

# REST API Design Rules

---

## Conventions

| Convention | Standard |
|------------|----------|
| Resources | Plural nouns: `/users`, `/orders` |
| Versioning | URL path: `/api/v1/...` |
| Pagination | `?page=0&size=20` + `Link` header |

---

## HTTP Methods

| Method | Purpose | Success Code |
|--------|---------|--------------|
| GET | Read resource(s) | 200 |
| POST | Create resource | 201 |
| PUT | Update resource (full) | 200 |
| PATCH | Update resource (partial) | 200 |
| DELETE | Remove resource | 204 |

---

## Status Codes

| Code | Use For |
|------|---------|
| 200 | Success (with body) |
| 201 | Created |
| 204 | Success (no body) |
| 400 | Bad request / validation error |
| 401 | Unauthorized (not authenticated) |
| 403 | Forbidden (not authorized) |
| 404 | Not found |
| 409 | Conflict (duplicate, version mismatch) |
| 500 | Internal server error |

---

## Data Transfer

- Use DTOs for request/response (never expose entities directly)
- Document with OpenAPI/Swagger annotations
- Use consistent error response format:

```json
{
  "error": "VALIDATION_ERROR",
  "message": "Invalid input",
  "details": [
    {"field": "email", "message": "must be valid email"}
  ]
}
```

---

## Anti-Patterns (Avoid)

- ❌ Verbs in URLs: `/getUsers`, `/createOrder`
- ❌ Singular resource names: `/user` instead of `/users`
- ❌ Exposing entity IDs that are auto-increment (use UUIDs)
- ❌ Returning 200 for errors with error message in body
- ❌ Inconsistent field naming (pick camelCase or snake_case)
