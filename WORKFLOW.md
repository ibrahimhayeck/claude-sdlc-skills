# How this works — and how to right-size it

You **describe your work in plain language**; the matching skill fires, announces itself
("Using the X skill…"), does its part, and **offers** the next step. You approve each hop and
can skip any — say "just do it" to bypass the ceremony.

## The loop

```
align ─▶ build ─▶ test ─▶ review ─▶ verify ─▶ finish
grill    tdd     func-    review     verify    finish
-with-           test                (evidence  (land it)
docs                                  gate)
                     ▲ bug? ─▶ diagnose        ▲ auth/data? ─▶ security-review
```

`diagnose` (debug) and `improve-codebase-architecture` (health) are reflexes you reach for
when needed, not fixed steps.

## Right-size the ceremony to the change

Not every change deserves the full loop. Match the process to the risk:

| Change | Do this |
|--------|---------|
| **Trivial** — typo, comment, config bump, one-line fix | Make the change → `/verify` (run the check). Skip grilling, PRD, and issues. |
| **Standard** — a feature or bug in one repo | Full loop: `/grill-with-docs` → `/tdd` → `/functional-test` (if user-facing) → `/review` → `/verify` → `/finish`. |
| **Risky / cross-cutting / multi-repo** — auth, data, schema, public API, or several repos | Full loop **plus** `/to-prd` + `/to-issues` to plan the slices, and `/security-review` at review time. |

**Rule of thumb:** the smaller and safer the change, the less process. The bigger the blast
radius, the more up-front alignment and review.

## Two gates that always apply (any size)

- **`/verify`** — never claim "done / passing / fixed" without running the check this turn and
  reading the output.
- **No real or production data** in tests, fixtures, logs, or screenshots (PHI/PII in regulated
  domains). Synthetic only.

## You choose the flow (three ways)

The lane isn't locked — you decide, and the agent **announces which lane it's taking** so you
can redirect:

1. **Let it right-size (default).** Say nothing special; the agent classifies the change with
   the table above and picks the lane, telling you which.
2. **Force it with a word.** Start your request with a signal:
   - **"quick:"** or **"trivial:"** → express lane (make the change + `/verify`, nothing else).
   - **"full:"** or **"proper:"** → the full standard loop even for a small change.
   - **"risky:"** → full loop plus `/to-prd`, `/to-issues`, and `/security-review`.
3. **Switch mid-flow.** At any point say "this is trivial, just make it and verify" or
   "actually let's do this properly" — the agent drops into the other lane.

## You're in control

Every skill is a suggestion you can accept, redirect, or skip. The framework is a default,
not a cage. The only non-negotiables are the two gates: `/verify` (no "done" without evidence)
and no real/production data in tests.
