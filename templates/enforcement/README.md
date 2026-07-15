# Enforcement pack (opt-in — not required)

**You do not need this to use the framework.** The in-loop gate is `/verify`; these files are
an *optional, later* hardening step. Nothing here is active until you copy it into a repo and
(for CI) mark the check required. Adopt it once a pilot shows the framework is working — not
before. Until then, leave it off.

The skills *encourage* the right practices; these files *enforce* the same gates even when the
agent isn't driving — turning the convention into a binding standard, when you're ready.

## What's here
- `pull_request_template.md` — the merge checklist (tests, review, security, ADR, data, criteria).
- `ci-checks.yml` — a GitHub Actions workflow that runs the same tests `/finish` runs, so a red
  build blocks the PR. (Adapt the `run:` command / port to GitLab CI / Jenkins as needed.)
- `pre-commit` — a lightweight local hook: blocks direct commits to `main` and obvious secrets.

## Install (GitHub example)
```bash
mkdir -p .github/workflows
cp templates/enforcement/pull_request_template.md .github/pull_request_template.md
cp templates/enforcement/ci-checks.yml            .github/workflows/checks.yml
cp templates/enforcement/pre-commit               .git/hooks/pre-commit && chmod +x .git/hooks/pre-commit
```
Then, in the repo's branch-protection settings, mark the `checks` workflow as a **required
status check** so it must pass before merge. That's what makes the standard binding.

## Note
Edit `ci-checks.yml`'s test command to match this repo (or read it from
`docs/agents/testing.md`). Pre-commit hooks are per-clone; for team-wide hooks use a manager
like `pre-commit`/`husky` and commit its config.
