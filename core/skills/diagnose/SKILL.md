---
name: diagnose
description: A disciplined loop for hard bugs and performance regressions — build a fast feedback signal, reproduce, hypothesise, instrument, fix with a regression test, clean up. Use when the user reports a bug, says something is broken/throwing/failing/slow, or asks to debug or diagnose. Based on mattpocock/skills (MIT).
---

# Diagnose

A discipline for hard bugs. The whole game is the **feedback loop** — everything else is mechanical.

## 1. Build a feedback loop (spend most of your effort here)
Get a fast, deterministic, runnable pass/fail signal for the bug. In rough order: a failing
test at the right seam; a curl/HTTP script against a running server; a CLI run diffing output
against a known-good snapshot; a headless-browser script; replaying a captured payload; a
throwaway harness around the buggy path. Make it faster, sharper (assert the exact symptom),
and more deterministic (pin time, seed RNG, isolate FS/network). For flaky bugs, raise the
reproduction rate (loop it, add stress) until it's debuggable. If you truly can't build a
loop, stop and say so — ask for an artifact (HAR, logs, recording) rather than guessing.

## 2. Reproduce
Run the loop and confirm it shows the **user's** failure, reproducibly. Capture the exact symptom.

## 3. Hypothesise
Write **3–5 ranked, falsifiable hypotheses** before testing any: "if X is the cause, changing
Y makes it disappear." Show the list to the user — they often re-rank it instantly.

## 4. Instrument
Test one hypothesis at a time, changing one variable. Prefer a debugger/REPL over logs; tag
any debug logs with a unique prefix (e.g. `[DEBUG-a4f2]`) so cleanup is one search. For
performance, measure a baseline first, then bisect.

## 5. Fix + regression test
If there's a correct seam, turn the repro into a failing test, watch it fail, apply the fix,
watch it pass, then re-run the original scenario. If no good seam exists, say so — that's a
finding about the code's testability.

## 6. Clean up
Remove all tagged debug logs and throwaway harnesses, confirm the original repro is gone, and
note the correct hypothesis in the commit/PR message so the next person learns from it.

## Next
Once the fix is in with a regression test, offer to `/review` the change before it merges —
or resume `/tdd` if you were part-way through building a feature when the bug appeared.
