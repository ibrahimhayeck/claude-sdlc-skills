---
name: to-issues
description: Break a plan, spec, or PRD into independently-grabbable issues on the project issue tracker (GitHub, Jira, or local markdown) using tracer-bullet vertical slices. For multi-repo changes, creates one issue per repo per slice, all linked to the parent. Use when the user wants to convert a plan into issues or break work down. Based on mattpocock/skills (MIT).
---

# To Issues

Break a plan into independently-grabbable issues using vertical slices (tracer bullets).

The issue tracker should already be configured — run `/setup-skills` if
`docs/agents/config.md` is missing. The steps below are tracker-agnostic: "issue"
means a GitHub issue, a Jira story, or a local `.scratch/` markdown file, per your config.

## Process

### 1. Gather context
Work from the conversation context. If the user passes a PRD path or tracker key, fetch and
read it fully.

### 2. Explore the codebase (optional)
If you haven't already, explore to understand current state. Issue titles use the domain
glossary; respect ADRs in the area.

### 3. Draft vertical slices
Each issue is a **tracer bullet** — a thin slice cutting through ALL layers end-to-end
(schema, API, UI, tests), NOT a horizontal slice of one layer.

Tag each slice **needs-human** (a human call — an architectural decision or design review) or
**agent-ready** (fully specified; an agent can implement and merge it unattended). Prefer
agent-ready where possible.

<vertical-slice-rules>
- Each slice delivers a narrow but COMPLETE path through every layer.
- A completed slice is demoable or verifiable on its own.
- Prefer many thin slices over few thick ones.
</vertical-slice-rules>

**Multi-repo changes:** create **one issue per repo per slice**, each labelled `repo:<name>`
(or tagged in the local file's frontmatter) and linked to the shared parent. A slice that
spans repos becomes coordinated issues with explicit "blocked by" links across them. Include
a functional-test issue per seam (contract tests) and one for any end-to-end journey (see
`functional-test`).

### 4. Quiz the user
Present the breakdown as a numbered list. Per slice show: **Title**, **Type** (needs-human /
agent-ready), **Repo**, **Blocked by**, **User stories covered**. Ask:
- Is the granularity right (too coarse / too fine)?
- Are dependencies correct?
- Should any slices merge or split?
- Are needs-human / agent-ready marked correctly?
Iterate until approved.

### 5. Publish to the issue tracker
Create an issue per approved slice under the parent, in dependency order (so you can
reference real keys/ids in "Blocked by"). Use the template below. Do NOT modify the parent
beyond linking.

<issue-template>
## Parent
Reference to the parent PRD / epic / issue (omit if none).

## Repo
Which repo this issue is implemented in (label `repo:<name>`).

## What to build
Concise description of this vertical slice — end-to-end behaviour, not layer-by-layer.

## Acceptance criteria
- [ ] Criterion 1
- [ ] Criterion 2

## Blocked by
Reference to blocking issue(s), or "None — can start immediately".
</issue-template>
