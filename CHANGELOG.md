# Changelog

All notable changes to this plugin. Versioning follows semver; the version lives in
`.claude-plugin/plugin.json`.

## [0.1.0] — initial
- 16 skills across the loop **align → build → test → review → verify → finish**, with
  **diagnose** and **improve-codebase-architecture** as reflexes.
- Tracker-agnostic (GitHub / Jira / local markdown), language-agnostic, multi-repo aware.
- Per-repo config in `docs/agents/` (issue tracker, docs location, triage labels, domain,
  testing frameworks) written by `/setup-skills`; auto-detect by default.
- Docs: tabbed `docs/overview.html`, `CONVENTIONS.md`, `testing-lifecycle.md`, `WORKFLOW.md`,
  `SKILLS.md`, copy-paste `templates/`, and an opt-in `templates/enforcement/` pack.
- Based on mattpocock/skills (MIT); `verify`, `finish`, and the announce convention adapted
  from obra/superpowers (MIT). See `NOTICE.md`.
