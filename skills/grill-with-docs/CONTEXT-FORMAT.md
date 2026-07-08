# CONTEXT.md Format

## Structure

```md
# {Context Name}

{One or two sentence description of what this context is and why it exists.}

## Language

**Claim**:
A request for reimbursement submitted by a member after receiving care.
_Avoid_: expense, bill, invoice

**Member**:
A person enrolled in a health benefits plan.
_Avoid_: patient, client, user, account

**Provider**:
A clinician or organization that delivers care and may be paid for it.
_Avoid_: vendor, supplier
```

## Rules
- **Be opinionated.** Pick the best word for a concept; list the others as aliases to avoid.
- **Flag conflicts explicitly.** Ambiguous term? Call it out under "Flagged ambiguities"
  with a clear resolution.
- **Keep definitions tight.** One or two sentences. Define what it IS, not what it does.
- **Show relationships.** Bold term names; express cardinality where obvious.
- **Only project-specific terms.** General programming concepts (timeouts, retries, DTOs)
  don't belong, even if used heavily.
- **Group under subheadings** when natural clusters emerge; a flat list is fine otherwise.
- **Write an example dialogue** between a dev and a domain expert that shows the terms
  interacting and clarifies boundaries.

## Single vs multi-context repos
- **Single context (most repos):** one `CONTEXT.md` at the repo root.
- **Multiple contexts:** a `CONTEXT-MAP.md` at the root lists the contexts, where they live,
  and how they relate:

```md
# Context Map

## Contexts
- [Claims](./src/claims/CONTEXT.md) — receives and adjudicates member claims
- [Eligibility](./src/eligibility/CONTEXT.md) — determines what a member is covered for

## Relationships
- **Eligibility → Claims**: Claims checks Eligibility before adjudicating
- **Shared types**: `MemberId`, `Money`
```

Org-wide shared terms live in the **central** docs repo's `CONTEXT-MAP.md`, not here.
