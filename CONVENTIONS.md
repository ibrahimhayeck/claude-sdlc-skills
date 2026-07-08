# Where docs live (CONTEXT.md, PRD, ADR)

The single source of truth for **where each document type lives**, so the whole team — and
the agent — put things in the same place every time. Read once; the skills enforce it after
`/setup-skills` has run.

## The three document types

| Doc | What it is | Changes often? | Home |
|-----|------------|----------------|------|
| **CONTEXT.md** | Glossary of the repo's domain language. *What words mean*, not how code works. | Rarely | **Inside the code repo** |
| **ADR** (Architecture Decision Record) | A short record of *a decision that is hard to reverse* and *why*. | Append-only | **Repo-local** if it affects one repo; **shared docs location** if it spans repos |
| **PRD** (Product Requirements Doc) | *What* we're building and *why*, before we build it. Tied to a tracking item. | Per feature | **Configured docs location** |

> Note on "ARD": if you mean an **Architecture Requirements Document**, this pack splits it
> into two lighter artifacts — the **PRD** (requirements/user stories) and the **ADR** (the
> architectural decisions the PRD implies). There's no separate ARD.

## Two storage setups (chosen in `/setup-skills`)

**Setup 1 — In-repo (default, simplest; best for single-repo projects).**

```
code-repo/
├── CONTEXT.md        ← glossary
├── docs/
│   ├── prds/         ← PRDs for this repo
│   └── adr/          ← this repo's decisions
└── src/
```

**Setup 2 — Central docs repo (recommended once work spans several repos).**

```
┌─────────────────────────────┐        ┌─────────────────────────────┐
│  CODE REPO (one per service)│        │  engineering-docs (central) │
│  /CONTEXT.md   ← glossary   │        │  /CONTEXT-MAP.md            │
│  /docs/adr/    ← repo-local │        │      ← org glossary +       │
│                  decisions  │        │        who-owns-what        │
│  /src/...                   │        │  /prds/<KEY>.md ← every PRD  │
│                             │        │  /docs/adr/ ← CROSS-REPO     │
└─────────────────────────────┘        └─────────────────────────────┘
```

Either way: **CONTEXT.md always lives in the code repo, at the root.** Domain language belongs
next to the code it describes and versions with it. It is a glossary only — no implementation
details, no specs, no scratch notes.

## Decision rules (the agent follows these)

### CONTEXT.md
- Every code repo has one `CONTEXT.md` at its root.
- A repo with several bounded contexts (e.g. a monorepo) uses a root `CONTEXT-MAP.md` pointing
  at per-context `CONTEXT.md` files.
- Terms shared across repos go in the central `CONTEXT-MAP.md` (Setup 2) so every repo agrees
  on what shared concepts mean.

### ADR — where does it go?
- **Affects one repo only** → `docs/adr/NNNN-slug.md` in that repo.
- **Spans multiple repos** (shared contract, event schema, a tech choice locking in more than
  one service) → `docs/adr/NNNN-slug.md` in the central docs location, plus a one-line stub in
  each affected repo linking to it.
- Only write an ADR when all three are true: hard to reverse, surprising without context, the
  result of a real trade-off. Otherwise skip it.

### PRD — where does it go?
- To the configured docs location: `docs/prds/<slug>.md` in-repo (Setup 1), or
  `prds/<KEY>.md` in the central repo (Setup 2) — even for single-repo features, so there's
  one predictable place.

## Multi-repo changes: one tracking item rules them all

When a change affects several repos:

1. **One tracking item (epic)** is the source of truth for the whole change.
2. **One PRD** describes the whole change across all repos — not one PRD per repo.
3. **ADRs**: cross-repo decisions → central `docs/adr/`; a decision local to one repo →
   that repo's `docs/adr/`.
4. `/to-issues` breaks the epic into **one issue per repo per vertical slice**, all linked to
   the parent and labelled with the repo name (e.g. `repo:orders-api`).
5. Each repo updates its **own** `CONTEXT.md`; genuinely shared terms go to the central
   `CONTEXT-MAP.md`.
6. Cross-service functional tests (`/functional-test`, cross-repo mode) live in the repo that
   owns the flow's *entry point*, or a dedicated `e2e` repo — recorded in the PRD's Testing section.

**Why this shape?** PRDs and cross-repo ADRs have no single home repo, so a shared location
avoids duplication and drift and gives one searchable place. The tracking-item key ties code
(issues), docs (PRD/ADR), and tests together. CONTEXT.md stays local because domain language
is per-bounded-context and should travel with the code.
