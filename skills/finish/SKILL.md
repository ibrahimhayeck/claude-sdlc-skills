---
name: finish
description: Land a completed, reviewed change cleanly — do a final green verification, confirm the acceptance criteria, then merge / open a PR / keep / discard, and clean up. Use when a change's tasks are done and reviewed, to close out the work. Concept adapted from obra/superpowers (MIT).
---

# Finish a Change

**Announce at start:** "Using the finish skill to land this change."

Prerequisite: `/review` is clean and `/verify` has confirmed the change green **with evidence**.
Never finish on unverified work.

## Steps

1. **Final verification (whole branch).** Run the full test suite and build; read the output.
   This is `/verify`'s gate applied to everything, not just the last task. Anything red →
   stop and route to `/tdd` (clear fix) or `/diagnose` (unclear cause).
2. **Confirm scope.** Re-read the tracking item's / PRD's acceptance criteria and tick each
   one off, or explicitly note what's deferred and why. "Tests pass" is not "requirements met."
3. **Choose how to land** — present the options rather than assuming:
   - **Open a PR** (default for team repos) — title + a short what/why summary, linked to the
     tracking item, noting the tests you ran and their result.
   - **Merge to main** — only if your flow allows direct merge and the branch is green.
   - **Keep the branch** — not ready to land yet.
   - **Discard** — abandon the work; confirm with the user first.
4. **Clean up.** Delete the merged branch / worktree, remove scratch and debug artifacts, and
   confirm no secrets or real/production data were committed.
5. **Update the tracker.** Close or transition the tracking item per
   `docs/agents/issue-tracker.md`; link the PR/commit.

## On CI
The required gate here is **local** — step 1's fresh test run (this is `/verify` applied to
the branch). A **server-side CI check is optional** and only exists if the repo has adopted
the enforcement pack. If it has, make sure it's green too; if it hasn't, local verification is
sufficient — do not treat missing CI as a blocker.

## Never
Finish with failing tests, unmet acceptance criteria, or any claim you haven't verified this
turn. If you're tempted to skip step 1 because "it passed earlier" — run it again.
