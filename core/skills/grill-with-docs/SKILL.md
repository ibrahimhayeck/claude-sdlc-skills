---
name: grill-with-docs
description: Before writing code, interview the developer about the change until it's genuinely clear — one question at a time, walking the decision tree, exploring the codebase to answer what it can. Captures agreed terms in CONTEXT.md and hard-to-reverse choices as short ADRs. Use at the start of any non-trivial change, or when the user says "grill me", "let's align", "stress-test this plan". Based on mattpocock/skills (MIT).
---

# Grill With Docs

Align before building — the single highest-leverage habit. Interview me relentlessly about
this change until we reach a shared understanding, walking down each branch of the decision
tree and resolving dependencies one at a time. Ask **one question at a time** and give your
recommended answer with each. If a question can be answered by reading the codebase, read it
instead of asking.

## Capture as you go (optional, lazy — never a chore)

- **CONTEXT.md** (repo root) — a plain glossary of this repo's domain terms. When you and I
  settle on what a word means, add it here. Keep each definition to a sentence or two; list
  aliases to avoid. It's a glossary only — no implementation detail. Create the file the
  first time a term is worth recording; skip it entirely for trivial changes.
- **docs/adr/NNNN-slug.md** — a one-paragraph record of a decision, but only when it's
  (1) hard to reverse, (2) surprising without context, and (3) a real trade-off. Otherwise
  don't bother.

Both are lazy and optional: they exist to save the *next* person (or agent) a re-derivation,
not to create paperwork. If in doubt, don't write the file.

## Good grilling
Challenge vague terms ("you said 'account' — Customer or User?"), stress-test with concrete
edge-case scenarios, and check claims against the actual code, surfacing contradictions. Stop
when the plan is clear enough to build — not before, not endlessly after.

## Next
When the plan is clear, offer to build it: "Want me to implement this test-first with
`/tdd`?" If it turned out to be a bug hunt rather than new work, offer `/diagnose` instead.
Offer — don't auto-run; let the developer decide when to move on.
