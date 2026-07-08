# Engineering Core

The essentials — **four commands, zero setup.** Install it, then just describe your work;
the right skill fires and hands off to the next one.

## Install

```
/plugin marketplace add ibrahim-hayeck/AI-Claude-engineering-skills
/plugin install engineering-core@telus-tools
```

That's it. No `/setup-skills`, no config files. (Want the full 14-skill pack instead? Install
`engineering-skills@telus-tools` — but pick one, not both.)

## The four commands

| Command | When | Hands off to |
|---------|------|--------------|
| `/grill-with-docs` | Before building — align on what and why | `/tdd` (or `/diagnose`) |
| `/tdd` | Build it test-first (red-green-refactor) | `/review` |
| `/review` | Check a diff/PR before merge | `/tdd` or `/diagnose` |
| `/diagnose` | A hard bug or perf regression | `/review` |

You rarely type these. Say *"help me build the checkout endpoint"*, *"review my branch"*, or
*"something's throwing in prod"* and the matching skill triggers on its own — then offers the
next step when it's done. You stay in control: it **suggests**, you decide.

## The flow

```
align  ->  build  ->  review  ->  (merge)
 grill      tdd       review
                        |  bug?
                        v
                     diagnose  ->  back to review
```

Entry is flexible: a bug report drops straight into `/diagnose`; "review my branch" drops
straight into `/review`. `CONTEXT.md` (a glossary) and `docs/adr/` (decision notes) are
created only if useful — never required.

## Make it yours

Each skill is a single Markdown file in `skills/<name>/SKILL.md`. Open one, edit the wording,
save — done. To drop a skill, remove its folder and its line from `.claude-plugin/plugin.json`.

---
Based on [mattpocock/skills](https://github.com/mattpocock/skills) (MIT).
