---
name: to-prd
description: Turn the current conversation context into a PRD, save it to the configured docs location, and open a tracking item in the project issue tracker (GitHub, Jira, or local markdown). Use when the user wants to create a PRD from what's already been discussed. No interview — synthesizes existing context. Based on mattpocock/skills (MIT).
---

Takes the current conversation and codebase understanding and produces a PRD. Do NOT
interview the user — just synthesize what you already know. (If the plan is still fuzzy, run
`/grill-with-docs` first.)

The issue tracker and docs location should already be configured — run `/setup-skills` if
`docs/agents/issue-tracker.md` or `docs/agents/docs-location.md` are missing.

## Process

1. Explore the repo(s) to understand current state. Use the domain glossary (`CONTEXT.md`)
   throughout, and respect ADRs in the area you're touching.

2. Sketch the major modules to build/modify. Actively look for **deep modules** — a lot of
   functionality behind a simple, testable interface that rarely changes. Confirm the module
   list with the user, and which modules they want tests written for.

3. **Determine repo scope.** If the change touches more than one repo, say so explicitly:
   there is **one tracking item (epic)** and **one PRD** for the whole change, and it lists
   every affected repo.

4. Write the PRD using the template below.

5. **Save the PRD** to the configured docs location (`docs/agents/docs-location.md` — either
   `docs/prds/<slug>.md` in this repo or `prds/<KEY>.md` in the central docs repo). Then open
   the tracking item in the configured issue tracker (`docs/agents/issue-tracker.md`) —
   a GitHub issue, a Jira epic, or a local `.scratch/` file — link it to the PRD, and apply
   `needs-triage`. Put the tracker key in the PRD frontmatter so code, docs, and tests stay linked.

<prd-template>

## Problem Statement
The problem the user faces, from the user's perspective.

## Solution
The solution, from the user's perspective.

## Affected repos
List every repo this change touches (single-repo changes: just the one). This drives how
`/to-issues` splits the work.

## User Stories
A LONG, numbered list. Each: `As an <actor>, I want a <feature>, so that <benefit>`.
Be extensive — cover all aspects of the feature.

## Implementation Decisions
Modules to build/modify and their interfaces, technical clarifications, architectural
decisions, schema changes, API contracts, key interactions. No file paths or code snippets
(they go stale).

## Testing Decisions
What makes a good test (external behaviour only). Which modules get unit/integration tests
(`/tdd`) and which acceptance flows get functional tests (`/functional-test`). For multi-repo
changes, name the contract-test seams and any end-to-end journey and where those tests live.
Reference prior art in the codebase.

## Out of Scope
What is explicitly not included.

## Further Notes
Anything else — including compliance constraints where relevant.

</prd-template>
