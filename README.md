# Engineering Skills

A comprehensive-but-simple set of agent skills for engineering teams. They make the coding
agent **align before it builds, document decisions as it goes, test and review what it ships,
and keep the codebase healthy** — the same way across every repo. Built on
[mattpocock/skills](https://github.com/mattpocock/skills) (MIT), with a tracker-agnostic setup
(GitHub / Jira / local markdown docs), language-agnostic testing, and an added
`functional-test` skill (API + Playwright).

> **Most days you use four.** It's one plugin with 14 skills, but the everyday loop is just
> `/grill-with-docs` → `/tdd` → `/review` → `/diagnose`. They **hand off to each other**, so
> you describe your work in plain language, the right one fires, and it offers the next step.
> The other ten (planning, triage, functional/security testing, architecture, handoff) stay
> out of your way until a task calls for them — nothing to run or remember up front.
>
> ```
> /plugin marketplace add ibrahimhayeck/claude-sdlc-skills
> /plugin install engineering-skills@engineering-tools
> ```

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
6. **Review it:** `/review` checks a diff/PR against the acceptance criteria, glossary, and
   ADRs; `/security-review` for changes touching auth, input, data, or dependencies.
7. **When stuck:** `/diagnose` (disciplined debugging) and `/zoom-out` (understand unfamiliar code).
8. **Keep it healthy:** `/improve-codebase-architecture` every so often. `/handoff` when
   context runs low.

The core loop: **align → document → plan → build → test → review → debug → improve.**

## Pick your issue tracker (flexible, like the original)

`/setup-skills` asks which you use and wires the rest of the skills to it:

- **GitHub Issues** — via the `gh` CLI or GitHub MCP.
- **Jira** — via the Atlassian MCP, `acli`/REST, or draft-only.
- **Local markdown docs** — issues as files under `.scratch/<feature>/`. No external tracker.
- **Other** (Linear, Azure DevOps, …) — described in one paragraph.

You can switch later by re-running `/setup-skills`.

## Pick your test frameworks (default = auto-detect)

`/tdd` and `/functional-test` detect the framework from each repo by default — but a developer
can **pin** a choice in `docs/agents/testing.md` (unit, API, and E2E, each with a run command).
Precedence is **repo file → org default → auto-detect**, so one repo can lock its tools, or a
whole **set of repos** can share defaults via a `testing-defaults.md` in the central docs repo.
No code changes — just edit the config.

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

Fourteen skills: `setup-skills`, `grill-me`, `grill-with-docs`, `to-prd`, `to-issues`,
`triage`, `tdd`, `functional-test`, `review`, `security-review`, `diagnose`,
`improve-codebase-architecture`, `zoom-out`, `handoff`. Plus `CONVENTIONS.md` and copy-paste
`templates/`.

## Install (Claude Code / compatible agents)

**Option A — as a plugin (recommended for the team).** Push this folder to an internal git
repo, then each person runs:

```
/plugin marketplace add ibrahimhayeck/claude-sdlc-skills
/plugin install engineering-skills@engineering-tools
```

Here `ibrahimhayeck/claude-sdlc-skills` is the **owner/repo**; `engineering-skills@engineering-tools` is **plugin@marketplace** (the `name` fields in `plugin.json` and `marketplace.json`). One install brings all fourteen skills.

**Option B — drop-in skills.** Copy the `skills/*` folders into `~/.claude/skills/` (global)
or a project's `.claude/skills/`, and keep `CONVENTIONS.md` + `templates/` where the team can
find them.

**Option C — skills.sh installer** (public repos): `npx skills@latest add ibrahimhayeck/claude-sdlc-skills`.

After installing, everyone runs `/setup-skills` once per repo. Push updates by bumping `version` in `plugin.json`; teammates run `/plugin marketplace update engineering-tools`.

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
