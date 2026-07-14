# Testing frameworks (this repo)

`/tdd` and `/functional-test` read this file to decide which frameworks and run commands to
use. Any value left as `auto` is detected from the repo; set an explicit value to **pin** it.

**Precedence (first match wins):** this file → org default (e.g.
`<central-docs-repo>/testing-defaults.md`) → auto-detect from the repo.

## Unit / integration — used by /tdd
- framework: auto        # e.g. vitest | jest | pytest | junit5 | xunit | rspec | go test
- runner: auto           # command, e.g. "npm test" | "mvn test" | "pytest" | "dotnet test"

## API / service functional tests — used by /functional-test
- framework: auto        # e.g. supertest | rest-assured | WebTestClient | httpx+pytest | WebApplicationFactory
- runner: auto

## End-to-end (browser) — used by /functional-test
- framework: playwright  # team default; or cypress | selenium | none
- runner: npx playwright test

## Notes
- `auto` = let the skill pick based on the manifest and existing tests (never introduces a
  new dependency without asking).
- To standardise a **set of repos**, create `testing-defaults.md` in the central docs repo
  with the same fields and set values here to `inherit` to defer to it.
- Changing a value here re-points the skills for this repo only — no code changes needed.
