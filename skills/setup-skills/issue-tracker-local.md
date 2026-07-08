# Issue tracker: local markdown docs

Work for this repo is tracked as markdown files in the repo — no external tracker. Good for
solo work, prototypes, or repos without a remote tracker.

- **Location:** `.scratch/<feature>/` — one folder per feature/epic, one markdown file per issue.
- **Naming:** `NNN-slug.md` (zero-padded, incrementing per feature folder).

## Issue file format
```markdown
---
id: 003
title: Member can view claim history
category: enhancement          # bug | enhancement
state: needs-triage            # see triage-labels.md
blocked_by: [002]
parent: prds/<slug>.md         # or a PRD path
---

## What to build
End-to-end behaviour of this slice.

## Acceptance criteria
- [ ] ...
```

## How skills use it
- `to-prd` — writes the PRD to the location in `docs/agents/docs-location.md`, then creates a
  `.scratch/<feature>/000-prd.md` pointer (or the PRD itself for in-repo storage).
- `to-issues` — creates one `NNN-slug.md` per vertical slice under `.scratch/<feature>/`,
  setting `blocked_by` to real ids.
- `triage` — updates the `state`/`category` front-matter fields (the labels map in
  `triage-labels.md`) instead of calling a tracker API.
