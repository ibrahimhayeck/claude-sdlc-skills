---
name: improve-codebase-architecture
description: Find deepening opportunities in a codebase, informed by the domain language in CONTEXT.md and the decisions in docs/adr/. Use when the user wants to improve architecture, find refactoring opportunities, consolidate tightly-coupled modules, or make a codebase more testable and AI-navigable. Based on mattpocock/skills (MIT).
---

# Improve Codebase Architecture

Surface architectural friction and propose **deepening opportunities** — refactors that turn
shallow modules into deep ones. The aim is testability and AI-navigability.

## Glossary
Use these terms exactly in every suggestion. Consistent language is the point — don't drift
into "component," "service," "API," or "boundary." Full definitions in [LANGUAGE.md](./LANGUAGE.md).

- **Module** — anything with an interface and an implementation (function, class, package, slice).
- **Interface** — everything a caller must know to use the module: types, invariants, error
  modes, ordering, config. Not just the type signature.
- **Implementation** — the code inside.
- **Depth** — leverage at the interface: a lot of behaviour behind a small interface. **Deep**
  = high leverage. **Shallow** = interface nearly as complex as the implementation.
- **Seam** — where an interface lives; a place behaviour can be altered without editing in place.
- **Adapter** — a concrete thing satisfying an interface at a seam.
- **Leverage** — what callers get from depth. **Locality** — what maintainers get from depth.

Key principles (full list in [LANGUAGE.md](./LANGUAGE.md)):
- **Deletion test:** imagine deleting the module. If complexity vanishes, it was a
  pass-through. If complexity reappears across N callers, it was earning its keep.
- **The interface is the test surface.**
- **One adapter = hypothetical seam. Two adapters = real seam.**

This skill is *informed* by the project's domain model: the domain language names good seams;
ADRs record decisions the skill should not re-litigate.

## Process

### 1. Explore
Read the domain glossary (`CONTEXT.md`) and any ADRs in the area first. Then use the Agent
tool with `subagent_type=Explore` to walk the codebase. Don't follow rigid heuristics — note
where you feel friction:
- Where does understanding one concept require bouncing between many small modules?
- Where are modules **shallow** — interface nearly as complex as the implementation?
- Where were pure functions extracted just for testability, but the real bugs hide in how
  they're called (no **locality**)?
- Where do tightly-coupled modules leak across their seams?
- Which parts are untested or hard to test through the current interface?

Apply the **deletion test** to anything you suspect is shallow.

### 2. Present candidates
Present a numbered list. For each: **Files**, **Problem** (why it causes friction),
**Solution** (plain English), **Benefits** (in terms of locality, leverage, and how tests
improve). Use `CONTEXT.md` vocabulary for the domain and [LANGUAGE.md](./LANGUAGE.md)
vocabulary for the architecture. If a candidate contradicts an ADR, only surface it when the
friction is real enough to reopen the ADR — mark it clearly. Do NOT propose interfaces yet.
Ask: "Which of these would you like to explore?"

### 3. Grilling loop
Once the user picks a candidate, drop into a grilling conversation and walk the design tree —
constraints, dependencies, the shape of the deepened module, what sits behind the seam, what
tests survive. Side effects happen inline:
- Naming a deepened module after a concept not in `CONTEXT.md`? Add the term (see
  [../grill-with-docs/CONTEXT-FORMAT.md](../grill-with-docs/CONTEXT-FORMAT.md)).
- Sharpening a fuzzy term? Update `CONTEXT.md` right there.
- User rejects a candidate with a load-bearing reason? Offer an ADR (see
  [../grill-with-docs/ADR-FORMAT.md](../grill-with-docs/ADR-FORMAT.md)) so future reviews
  don't re-suggest it — only when the reason would actually be needed by a future explorer.
- Exploring alternative interfaces? See [INTERFACE-DESIGN.md](./INTERFACE-DESIGN.md), and
  classify dependencies with [DEEPENING.md](./DEEPENING.md).
