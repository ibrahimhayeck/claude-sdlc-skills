# Attribution

Most skills in this plugin are derived from
**[mattpocock/skills](https://github.com/mattpocock/skills)**, licensed under the MIT License,
© Matt Pocock: `grill-me`, `grill-with-docs`, `to-prd`, `to-issues`, `triage`, `tdd`,
`diagnose`, `improve-codebase-architecture`, `zoom-out`, `handoff`, and the setup pattern.

Adaptations in this pack:
- Tracker-agnostic setup — GitHub Issues, Jira, or local markdown docs (`.scratch/`).
- Configurable docs location — in-repo or a central docs repo — for PRDs and cross-repo ADRs.
- Multi-repo change handling (one tracking item, one PRD, per-repo issues).
- Data/environment guardrails for testing (synthetic data only; PHI/PII called out for
  regulated domains).
- A new language-agnostic `functional-test` skill (API + Playwright + cross-repo).
- New `review` / `security-review` skills.
- `verify` (evidence-before-completion) and `finish` (land-the-change) skills, and the
  "announce the active skill" convention, adapted from concepts in
  **[obra/superpowers](https://github.com/obra/superpowers)** (MIT, © Jesse Vincent).

The original MIT license texts should be retained here when this plugin is distributed:
- mattpocock/skills — https://github.com/mattpocock/skills/blob/main/LICENSE
- obra/superpowers — https://github.com/obra/superpowers/blob/main/LICENSE
