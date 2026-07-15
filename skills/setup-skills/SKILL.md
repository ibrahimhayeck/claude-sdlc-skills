---
name: setup-skills
description: One-time per-repo setup for the engineering skills. Records this repo's issue tracker (GitHub, Jira, or local markdown), where PRDs/ADRs live, the domain-doc layout, and the test frameworks (auto-detect by default, or pinned) into a single docs/agents/config.md + a pointer in CLAUDE.md/AGENTS.md. The other skills read this config, so run it once per repo before using to-prd, to-issues, tdd, functional-test, review, or improve-codebase-architecture.
disable-model-invocation: true
---

# Setup Skills

Scaffold the per-repo config the other skills read. It writes **one file** —
`docs/agents/config.md` — plus a short pointer block in `CLAUDE.md`. Prompt-driven: explore,
present what you found, confirm, then write. Walk the user through the decisions **one at a
time** with a short explainer each. Assume the user may not know the terms; keep it simple.

Doc-placement rules live in this plugin's [CONVENTIONS.md](../../CONVENTIONS.md).

## 1. Explore
- `git remote -v` — GitHub? GitLab? Something else? Capture `owner/name`.
- `CLAUDE.md` / `AGENTS.md` at root — does either exist? Any `## Agent skills` block?
- `CONTEXT.md`, `CONTEXT-MAP.md`, `docs/adr/`, `docs/agents/config.md`, `.scratch/` — what exists?

## 2. Ask (one section at a time)
Use [config.md](./config.md) as the template. Everything defaults sensibly, so a user who
just wants defaults can accept them quickly.

**A — Issue tracker.** Where work items live. Propose a default from the git remote, then offer
**GitHub** (`gh`/MCP), **Jira** (Atlassian MCP / `acli` / draft-only — capture project key + site),
**local markdown** (`.scratch/<feature>/`), or **other** (describe in a sentence).

**B — PRD / ADR location.** **In-repo** (`docs/prds/`, `docs/adr/`) is the default and best for
single-repo work; a **central docs repo** is for work spanning several repos (capture its name +
how the agent reaches it). `CONTEXT.md` always stays in the code repo.

**C — Domain docs.** **Single-context** (one `CONTEXT.md` + `docs/adr/` at root — most repos) or
**multi-context** (`CONTEXT-MAP.md` → per-context files).

**D — Testing frameworks.** Default **auto** (detect from the repo). Offer to pin unit / API / E2E
frameworks + run commands, or leave auto. For a set of repos, mention the `inherit` + central
`testing-defaults.md` option.

## 3. Confirm and write
Show the user a draft of `docs/agents/config.md` (filled from their answers) and the
`## Agent skills` block. Let them edit, then write.

**Pick the file for the pointer block:** if `CLAUDE.md` exists, edit it; else if `AGENTS.md`
exists, edit it; if neither, ask which to create. Never create one when the other exists. If an
`## Agent skills` block already exists, update it in place — don't append a duplicate.

Pointer block:

```markdown
## Agent skills
This repo uses the engineering-skills pack. Per-repo config: `docs/agents/config.md`
(issue tracker, PRD/ADR location, domain-doc layout, test frameworks).
```

Then write `docs/agents/config.md` from [config.md](./config.md), filled with the answers.

## 4. Done
Tell the user setup is complete and that the skills now read `docs/agents/config.md`. They can
edit it directly later — re-run this skill only to redo it from scratch.
