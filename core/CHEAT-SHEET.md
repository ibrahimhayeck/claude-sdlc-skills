# Core cheat sheet

Print this. Four commands, and you mostly don't even type them — describe the work.

```
                 ┌──────────────────────────────────────────────┐
   describe  ->  │  align    /grill-with-docs   "let's align"    │
   the work      │  build    /tdd               "build X"        │
                 │  review   /review            "review my PR"   │
                 │  debug    /diagnose          "X is broken"    │
                 └──────────────────────────────────────────────┘

   flow:  grill ─▶ tdd ─▶ review ─▶ merge
                          │
                          └─(bug)─▶ diagnose ─▶ review
```

| I want to... | Say something like | Fires |
|--------------|--------------------|-------|
| Think through a change first | "let's align on this" / "grill me" | `/grill-with-docs` |
| Build a feature or fix, test-first | "build the X endpoint" | `/tdd` |
| Get my change reviewed | "review my branch / this PR" | `/review` |
| Chase down a bug | "this is throwing", "why is X slow" | `/diagnose` |

**Rules of thumb**
- No setup. No mandatory docs. `CONTEXT.md` / ADRs are optional and lazy.
- Each skill offers the next step; you decide whether to take it.
- Tests use synthetic data only — never real/production data.
- Reviews print in chat (and can post to a GitHub PR).

**Adapt:** edit `skills/<name>/SKILL.md`. **Remove:** delete the folder + its line in
`.claude-plugin/plugin.json`. **Upgrade:** install `engineering-skills@telus-tools` for the
full 14-skill pack (planning, triage, functional/security testing, architecture, handoff).
