# Changelog

All notable changes to this plugin. Versioning follows semver; the version lives in
`.claude-plugin/plugin.json`.

## [0.3.0] — tightened after skill-by-skill review
- **16 → 13 skills.** Removed `triage` (teams use their own tracker), `grill-me` (folded into
  `grill-with-docs`, which now handles non-code plans too), and `handoff` (rely on durable
  artifacts).
- **Config collapsed** to a single `docs/agents/config.md` (was five files); `/setup-skills`
  writes one file; dropped `triage-labels`.
- **grill-with-docs** — capturing CONTEXT.md + decisions is now required for code work.
- **to-issues** — HITL/AFK renamed to `needs-human` / `agent-ready`; dropped the `needs-triage` label.
- **tdd** — coverage bar raised: every new behaviour gets a test (depth on critical paths).
- **functional-test** — trigger clarified (user-facing/API; skip pure refactors).
- **review** — presents in chat first, offers to post; AI-generated disclaimer removed.
- **security-review** — restructured to the OWASP Top 10 + compliance hooks (PHI/PII); disclaimer removed.
- **verify** — now an always-on rule applied inside every skill, not just an invokable step.
- **finish** — defaults to opening a PR, auto-created via gh/API.
- **diagnose** — right-sized (quick path for obvious bugs); always leaves a regression test.
- **improve-codebase-architecture** — on-demand only (dropped the "every few days" nudge).
- Docs (README, overview, SKILLS, WORKFLOW) and counts updated to match.

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
