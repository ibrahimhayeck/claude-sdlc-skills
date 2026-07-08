# Writing Agent Briefs

An agent brief is a structured comment posted on an issue when it moves to `ready-for-agent`.
It is the authoritative specification an AFK agent works from. The original issue body and
discussion are context — the agent brief is the contract.

## Principles

### Durability over precision
The issue may sit in `ready-for-agent` for days. The codebase will change. Write so the brief
stays useful as files are renamed or refactored.
- **Do** describe interfaces, types, and behavioural contracts.
- **Do** name specific types, function signatures, or config shapes to look for.
- **Don't** reference file paths or line numbers — they go stale.
- **Don't** assume the current implementation structure will remain.

### Behavioural, not procedural
Describe **what** the system should do, not **how** to implement it.
- **Good:** "The `SkillConfig` type should accept an optional `schedule` field of type `CronExpression`."
- **Bad:** "Open src/types/skill.ts and add a field on line 42."

### Complete acceptance criteria
Every brief needs concrete, independently verifiable criteria so the agent knows when it's done.
- **Good:** "Running the list command returns issues that have been through initial classification."
- **Bad:** "Triage should work correctly."

### Explicit scope boundaries
State what is out of scope to prevent gold-plating.

## Template
```markdown
## Agent Brief

**Category:** bug / enhancement
**Summary:** one-line description of what needs to happen

**Current behavior:**
What happens now. For bugs, the broken behaviour. For enhancements, the status quo.

**Desired behavior:**
What should happen after the work is complete. Be specific about edge cases and errors.

**Key interfaces:**
- `TypeName` — what needs to change and why
- `functionName()` return type — current vs desired
- Config shape — any new options needed

**Acceptance criteria:**
- [ ] Specific, testable criterion 1
- [ ] Specific, testable criterion 2

**Out of scope:**
- Thing that should NOT be changed
- Adjacent feature that seems related but is separate
```

## Example (bug)
```markdown
## Agent Brief

**Category:** bug
**Summary:** Description truncation drops mid-word, producing broken output

**Current behavior:**
When a description exceeds 1024 characters it is truncated at exactly 1024 chars regardless
of word boundaries, ending mid-word (e.g. "Use when the user wants to confi").

**Desired behavior:**
Truncation breaks at the last word boundary before 1024 chars and appends "...".

**Key interfaces:**
- The metadata type's `description` field — no type change, but the logic that populates it
  must respect word boundaries.

**Acceptance criteria:**
- [ ] Descriptions under 1024 chars are unchanged
- [ ] Longer descriptions truncate at the last word boundary before 1024 chars
- [ ] Truncated descriptions end with "..." and stay within 1024 chars total

**Out of scope:**
- Changing the 1024-char limit itself
```
