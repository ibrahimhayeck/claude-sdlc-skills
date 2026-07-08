# Cross-repo / multi-service functional tests

For a change whose behaviour only exists when several services cooperate (the multi-repo
case). One tracking item (epic) owns the whole change; the tests prove the end-to-end flow works.

## Prefer contract tests over giant E2E

Full multi-service E2E is slow and flaky. Reach for it sparingly. First ask whether each
seam can be covered by a **contract test** instead:

- **Provider side** (the service that exposes the API/event): a test asserting it still
  produces the agreed shape. The contract (OpenAPI slice, JSON schema, or recorded fixture)
  lives in the provider repo.
- **Consumer side** (the service that calls it): a test asserting it works against that same
  contract, using a stub built from it.

If both sides pass their contract test, they'll integrate — without spinning up the whole
system. Add true end-to-end coverage only for the one or two critical user journeys that
must be proven whole.

## Where the end-to-end tests live

Pick one and record it in the PRD's Testing section so it's unambiguous:

1. **Entry-point repo** — the service that starts the flow (e.g. the API gateway or the
   web app) hosts the E2E tests and spins up the others via docker-compose/test containers.
   Good default.
2. **Dedicated `e2e` repo** — if you already have (or want) a standalone integration-tests
   repo, put cross-service journeys there. Best when many teams contribute.

Do **not** duplicate the same end-to-end test in every repo — it drifts and no one owns it.

## How it ties to the epic

- The PRD (at the configured docs location, keyed by the epic) names, in its Testing section:
  which seams are covered by contract tests, which journeys are covered end-to-end, and where
  those tests live.
- `/to-issues` creates a functional-test issue per affected repo (contract tests) plus one
  issue for the end-to-end journey in the chosen host repo.
- A cross-repo decision about the contract or event schema is an ADR in the **central** docs
  repo (`docs/adr/`), stubbed from each affected repo.

## Environment

- Spin services up with docker-compose / test-containers so the suite is reproducible and
  hermetic — never point cross-repo tests at a shared staging environment you don't control.
- Synthetic data only. No real or production data crosses any service boundary in a test.
