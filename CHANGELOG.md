# Changelog

All notable changes to this plugin. Versioning follows semver; the version lives in
`.claude-plugin/plugin.json`.

## [0.2.0] — adoption &amp; standardization
- **New skills:** `verify` (evidence-before-claims gate) and `finish` (land-the-change),
  bringing the loop to **align → build → test → review → verify → finish** (16 skills).
- **Right-sizing:** express / standard / full lanes with force-keywords (`quick:` / `full:` /
  `risky:`), a decision diagram in the overview, and a right-size note in `/grill-with-docs`.
  Added `WORKFLOW.md`.
- **Discoverability:** `SKILLS.md` one-screen cheat sheet with Everyday / Occasional tiers.
- **Configurable testing:** `docs/agents/testing.md` — pin unit/API/E2E frameworks per repo or
  a set of repos, default auto-detect (`/tdd`, `/functional-test` honour it).
- **Enforcement (opt-in, not required):** `templates/enforcement/` — PR template, optional CI
  check, pre-commit hook. Clearly marked optional; the in-loop gate remains `/verify`.
- **Governance:** `CONTRIBUTING.md` (owner, versioning, change process, adoption playbook) and
  this changelog.
- **Docs:** single tabbed `docs/overview.html` (Get started / All skills / Testing / Repo
  layout / Install & plugins), `testing-lifecycle.md`, colour-coded repo-layout by file type.
- Attribution: `verify`, `finish`, and the announce-the-skill convention adapted from
  obra/superpowers (MIT). See `NOTICE.md`.

## [0.1.0] — initial
- Baseline methodology (14 skills): `setup-skills`, `grill-me`, `grill-with-docs`, `to-prd`,
  `to-issues`, `triage`, `tdd`, `functional-test`, `review`, `security-review`, `diagnose`,
  `improve-codebase-architecture`, `zoom-out`, `handoff`.
- Tracker-agnostic (GitHub / Jira / local markdown), language-agnostic, multi-repo aware.
- Per-repo config in `docs/agents/`; `CONVENTIONS.md`, templates. Based on mattpocock/skills (MIT).
