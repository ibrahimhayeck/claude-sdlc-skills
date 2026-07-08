---
name: grill-with-docs
description: Grilling session that stress-tests your plan against the existing domain model, sharpens terminology, and updates documentation (CONTEXT.md, ADRs) inline as decisions crystallise. Use before starting any non-trivial change to align with the agent and think deeply about what you're building. Based on mattpocock/skills (MIT).
---

<what-to-do>

Interview me relentlessly about every aspect of this plan until we reach a shared
understanding. Walk down each branch of the design tree, resolving dependencies between
decisions one-by-one. For each question, provide your recommended answer.

Ask the questions one at a time, waiting for feedback on each before continuing.

If a question can be answered by exploring the codebase, explore the codebase instead.

</what-to-do>

<supporting-info>

## Where docs live

The authoritative rules are in this plugin's `CONVENTIONS.md`. In short:

- **`CONTEXT.md` lives in the code repo, at the root** (glossary only). A repo with multiple
  bounded contexts uses `CONTEXT-MAP.md` at the root pointing to per-context `CONTEXT.md`s.
- **Repo-local ADRs** live in that repo's `docs/adr/`.
- **PRDs and cross-repo ADRs** live in the configured docs location — see
  `docs/agents/docs-location.md`. Don't write those here.

```
code-repo/
├── CONTEXT.md            ← glossary (create lazily on first resolved term)
├── docs/adr/             ← repo-local decisions (create lazily on first ADR)
└── src/
```

Create files lazily — only when you have something real to write.

## During the session

### Challenge against the glossary
When a term conflicts with `CONTEXT.md`, call it out immediately. "Your glossary defines
'cancellation' as X, but you seem to mean Y — which is it?"

### Sharpen fuzzy language
Propose a precise canonical term for vague/overloaded words. "You said 'account' — do you
mean the Member or the User? Those are different things."

### Discuss concrete scenarios
Stress-test domain relationships with specific edge-case scenarios that force precision.

### Cross-reference with code
When the user states how something works, check the code agrees. Surface contradictions.

### Update CONTEXT.md inline
When a term is resolved, update `CONTEXT.md` right there — don't batch. Use the format in
[CONTEXT-FORMAT.md](./CONTEXT-FORMAT.md). `CONTEXT.md` is a glossary and nothing else — no
implementation details, no spec, no scratch pad.

### Offer ADRs sparingly
Only offer an ADR when all three are true: (1) hard to reverse, (2) surprising without
context, (3) the result of a real trade-off. Use [ADR-FORMAT.md](./ADR-FORMAT.md). If the
decision spans repos, write it to the **central** docs repo, not here.

### If this is a multi-repo change
Confirm early whether the change touches more than one repo. If so, there is **one tracking
item (epic)** and **one PRD** for the whole change (in the configured docs location). Note
which repos are affected so `/to-issues` can split work per repo. Shared terms go to the
central `CONTEXT-MAP.md`; each repo still keeps its own local `CONTEXT.md`.

</supporting-info>
