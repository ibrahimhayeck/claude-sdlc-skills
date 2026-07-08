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

The original MIT license text should be retained here when this plugin is distributed. See
https://github.com/mattpocock/skills/blob/main/LICENSE
