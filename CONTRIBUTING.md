# Contributing &amp; governance

This plugin is a shared engineering standard, so changes are deliberate and versioned.

## Ownership
- **Owner:** `<team / person>` — approves changes and cuts releases.
- Propose changes via PR against the `dev` branch; the owner reviews and merges.

## Versioning
- Semver in `.claude-plugin/plugin.json`. Patch = wording/fix; minor = new/changed skill or
  config; major = breaking change to skill names or config format.
- Every change gets a `CHANGELOG.md` entry.

## Changing a skill
1. Edit `skills/<name>/SKILL.md`. Keep it **single-purpose**; keep the "Announce at start" line.
2. Add a "when NOT to use" note if the trigger could over-fire.
3. Test it: run the skill on a real task and confirm it behaves; for gates, confirm it blocks
   the bad case (e.g. `/verify` refuses an unverified claim).
4. Update anything that counts or lists skills: `README.md` (loop/counts/list),
   `docs/overview.html` (catalog + counts), `SKILLS.md`.

## Adding a skill — prefer not to
The surface is deliberately small. Before adding one, ask: can an existing skill or a
supporting file cover this? A new skill needs a clear gap, a distinct trigger, and a
"when NOT to use". Adding skills increases what every developer has to reason about.

## Rolling it out across the org (adoption playbook)
1. **Pilot** on 1–2 willing repos; have those teams run `/setup-skills` and use the loop.
2. **Enforce** with the `templates/enforcement/` pack (PR template + required CI check) so the
   gates hold regardless of the agent.
3. **Measure** a few signals: PRs with a review, ADRs written, test/coverage delta, cycle time.
4. **Expand** once the pilot shows value; publish the marketplace and point teams at `SKILLS.md`.

## Held for a separate effort
Deep security/compliance mapping (OWASP/HIPAA controls, SBOM, secret scanning) and automated
skill evals are intentionally out of scope for now — track them separately.
