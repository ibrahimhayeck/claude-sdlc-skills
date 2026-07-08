# Engineering Skills

A comprehensive-but-simple set of agent skills for engineering teams. They make the coding
agent **align before it builds, document decisions as it goes, test what it ships, and keep
the codebase healthy** — the same way across every repo. Built on
[mattpocock/skills](https://github.com/mattpocock/skills) (MIT), with a tracker-agnostic setup
(GitHub / Jira / local markdown docs), language-agnostic testing, and an added
`functional-test` skill (API + Playwright).

## The one-page flow for the team

Each is a slash command in your agent. You only ever run step 0 once per repo.

0. **Once per repo:** `/setup-skills` — records this repo's issue tracker, where PRDs/ADRs
   live, triage labels, and the `CONTEXT.md` layout into `CLAUDE.md` + `docs/agents/`.
1. **Before building:** `/grill-with-docs` — the agent interviews you, sharpens terms, and
   updates `CONTEXT.md` / ADRs as you go. (`/grill-me` for non-code plans.)
2. **Capture the plan:** `/to-prd` — writes the PRD to the configured location and opens the
   tracking item (GitHub issue / Jira epic / local doc).
3. **Break it down:** `/to-issues` — turns the plan into issues, one per repo per vertical slice.
4. **Manage the queue:** `/triage` — moves incoming issues through a state machine.
5. **Build it:** `/tdd` for units, `/functional-test` for acceptance (API, Playwright E2E,
   cross-service flows).
6. **When stuck:** `/diagnose` (disciplined debugging) and `/zoom-out` (understand unfamiliar code).
7. **Keep it healthy:** `/improve-codebase-architecture` every so often. `/handoff` when
   context runs low.

The core loop: **align → document → plan → build → test → debug → improve.**

## Pick your issue tracker (flexible, like the original)

`/setup-skills` asks which you use and wires the rest of the skills to it:

- **GitHub Issues** — via the `gh` CLI or GitHub MCP.
- **Jira** — via the Atlassian MCP, `acli`/REST, or draft-only.
- **Local markdown docs** — issues as files under `.scratch/<feature>/`. No external tracker.
- **Other** (Linear, Azure DevOps, …) — described in one paragraph.

You can switch later by re-running `/setup-skills`.

## Where do the docs go? (short version)

Full detail in [CONVENTIONS.md](./CONVENTIONS.md). Rule of thumb:

| Doc | Lives in |
|-----|----------|
| `CONTEXT.md` (glossary) | the **code repo**, at the root |
| ADR affecting **one** repo | that repo's `docs/adr/` |
| ADR affecting **several** repos | the shared docs location's `docs/adr/` (+ a stub in each repo) |
| PRD | the configured docs location (`docs/prds/` in-repo, or a central docs repo) |

`/setup-skills` lets you keep PRDs/ADRs **in-repo** (simplest, single-repo projects) or in a
**central docs repo** (recommended once work spans several repos).

## What's in the box

Twelve skills: `setup-skills`, `grill-me`, `grill-with-docs`, `to-prd`, `to-issues`,
`triage`, `tdd`, `functional-test`, `diagnose`, `improve-codebase-architecture`, `zoom-out`,
`handoff`. Plus `CONVENTIONS.md` and copy-paste `templates/`.

## Install (Claude Code / compatible agents)

**Option A — as a plugin (recommended for the team).** Push this folder to an internal git
repo, then each person runs:

```
/plugin marketplace add <your-org>/engineering-skills
/plugin install engineering-skills@telus-tools
```

**Option B — drop-in skills.** Copy the `skills/*` folders into `~/.claude/skills/` (global)
or a project's `.claude/skills/`, and keep `CONVENTIONS.md` + `templates/` where the team can
find them.

After installing, everyone runs `/setup-skills` once per repo.

## Data & environment note
The testing skills enforce a simple guardrail: **synthetic data only — no real or production
data** in tests, fixtures, logs, traces, or screenshots, and tests run against dedicated test
environments. In regulated domains (health, finance) this means no PHI/PII.

## Customizing
Meant to be forked. Edit any `SKILL.md`, the label vocabulary in
`setup-skills/triage-labels.md`, or the tracker/docs seed files. Bump `version` in
`.claude-plugin/plugin.json` when you change them.

---
Adapted from [mattpocock/skills](https://github.com/mattpocock/skills), MIT License. See
[NOTICE.md](./NOTICE.md).
