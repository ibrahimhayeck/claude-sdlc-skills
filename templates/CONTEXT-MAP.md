# Context Map

Use this when a repo (or the org) has multiple bounded contexts. Org-wide shared terms live
in the central docs repo's copy of this file; a repo-local copy maps that repo's contexts.

## Contexts
- [{Context A}](./src/{a}/CONTEXT.md) — {one-line purpose}
- [{Context B}](./src/{b}/CONTEXT.md) — {one-line purpose}

## Ownership (org-wide map)
- `{repo-name}` owns the **{Context}** bounded context.

## Relationships
- **{A} → {B}**: {how they interact — events, sync HTTP, shared types}
- **Shared types**: {e.g. MemberId, Money}
