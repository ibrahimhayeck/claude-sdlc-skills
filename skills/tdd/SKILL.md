---
name: tdd
description: Test-driven development with a red-green-refactor loop, one vertical slice at a time. Use when the user wants to build a feature or fix a bug test-first, mentions red-green-refactor, or wants unit/integration tests. Pairs with functional-test for the acceptance layer. Based on mattpocock/skills (MIT).
---

# Test-Driven Development

## Philosophy
**Tests verify behaviour through public interfaces, not implementation details.** Code can
change entirely; tests shouldn't. A good test reads like a specification — "member can
submit a claim with a valid amount" — and survives refactors. A bad test mocks internal
collaborators, tests private methods, or asserts via a side channel (e.g. querying the DB
directly). Warning sign: the test breaks on refactor while behaviour is unchanged.

This skill covers **unit/integration tests** you write as you build. For acceptance tests
against the real HTTP/browser interface — including multi-service flows — use
`/functional-test`.

## Anti-pattern: horizontal slices
**Do NOT write all tests first, then all implementation.** Batched tests verify *imagined*
behaviour and test the *shape* of things, not real behaviour.

```
WRONG (horizontal):  RED: test1..5   then GREEN: impl1..5
RIGHT (vertical):    test1→impl1, test2→impl2, test3→impl3, …
```

## Workflow

### 1. Planning
Explore using the domain glossary (`CONTEXT.md`) so test/interface names match the project
language; respect ADRs in the area. Before writing code:
- Confirm the interface changes needed.
- Confirm which behaviours to test (prioritize — you can't test everything; focus on
  critical paths and complex logic).
- Look for **deep modules**: a simple interface over a deep implementation.
- Design interfaces for testability (inject dependencies; avoid hidden global state).
- List behaviours (not implementation steps) and get user approval.

### 2. Tracer bullet
Write ONE test for ONE behaviour → it fails (RED) → minimal code to pass (GREEN). Proves the
path works end-to-end.

### 3. Incremental loop
For each remaining behaviour: RED (next test fails) → GREEN (minimal code passes). Rules:
one test at a time; only enough code to pass; don't anticipate future tests; assert on
observable behaviour.

### 4. Refactor (only while GREEN)
After tests pass: extract duplication, deepen modules, apply SOLID where natural, and run
tests after each step. **Never refactor while RED.**

## Mocking guidance
Mock only what you don't own or what's slow/non-deterministic (third-party APIs, clock,
randomness). Do NOT mock the module under test or your own internal collaborators — that
couples tests to structure. Prefer real objects and in-memory/test databases.

## Per-cycle checklist
```
[ ] Test describes behaviour, not implementation
[ ] Test uses the public interface only
[ ] Test would survive an internal refactor
[ ] Code is minimal for this test
[ ] No speculative features added
```

## Data note
Use synthetic data only — no real or production data in tests or fixtures (no PHI/PII in
regulated domains).

## Next step (core chain)
When the feature is built and green, offer to verify and check it: `/functional-test` for
acceptance/E2E coverage where it's warranted, then `/review` before it merges. Offer, don't
auto-run.
