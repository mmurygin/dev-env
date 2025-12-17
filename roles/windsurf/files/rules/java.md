---
trigger: model_decision
description: Applied when writing Java code. Spring Boot patterns, testing, security.
globs: **/*.java, **/pom.xml
---

# Java Development Rules

---

## Build & Style

| Setting | Value |
|---------|-------|
| Build | Maven |
| Version | Java 17+ (records, sealed classes, pattern matching) |
| Framework | Spring Boot 3.x |
| Style | Google Java Style Guide |
| DI | Constructor injection (not field injection) |
| Boilerplate | Lombok annotations |

---

## Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Classes | PascalCase | `UserController`, `OrderService` |
| Methods | camelCase | `findUserById`, `isOrderValid` |
| Constants | UPPER_SNAKE | `MAX_RETRY_ATTEMPTS`, `DEFAULT_PAGE_SIZE` |
| Packages | lowercase | `com.company.project.service` |

---

## Project Structure

```
controllers/    # REST endpoints (@RestController)
services/       # Business logic (@Service)
repositories/   # Data access (@Repository)
models/         # Entities, DTOs
configurations/ # Spring configs (@Configuration)
```

---

## Spring Boot Patterns

**Annotations:**
- `@SpringBootApplication` for main class
- `@RestController` + `@RequestMapping` for APIs
- `@Service` for business logic
- `@ConfigurationProperties` for type-safe config

**Exception Handling:**
- Use `@ControllerAdvice` + `@ExceptionHandler` globally
- Return proper HTTP status codes

**Configuration:**
- Use `application.yml` with Spring Profiles (dev, test, prod)
- Environment-specific configs via profiles

---

## Code Patterns

- Use `Optional` for nullable returns (never return null)
- Use try-with-resources for `AutoCloseable`
- Prefer immutable objects where practical
- Use records for simple data carriers
- Use Bean Validation (`@Valid`, `@NotNull`, `@Size`)

---

## Data Access

- Spring Data JPA for database operations
- Flyway or Liquibase for migrations
- Proper entity relationships and cascading

---

## Testing

**Command:** `mvn test` (never pipe output to head/tail)

| Test Type | Annotation | Use For |
|-----------|------------|---------|
| Unit | JUnit 5 + Mockito | Services, utilities |
| Web layer | `@WebMvcTest` + MockMvc | Controllers |
| Repository | `@DataJpaTest` | JPA repositories |
| Integration | `@SpringBootTest` | Full context |

---

## Security & Performance

**Security:**
- Spring Security for auth
- BCrypt for password encoding
- CORS configuration when needed

**Performance:**
- `@Async` for non-blocking operations
- Spring Cache abstraction for caching
- Database indexing and query optimization

---

## Logging & Monitoring

- SLF4J with Logback
- Log levels: ERROR, WARN, INFO, DEBUG
- Spring Boot Actuator for metrics
- Springdoc OpenAPI for API docs

---

## Anti-Patterns (Avoid)

- ❌ Field injection with `@Autowired`
- ❌ Returning null instead of `Optional.empty()`
- ❌ Catching generic `Exception` without re-throwing
- ❌ Mutable objects where immutable would work
- ❌ Raw types (use generics)
- ❌ Business logic in controllers
- ❌ Exposing entities directly (use DTOs)
