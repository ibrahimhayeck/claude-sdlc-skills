# PRD / ADR location

Where PRDs and ADRs are stored for this repo. Full rationale in the plugin's `CONVENTIONS.md`.
Pick ONE of the two setups below and delete the other.

`CONTEXT.md` is **never** stored here — it always lives in the code repo it describes.

---

## Setup 1 — In this repo (default for single-repo projects)

```
this-repo/
├── CONTEXT.md          # glossary (repo root)
├── docs/
│   ├── prds/
│   │   └── <slug>.md   # PRDs for this repo's work
│   └── adr/
│       └── NNNN-slug.md
└── src/
```

- **PRD** → `docs/prds/<slug>.md` (name after the feature or the tracker key).
- **ADR** → `docs/adr/NNNN-slug.md`.
- Simplest option; everything lives with the code.

---

## Setup 2 — Central docs repo (recommended when work spans multiple repos)

- **Repo:** `<org/engineering-docs>`
- **Reached via:** `<sibling checkout at ../engineering-docs | clone on demand | write via PR>`

```
engineering-docs/
├── CONTEXT-MAP.md      # org glossary + which repo owns which bounded context
├── prds/
│   └── <EPIC-KEY>.md   # one PRD per epic (single- and multi-repo)
└── docs/adr/
    └── NNNN-slug.md    # CROSS-REPO decisions only
```

- **PRD** → `prds/<EPIC-KEY>.md` in the central repo (even single-repo features, for one
  searchable home).
- **ADR** → central `docs/adr/` **only if the decision spans repos**; a repo-local decision
  stays in this repo's `docs/adr/`, and a cross-repo ADR gets a one-line stub here linking back.
- Every PRD/ADR names the tracker key (e.g. Jira epic / GitHub issue) so code, docs, and tests
  stay linked.
