---
name: diagnose
description: Disciplined diagnosis loop for hard bugs and performance regressions. Reproduce → minimise → hypothesise → instrument → fix → regression-test. Use when the user says "diagnose"/"debug this", reports a bug, says something is broken/throwing/failing, or describes a performance regression. Based on mattpocock/skills (MIT).
---

# Diagnose

A discipline for hard bugs.

**Right-size first.** For an obvious bug (a typo, a visible off-by-one), just fix it and add a
regression test — skip the loop. Reserve the six phases below for **hard, intermittent, or
performance** bugs where the cause isn't obvious.

When exploring the codebase, use the project's domain glossary (`CONTEXT.md`) to get a clear
mental model of the relevant modules, and check ADRs in the area you're touching.

## Phase 1 — Build a feedback loop

**This is the skill.** Everything else is mechanical. If you have a fast, deterministic,
agent-runnable pass/fail signal for the bug, you will find the cause. If you don't, no amount
of staring at code will save you. Spend disproportionate effort here. **Be aggressive. Be
creative. Refuse to give up.**

Ways to construct one, in roughly this order:

1. **Failing test** at whatever seam reaches the bug (unit, integration, e2e).
2. **Curl / HTTP script** against a running dev server.
3. **CLI invocation** with a fixture input, diffing stdout against a known-good snapshot.
4. **Headless browser script** (Playwright/Puppeteer) asserting on DOM/console/network.
5. **Replay a captured trace** — save a real request/payload/event log and replay it in isolation.
6. **Throwaway harness** — spin up a minimal subset (one service, mocked deps) exercising the path.
7. **Property / fuzz loop** — for "sometimes wrong output", run 1000 random inputs.
8. **Bisection harness** — automate "boot at state X, check, repeat" for `git bisect run`.
9. **Differential loop** — run the same input through old vs new (or two configs) and diff.
10. **Human-driven script** — last resort. If a person must click, drive them with
    [scripts/hitl-loop.template.sh](./scripts/hitl-loop.template.sh) so the loop stays structured.

**Iterate on the loop itself.** Make it faster (cache setup, narrow scope), sharper (assert
the specific symptom), and more deterministic (pin time, seed RNG, isolate FS, freeze
network). A 2-second deterministic loop is a debugging superpower.

**Non-deterministic bugs:** the goal is a higher reproduction rate, not a clean repro. Loop
the trigger 100×, parallelise, add stress, narrow timing windows. A 50%-flake bug is
debuggable; 1% is not.

**If you genuinely cannot build a loop:** stop and say so. List what you tried. Ask for
environment access, a captured artifact (HAR, log dump, core dump, timed screen recording),
or permission to add temporary instrumentation. Do **not** hypothesise without a loop.

## Phase 2 — Reproduce
Run the loop. Confirm it produces the **user's** failure mode (not a nearby one), that it's
reproducible (or high-rate for flaky bugs), and that you've captured the exact symptom.

## Phase 3 — Hypothesise
Generate **3–5 ranked, falsifiable hypotheses** before testing any. Each states a prediction:
"If X is the cause, then changing Y makes the bug disappear." Show the ranked list to the
user before testing — they often re-rank instantly ("we just deployed #3"). Don't block if
the user is away.

## Phase 4 — Instrument
Each probe maps to a specific prediction. **Change one variable at a time.** Prefer a
debugger/REPL over logs; use targeted logs at distinguishing boundaries; never "log
everything and grep". **Tag every debug log** with a unique prefix (e.g. `[DEBUG-a4f2]`) so
cleanup is one grep. For performance, measure first (baseline, profiler, query plan), then bisect.

## Phase 5 — Fix + regression test
**Always leave a regression test.** When a **correct seam** exists (one that exercises the real
bug pattern), write it *before* the fix: turn the repro into a failing test → watch it fail →
apply the fix → watch it pass → re-run the Phase 1 loop against the original scenario. If no
correct seam exists, add the closest test you can **and flag the missing seam as a finding** —
don't ship the fix with no guard at all.

## Phase 6 — Cleanup + post-mortem
- [ ] Original repro no longer reproduces
- [ ] Regression test passes (or absence of seam is documented)
- [ ] All `[DEBUG-...]` instrumentation removed (grep the prefix)
- [ ] Throwaway prototypes deleted or clearly marked
- [ ] The correct hypothesis is stated in the commit/PR message

Before declaring it fixed, **re-run the loop and read the output** — "should be fixed" isn't
fixed (`/verify`).

## Next step (core chain)
Once the fix is in with a regression test, offer to `/review` the change before it merges —
or resume `/tdd` if you were mid-feature. If the bug's root cause was structural, hand off to
`/improve-codebase-architecture` with the specifics (after the fix, not before).

**Then ask: what would have prevented this bug?** If the answer is architectural (no good
test seam, tangled callers, hidden coupling), hand off to `/improve-codebase-architecture`
with the specifics — *after* the fix is in, when you know the most.
