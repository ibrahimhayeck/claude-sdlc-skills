---
name: tdd
description: Build a feature or fix a bug test-first with a red-green-refactor loop, one small behaviour at a time. Use when the user wants to implement something with tests, mentions TDD or red-green-refactor, or wants confidence the code works. Based on mattpocock/skills (MIT).
---

# Test-Driven Development

**Tests verify behaviour through public interfaces, not implementation details.** A good test
reads like a specification and survives refactors; a bad test breaks when you rename an
internal function even though behaviour is unchanged.

## The loop — one behaviour at a time (never batch)

```
RED    write ONE failing test for ONE behaviour
GREEN  write the minimal code to make it pass
REPEAT next behaviour
```

Do **not** write all the tests first, then all the code — batched tests describe imagined
behaviour and end up testing shapes, not real behaviour.

## Per cycle
- Test describes behaviour, uses the public interface only, and would survive an internal refactor.
- Write only enough code to pass the current test; don't anticipate future ones.
- Mock only what you don't own or what's slow/non-deterministic (third-party APIs, clock,
  randomness) — never your own internal collaborators.

## Refactor (only while green)
After tests pass: remove duplication, simplify interfaces, run tests after each step. Never
refactor while a test is red.

## Before you start
Confirm with the user which behaviours matter most (you can't test everything — focus on
critical paths). If names have a domain meaning, use the repo's `CONTEXT.md` vocabulary. Use
synthetic data only — never real or production data in tests.

If the plan still feels fuzzy when you start, offer `/grill-with-docs` first to align.

## Next
When the feature is built and the tests are green, offer to check it before it merges:
"Tests pass — want me to `/review` the change?" Offer, don't auto-run.
