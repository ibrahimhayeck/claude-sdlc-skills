---
tracking_key: {ISSUE-OR-EPIC-KEY}
status: {draft | active | done}
affected_repos: [{repo-a}, {repo-b}]
---

# {Feature name} — PRD

## Problem Statement
{The problem, from the user's perspective.}

## Solution
{The solution, from the user's perspective.}

## Affected repos
- {repo-a}
- {repo-b}   ← omit extras for single-repo changes

## User Stories
1. As a {actor}, I want {feature}, so that {benefit}.
2. …

## Implementation Decisions
- Modules to build/modify and their interfaces
- Architectural decisions / schema changes / API contracts
- (No file paths or code snippets — they go stale.)

## Testing Decisions
- What makes a good test here
- Modules getting unit/integration tests (/tdd)
- Acceptance flows getting functional tests (/functional-test)
- Multi-repo: contract-test seams, end-to-end journey(s), and where those tests live

## Out of Scope
- {…}

## Further Notes
- Constraints: {compliance, data residency, SLAs — where relevant}
