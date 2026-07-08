# ADR Format

ADRs use sequential numbering: `0001-slug.md`, `0002-slug.md`, …

- **Repo-local decision** → `docs/adr/` in the code repo.
- **Cross-repo decision** → `docs/adr/` in the central docs repo, with a one-line stub in
  each affected repo linking back.

Create the `docs/adr/` directory lazily — only when the first ADR is needed. Scan for the
highest existing number and increment.

## Template

```md
# {Short title of the decision}

{1-3 sentences: what's the context, what did we decide, and why.}
```

That's it. An ADR can be a single paragraph. The value is recording *that* a decision was
made and *why* — not filling out sections.

## Optional sections (only when they add value)
- **Status** frontmatter (`proposed | accepted | deprecated | superseded by ADR-NNNN`)
- **Considered Options** — when rejected alternatives are worth remembering
- **Consequences** — when non-obvious downstream effects need calling out

## When to offer an ADR — all three must be true
1. **Hard to reverse** — changing your mind later is costly.
2. **Surprising without context** — a future reader will wonder "why this way?"
3. **The result of a real trade-off** — genuine alternatives existed.

### What qualifies
- Architectural shape (monorepo, event-sourcing, read/write split).
- Integration patterns between services/contexts (events vs synchronous HTTP).
- Technology choices with lock-in (database, message bus, auth provider) — cross-repo ones
  go central.
- Boundary/ownership decisions ("Member data is owned by the Member service; others
  reference by ID").
- Deliberate deviations from the obvious path.
- Constraints not visible in code (compliance: PHI residency, response-time SLAs).
- Non-obvious rejected alternatives.
