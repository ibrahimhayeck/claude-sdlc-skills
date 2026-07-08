# Domain docs (this repo)

How the skills read this repo's domain documentation.

## Layout
- `<single-context | multi-context>`
- **Single-context:** one `CONTEXT.md` + `docs/adr/` at the repo root.
- **Multi-context:** `CONTEXT-MAP.md` at the root pointing to per-context `CONTEXT.md`
  files (e.g. `src/ordering/CONTEXT.md`), each with its own `docs/adr/`.

## Consumer rules
- `CONTEXT.md` is a **glossary only** — what terms mean, no implementation details, no specs.
- Skills (`grill-with-docs`, `to-prd`, `to-issues`, `tdd`, `functional-test`) use this
  vocabulary so variable/function/test names and issue titles all match the project language.
- `docs/adr/` here holds **repo-local** decisions. Cross-repo decisions live in the configured
  docs location (see `docs-location.md`).
- Create `CONTEXT.md` and `docs/adr/` **lazily** — only when there's a first term or first
  decision to record.
- Terms shared with other repos belong in the central `CONTEXT-MAP.md`, not duplicated here.
