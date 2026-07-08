# Functional test plan — {feature / tracking key}

## Acceptance criteria → tests
| Acceptance criterion | Level (API / E2E) | Test name |
|----------------------|-------------------|-----------|
| {criterion} | API | `customer can view order history` |
| {criterion} | E2E | `customer places an order and sees it in history` |

## Cross-repo seams (if any)
| Seam (consumer → provider) | Contract location | Covered by |
|----------------------------|-------------------|------------|
| {orders-ui → orders-api} | {OpenAPI slice in orders-api} | contract test both sides |

## End-to-end journeys (use sparingly)
- {journey} — lives in {entry-point repo / e2e repo}; run with `{command}`

## Environment & data
- Environment: {test env / docker-compose / test-containers}
- Data: synthetic only — no real or production data in fixtures, traces, or screenshots.

## How to run
```
{exact command, e.g. npm test / mvn verify / pytest / npx playwright test}
```
