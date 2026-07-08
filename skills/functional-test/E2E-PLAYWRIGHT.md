# Web E2E with Playwright

End-to-end tests that drive a real browser through a user flow. Use these **only** for
behaviour that is genuinely UI-driven — anything provable at the API level should be an API
test (faster, less flaky).

## Setup (only if the repo has no Playwright yet — confirm first)

```bash
npm init playwright@latest
```

This adds `@playwright/test`, a `playwright.config.ts`, and installs browsers. If the repo
already has Playwright, use its config and folder layout as-is.

## Principles

- **Interact like a user.** Click, type, navigate. Assert on what the user sees.
- **Locate by role/label/text, not by CSS internals.** `getByRole('button', { name: 'Submit claim' })`
  survives restyling; `.btn-primary-2` does not.
- **No reaching into the backend to assert.** If you must set up state, do it through a
  documented API/fixture step in `beforeEach`, not by poking the DB.
- **Isolated and idempotent.** Each test creates its own user/session and cleans up. Use
  storage-state for auth so you don't re-login in every test.
- **Deterministic waits.** Rely on Playwright's auto-waiting and web-first assertions
  (`await expect(locator).toBeVisible()`). Never `sleep(n)`.
- **Capture evidence on failure.** Enable `trace: 'on-first-retry'` and screenshots so a CI
  failure is debuggable.

## Pattern

```ts
import { test, expect } from "@playwright/test";

test("member submits a claim and sees it in their history", async ({ page }) => {
  await page.goto("/claims/new");
  await page.getByLabel("Service date").fill("2026-06-01");
  await page.getByLabel("Amount").fill("120.00");
  await page.getByRole("button", { name: "Submit claim" }).click();

  await expect(page.getByText("Claim submitted")).toBeVisible();

  await page.goto("/claims");
  await expect(page.getByRole("row", { name: /2026-06-01.*\$120\.00/ })).toBeVisible();
});
```

## Data & environment guardrails
- Synthetic data only — **no real or production data** (and no PHI/PII in regulated domains)
  in fixtures, traces, or screenshots.
- Run against a test environment. Scrub auth tokens from stored traces/HAR files.

## CI
Run with `npx playwright test`. Keep E2E in a separate CI job/tag from unit tests so a flaky
browser test doesn't block fast feedback — but it must still gate merges to the main branch.
