---
name: functional-test
description: Write and run functional tests that verify a feature against its acceptance criteria through its real external interfaces — HTTP APIs/services and browser flows (Playwright) — including flows that span multiple services. Use when the user wants functional tests, acceptance tests, API/service tests, end-to-end (E2E) tests, Playwright tests, black-box tests, or wants to verify a PRD's acceptance criteria. Language-agnostic: detects the repo's stack rather than assuming one.
---

# Functional Testing

Functional tests verify **what the system does for a user or a caller**, through its real
external interface, with as little mocking as possible. They are the acceptance layer that
sits above `/tdd`'s unit/integration tests: `/tdd` proves the units are correct;
`/functional-test` proves the feature works end-to-end against its contract.

**Test the contract, not the code.** A functional test should survive any refactor that
keeps the observable behaviour the same. If it breaks when internal structure changes but
behaviour didn't, it's testing the wrong thing.

Two kinds, chosen by what the feature exposes:

- **API / service tests** — for backend services and endpoints. See [API-TESTS.md](./API-TESTS.md).
- **Web E2E (Playwright)** — for user-facing browser flows. See [E2E-PLAYWRIGHT.md](./E2E-PLAYWRIGHT.md).

For a change that spans several repos/services, see [CROSS-REPO.md](./CROSS-REPO.md).

## Step 0 — Which framework? (config first, then detect)

Resolve the API and E2E frameworks in this order and stop at the first that answers:

1. **`docs/agents/testing.md`** in this repo — if it pins a `framework`/`runner` (anything
   not `auto`), use exactly that. This is how a developer locks a repo to a specific choice.
2. **Org default** — if `testing.md` says `inherit`, read `testing-defaults.md` in the
   central docs repo. This is how you standardise a *set* of repos.
3. **Auto-detect** (the default) — the team is polyglot (Node/TS, Java, Python, .NET, Ruby,
   React, …), so match the repo's **existing** conventions:
   - Read the manifest (`package.json`, `pom.xml`/`build.gradle`, `pyproject.toml`/
     `requirements.txt`, `*.csproj`, `Gemfile`) for language + installed test tooling.
   - Find existing functional/E2E tests and copy their structure, naming, and runner. **Do
     not introduce a new framework if one is already in use.**
   - If none exists, propose one and confirm before adding a dependency: API → the language's
     standard HTTP-level tool (supertest/`fetch`+vitest for Node, REST-assured/`WebTestClient`
     for JVM, `httpx`+pytest for Python, `WebApplicationFactory` for .NET); Web E2E →
     **Playwright** via `@playwright/test` (the default).

Run tests with the `runner` command from `testing.md` when set. Use the repo's domain
glossary (`CONTEXT.md`) so test names speak the project's language. Respect ADRs in the area.

## Workflow

### 1. Anchor on acceptance criteria
Start from the issue / PRD acceptance criteria. If they're vague, run a short
`/grill-with-docs` pass first — you can't write a good functional test against a fuzzy
spec. List the user-observable behaviours to cover and confirm priorities with the user.
**You can't test everything** — focus on critical paths and the acceptance criteria, not
every edge case.

### 2. Decide the level
- Pure request/response or business logic reachable via an endpoint → **API test**.
- Something a person does in a browser → **Playwright E2E**.
- A flow that only works when several services cooperate → **cross-repo** (see doc).
Prefer the lowest level that still proves the behaviour: API tests are faster and less
flaky than E2E. Use E2E only for genuinely UI-driven behaviour.

### 3. Write one test at a time (tracer bullet)
One behaviour → one test → make it pass → repeat. Do not batch-write a suite of imagined
tests; each test should reflect behaviour you've actually exercised.

Each test should:
- drive the system through its **public interface only** (HTTP call, page interaction) —
  never reach into a database, private method, or internal module to assert;
- set up its own data and clean up after itself (idempotent, order-independent);
- read like a specification: `member can view claim history`, not `GET /claims returns 200`.

### 4. Make failures useful
On failure the test must say *what behaviour broke* and *how* — assert on meaningful
values, not just status codes. For E2E, capture trace/screenshot on failure.

### 5. Wire into the feedback loop
Add the tests to the command the team already runs in CI (`npm test`, `mvn verify`,
`pytest`, `dotnet test`, `npx playwright test`). Confirm they run green locally, then note
the exact command in the PRD's Testing section so reviewers can reproduce.

## Data & environment guardrails
- **Never use real or production data.** Use synthetic fixtures only — no personal,
  sensitive, or regulated data in test data, fixtures, logs, traces, or screenshots.
  (In regulated domains — health, finance — this is a hard requirement, e.g. no PHI/PII.)
- Point tests at a dedicated test environment or ephemeral instance — never production or a
  shared system you don't control.
- Redact tokens and secrets from Playwright traces and network logs before they're stored.

## What "done" looks like
- Every acceptance criterion in the issue has at least one functional test.
- Tests pass through the public interface with no internal reach-around.
- Tests are runnable with one documented command and are green in CI.
- No real or production data anywhere in the test assets.
