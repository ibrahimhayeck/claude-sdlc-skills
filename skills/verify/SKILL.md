---
name: verify
description: A hard gate before claiming any work is complete, fixed, passing, or done. Requires running the actual verification command in this turn and reading its output before making the claim — evidence before assertions, always. Use before committing, opening a PR, marking a task complete, or telling the user something works. Concept adapted from obra/superpowers (MIT).
---

# Verify Before Completion

**Announce at start:** "Using the verify skill — evidence before claims."

## The rule
**No completion claim without fresh verification evidence.** If you haven't run the command
in *this* turn and read its output, you cannot say it passes, works, is fixed, or is done.
Violating the letter of this rule is violating the spirit of it.

**This is an always-on rule, not just a step.** Every skill in this pack applies it before
making any completion claim — you don't have to invoke `/verify` for it to bind. `/verify` is
the named reference for the rule.

## The gate — run before any success claim
1. **Identify** the command that would prove the claim.
2. **Run** it fresh and in full (not a partial, not a remembered earlier run).
3. **Read** the whole output: exit code, pass/fail counts, error lines.
4. **Decide:** if the output doesn't confirm the claim, state the *actual* status with the
   evidence; if it does, state the claim **with** the evidence attached.

## What actually proves what
| Claim | Proof required | Not enough |
|-------|----------------|------------|
| Tests pass | test command output: 0 failures | "should pass", an earlier run |
| Build succeeds | build exit code 0 | linter passed |
| Bug fixed | the original symptom now passes | code changed, assumed fixed |
| Regression test works | red → green verified (revert fix, see it fail, restore) | it passed once |
| Requirements met | line-by-line check against the issue/PRD acceptance criteria | tests pass |
| A subagent "succeeded" | you inspected the diff/output yourself | its success report |

## Red flags — stop and run the command
"should", "probably", "seems to", celebrating before verifying ("Done!", "Perfect!"), about
to commit/PR without running anything, trusting a subagent's word, "just this once", "I'm
confident". Confidence is not evidence.

## Next
Once you have green evidence in hand, hand off to **/finish** to land the change. If
verification fails, route to **/tdd** (clear fix) or **/diagnose** (unclear cause) instead.
