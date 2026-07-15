# Skills cheat sheet

You rarely type these — **describe the work** and the right skill fires. Full walk-through in
[docs/overview.html](docs/overview.html); how to right-size in [WORKFLOW.md](WORKFLOW.md).

## Everyday — the loop (7)

| Say something like | Fires | Does |
|--------------------|-------|------|
| "let's align" / "help me plan X" | `/grill-with-docs` | interview until the change is clear; capture terms/decisions |
| "build X" / "fix Y with tests" | `/tdd` | build test-first, one behaviour at a time |
| "prove it end-to-end" | `/functional-test` | API + Playwright E2E + cross-repo contract tests |
| "review my branch / PR" | `/review` | check before merge; asks the auth/data safety gate |
| (before any "done") | `/verify` | won't claim done without running the check |
| "land it / open the PR" | `/finish` | final green check → PR/merge/keep/discard + cleanup |
| "X is broken / slow" | `/diagnose` | reproduce → hypothesise → fix + regression test |

## Occasional — bigger moments (8)

| When | Skill |
|------|-------|
| Turn a discussion into a PRD + ticket | `/to-prd` |
| Break a plan into shippable issues | `/to-issues` |
| Groom incoming bugs/requests | `/triage` |
| Change touches auth / data / input / deps | `/security-review` |
| Codebase feels tangled / hard to test | `/improve-codebase-architecture` |
| Dropped into unfamiliar code | `/zoom-out` |
| Align on a non-code plan | `/grill-me` |
| Context running low; hand to a fresh session | `/handoff` |
| One-time per-repo setup | `/setup-skills` |

## Right-size it
**Trivial** change → just make it + `/verify`. **Standard** → the full loop above.
**Risky / multi-repo** → add `/to-prd`, `/to-issues`, and `/security-review`.
