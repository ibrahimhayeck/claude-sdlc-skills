---
name: setup-skills
description: One-time per-repo setup for the engineering skills. Records this repo's issue tracker (GitHub Issues, Jira, or local markdown docs), the triage label vocabulary, where PRDs/ADRs are stored, and the domain-doc layout — into CLAUDE.md/AGENTS.md + docs/agents/. The other skills read this config, so run it once per repo before using to-prd, to-issues, triage, tdd, functional-test, diagnose, or improve-codebase-architecture.
disable-model-invocation: true
---

# Setup Skills

Scaffold the per-repo config the other skills read. Prompt-driven, not a script: explore,
present what you found, confirm, then write. Walk the user through each decision **one at a
time** — a short explainer, then the choices and the default. Assume the user may not know
these terms; keep it simple.

Doc-placement rules live in this plugin's [CONVENTIONS.md](../../CONVENTIONS.md). This skill
records how *this repo* plugs into them.

## 1. Explore
- `git remote -v` — GitHub? GitLab? Something else? Capture `owner/name`.
- `CLAUDE.md` / `AGENTS.md` at root — does either exist? Any `## Agent skills` block?
- `CONTEXT.md`, `CONTEXT-MAP.md`, `docs/adr/`, `docs/agents/`, `.scratch/` — what exists?

## 2. Ask (one section at a time)

**Section A — Issue tracker.**
> The "issue tracker" is where work items live. `to-prd`, `to-issues`, and `triage` read from
> and write to it. Pick where you actually track work for this repo. You can change it later.

Propose a default from the git remote, then offer:

- **GitHub** — issues in the repo's GitHub Issues (uses the `gh` CLI or the GitHub MCP).
- **Jira** — issues in a Jira project (uses the Atlassian/Jira MCP if installed, else
  `acli`/REST with a token, else "draft-only": the agent writes the ticket text and you paste
  it). Capture the **project key** and **site URL**.
- **Local markdown docs** — issues live as files under `.scratch/<feature>/` in this repo.
  Great for solo work, prototypes, or repos with no tracker. This is the "issue doc" option.
- **Other** (Linear, Azure DevOps, …) — ask the user to describe the workflow in one
  paragraph; record it as freeform prose.

Write the matching seed doc to `docs/agents/issue-tracker.md`:
[issue-tracker-github.md](./issue-tracker-github.md),
[issue-tracker-jira.md](./issue-tracker-jira.md), or
[issue-tracker-local.md](./issue-tracker-local.md). For "other", write it from scratch.

**Section B — Where PRDs and ADRs are stored.**
> A PRD says what we're building; an ADR records a hard-to-reverse decision. They need a home.
> This depends on whether your work spans one repo or several.

Offer:
- **In this repo** (default for single-repo projects) — PRDs in `docs/prds/`, ADRs in
  `docs/adr/`. Simplest.
- **Central docs repo** (recommended when work spans multiple repos) — a shared repo (e.g.
  `engineering-docs`) holds PRDs and cross-repo ADRs; repo-local ADRs stay here. Capture the
  repo name and how the agent reaches it (sibling checkout / clone / PR).

Write the choice to `docs/agents/docs-location.md` (seed:
[docs-location.md](./docs-location.md)).

**Section C — Triage labels.**
> `triage` moves issues through five states. Map each canonical role to the label or status
> your tracker actually uses, so the agent applies real ones — not duplicates.

Defaults: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`,
plus categories `bug` / `enhancement`. Ask for overrides. Write
[triage-labels.md](./triage-labels.md) to `docs/agents/triage-labels.md`. (For local-markdown
trackers, these become front-matter fields in the issue files.)

**Section D — Domain docs (this repo).**
> `CONTEXT.md` (this repo's glossary) lives here at the root. Confirm single- vs multi-context.

- **Single-context** — one `CONTEXT.md` + `docs/adr/` at root (most repos).
- **Multi-context** — `CONTEXT-MAP.md` at root pointing to per-context `CONTEXT.md` files.

Write [domain.md](./domain.md) to `docs/agents/domain.md`.

## 3. Confirm and write
Show the user a draft of the `## Agent skills` block plus the four `docs/agents/*.md` files.
Let them edit before writing.

**Pick the file to edit:** if `CLAUDE.md` exists, edit it; else if `AGENTS.md` exists, edit
it; if neither, ask which to create. Never create one when the other already exists. If an
`## Agent skills` block already exists, update it in place — don't append a duplicate.

Block template:

```markdown
## Agent skills

### Issue tracker
[one-line summary]. See `docs/agents/issue-tracker.md`.

### PRD / ADR location
[in-repo | central docs repo <name>]. See `docs/agents/docs-location.md`.

### Triage labels
[one-line summary]. See `docs/agents/triage-labels.md`.

### Domain docs
[single-context | multi-context]. CONTEXT.md is local to this repo. See `docs/agents/domain.md`.
```

## 4. Done
Tell the user setup is complete and which skills now read this config. They can edit
`docs/agents/*.md` directly later — re-run this skill only to switch trackers or start over.
