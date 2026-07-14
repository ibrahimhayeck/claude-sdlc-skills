# Testing — from setup to execution

How testing flows through the framework. The short version: **configure the frameworks once,
then every stage honours that choice — with auto-detect as the default.**

```
1 setup ─▶ 2 plan ─▶ 3 unit ─▶ 4 e2e ─▶ 5 review(+security) ─▶ 6 execute (CI)
 testing.md   PRD      /tdd    /functional-test                    runner
                                    │ something breaks
                                    └─▶ /diagnose → regression test → back to review
```

## Who picks the framework (the flexible part)

`/tdd` and `/functional-test` **auto-detect** the framework from each repo by default — they
read the manifest and existing tests and never add a dependency without asking. To pin a
choice, set it in `docs/agents/testing.md`. Resolution order:

**repo `testing.md` → org `testing-defaults.md` → auto-detect**

So one repo can lock its own tools, a whole **set of repos** can share defaults via a
`testing-defaults.md` in the central docs repo, or you can leave everything on `auto`. No code
changes — just edit the config.

## The levels of tests

| Level | Skill | Default framework | What it proves |
|-------|-------|-------------------|----------------|
| Unit / integration | `/tdd` | auto (vitest, jest, pytest, junit5, xunit, …) | each unit behaves, through its public interface |
| API / service | `/functional-test` | auto (supertest, rest-assured, httpx, …) | the endpoint behaves end-to-end |
| Browser E2E | `/functional-test` | Playwright | the user journey works in a real browser |
| Cross-repo contract | `/functional-test` | contract file + tests on both sides | services still integrate without a full spin-up |

## Stage by stage

**1. Setup — decide the frameworks (once per repo).** `/setup-skills` writes
`docs/agents/testing.md` with the three levels and a run command each; all default to `auto`.

**2. Plan — decide *what* to test.** During `/grill-with-docs` and `/to-prd`, the PRD's
"Testing Decisions" section records which behaviours get unit vs functional tests and which
seams get contract tests. The `functional-test-plan.md` template maps each acceptance
criterion to a specific test, so coverage is deliberate.

**3. Build — unit/integration with `/tdd`.** Red-green-refactor, one behaviour at a time,
using the pinned or detected unit framework. Tests exercise behaviour through public
interfaces so they survive refactors.

**4. Prove end-to-end — `/functional-test`.** Resolves the framework (config → org → auto),
then writes acceptance tests through the *real* interface: API/service tests, Playwright E2E,
and — for multi-service changes — consumer- and provider-side **contract tests** against the
shared contract file (catches integration breakage without spinning up the whole system).

**5. Review + security gate — `/review`.** Checks that the acceptance criteria have tests,
then asks the safety-gate question ("does this touch auth or data?") and runs
`/security-review` when the answer is yes.

**6. Execute — CI.** Tests run with the `runner` command from `testing.md`
(`npm test`, `mvn test`, `pytest`, `npx playwright test`, …). Fast unit tests gate every
change; E2E usually runs as a separate CI job/tag but still gates merges to main; contract
tests run on both services so a provider change that breaks a consumer fails *before* deploy.

**↺ Debug — `/diagnose`.** When something breaks, it builds a fast failing test that
reproduces the bug, fixes it, and leaves a **regression test** so it can't return — then
hands back to `/review`.

## Persistence

All of it — unit tests, functional/E2E tests, and the contract files — is committed to the
repo. That's what protects future iterations: the next change (or the next agent) runs the
same suite, and the contract stays the shared source of truth as services evolve.

## Data guardrail (every level)

Synthetic data only — never real or production data (no PHI/PII in regulated domains) — and
tests run against a dedicated test environment, never production.
