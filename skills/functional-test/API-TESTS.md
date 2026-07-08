# API / Service Functional Tests

Black-box tests that drive a service through its HTTP (or gRPC/queue) interface and assert
on the response and observable side effects. No mocking of the service under test; mock
only *third-party* systems you don't own.

## Principles

- **Public interface only.** Send a real request; assert on the real response. Never query
  the service's database directly to check state — call the endpoint that exposes it. If
  there's no way to observe an effect through the API, that's a design smell worth raising.
- **Own your data.** Each test seeds what it needs (via the API where possible, or a
  documented fixture route) and tears it down. Tests must pass in any order and in parallel.
- **Assert on meaning.** Check the body, the important fields, and status — not just `200`.
- **Test the contract's edges.** Happy path, validation errors (`400`), auth (`401`/`403`),
  not-found (`404`), and idempotency/conflict where relevant.
- **Real boundaries, faked externals.** Use a test DB / ephemeral container for the
  service's own storage. Stub only external partner APIs (with a recorded contract), never
  the service under test.

## Pattern (pseudocode — mirror your repo's actual runner)

```
describe("member can view their claim history"):
  before: seed a member with two claims via the API/fixture
  it("returns the member's claims, newest first"):
    res = GET /members/{id}/claims  with a valid member token
    expect res.status == 200
    expect res.body.claims has length 2
    expect res.body.claims[0].submittedAt > res.body.claims[1].submittedAt
  it("rejects a caller without a token"):
    res = GET /members/{id}/claims  with no auth
    expect res.status == 401
  after: delete the seeded member
```

## Stack cheatsheet (use what's already in the repo)

| Stack | Common tools |
|-------|--------------|
| Node / TS | `vitest`/`jest` + `supertest` or native `fetch` against a test server |
| Java / Spring | JUnit 5 + `WebTestClient` / RestAssured / `@SpringBootTest` |
| Python | `pytest` + `httpx`/`requests`, `TestClient` for FastAPI |
| .NET | xUnit + `WebApplicationFactory` / `HttpClient` |
| Ruby | RSpec + `rack-test` / `Rspec.request` |

Confirm before adding any new dependency. If the repo already tests APIs a certain way,
match it exactly.

## Contract tests (when services depend on each other)

When one service calls another, add a **contract test**: the consumer asserts the shape it
expects, the provider asserts it still produces that shape. This catches cross-repo breakage
before integration. Record the contract (an OpenAPI slice or a fixture) in the provider repo
and reference it from the consumer. See [CROSS-REPO.md](./CROSS-REPO.md).
