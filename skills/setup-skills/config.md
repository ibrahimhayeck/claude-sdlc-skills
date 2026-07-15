# Agent config (this repo)

The engineering skills read this single file to learn how this repo works. Written once by
`/setup-skills`; edit it directly anytime. Anything left at a default is fine.

## Issue tracker
Where work items live (used by `to-prd`, `to-issues`).
- kind: `<github | jira | local | other>`
- github → repo `<owner/name>`, via the `gh` CLI or GitHub MCP
- jira → project `<KEY>`, site `<https://your-org.atlassian.net>`, via Atlassian MCP / `acli` / draft-only
- local → issues as markdown under `.scratch/<feature>/NNN-slug.md` (state/category in front-matter)

## PRD / ADR location
Where PRDs and ADRs are stored (used by `to-prd`, `grill-with-docs`, `review`).
- prds: `<in-repo: docs/prds/ | central: <org/engineering-docs> prds/>`
- adrs: `docs/adr/` in the code repo; cross-repo ADRs go in the central `docs/adr/` with a one-line stub here
- `CONTEXT.md` always lives in the code repo (never central).

## Domain docs
How the glossary is laid out (used by `grill-with-docs`, `tdd`, `review`, `improve-codebase-architecture`).
- layout: `<single-context | multi-context>`
- single → one `CONTEXT.md` + `docs/adr/` at the repo root (most repos)
- multi → `CONTEXT-MAP.md` at root pointing to per-context `CONTEXT.md` files

## Testing frameworks
Which frameworks the test skills use (used by `tdd`, `functional-test`). Default is `auto`
(detect from the repo). Pin a value to lock it. Precedence: this file → org default → auto-detect.
- unit: `<auto | vitest | jest | pytest | junit5 | xunit | rspec>`   runner: `<auto | e.g. "npm test">`
- api:  `<auto | supertest | rest-assured | httpx+pytest | WebApplicationFactory>`   runner: `<auto>`
- e2e:  `<playwright | cypress | selenium | none>`   runner: `<npx playwright test>`
- To share defaults across a set of repos, set values to `inherit` and put the same fields in
  `testing-defaults.md` in the central docs repo.
