# Out-of-Scope Knowledge Base

The `.out-of-scope/` directory in a repo stores persistent records of rejected feature
requests. Two purposes: **institutional memory** (why a feature was rejected) and
**deduplication** (surface the prior decision when a similar request returns).

## Structure
```
.out-of-scope/
├── dark-mode.md
├── plugin-system.md
└── graphql-api.md
```
One file per **concept**, not per issue. Multiple issues requesting the same thing group under one file.

## File format
Write it like a short design doc, not a database entry — paragraphs, code, examples.
```markdown
# Dark Mode

This project does not support dark mode or user-facing theming.

## Why this is out of scope
The rendering pipeline assumes a single palette defined in `ThemeConfig`. Supporting themes
would require a theme context provider, per-component theme-aware resolution, and a
persistence layer for preferences — a significant change that doesn't align with the
project's focus on content authoring.

## Prior requests
- #42 — "Add dark mode support"
- #87 — "Night theme for accessibility"
```

### Naming
Short kebab-case concept name (`dark-mode.md`), recognizable without opening the file.

### Writing the reason
Substantive and durable — reference project scope/philosophy, technical constraints, or
strategic decisions. Avoid temporary circumstances ("too busy right now"); those are
deferrals, not rejections.

## When to check
During triage (gather-context step), read all `.out-of-scope/` files. Match new issues by
**concept similarity**, not keywords ("night theme" matches `dark-mode.md`). On a match,
surface it: "This resembles `.out-of-scope/dark-mode.md` — we rejected it before because
[reason]. Do you still feel the same?" The maintainer may **confirm** (append the issue to
Prior requests, close), **reconsider** (delete/update the file, proceed with triage), or
**disagree** (related but distinct — proceed).

## When to write
Only when an **enhancement** (not a bug) is rejected as `wontfix`: check for an existing
matching file; append the issue if found, else create a new file with concept, reason, and
first prior request; comment on the issue linking the file; close with `wontfix`.

## Updating / removing
If the maintainer changes their mind, delete the file. No need to reopen old issues — they're
historical. The new triggering issue proceeds through normal triage.
