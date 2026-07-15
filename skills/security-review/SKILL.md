---
name: security-review
description: Focused security review of a diff, PR, or branch, structured around the OWASP Top 10 with explicit compliance hooks for regulated data (PHI/PII) — access control, crypto, injection, auth, vulnerable dependencies, logging, SSRF, and data handling. Use when a change touches auth, data access, external input, file/network I/O, or dependencies, or when the user wants a security review. Complements the general review skill.
---

# Security Review

A security-focused pass over a change. Narrower and deeper than `/review` — assume an
attacker and look for what could go wrong. Grounded in the per-repo config (`/setup-skills`
if missing) and any compliance constraints noted in the PRD/ADRs.

## 1. Gather the change
Get the diff (PR/branch/staged, same as `/review`). Note what the change touches:
authentication, authorization, user input, data access, file/network I/O, crypto,
serialization, or dependencies — those are where the risk concentrates.

## 2. Threat-model the change
For the touched surface, ask: what's the untrusted input, what's the trust boundary it
crosses, and what's the worst thing an attacker could do with it?

## 3. Review against the OWASP Top 10
Group findings by severity (**critical / high / medium / low**), each with the concrete risk
and a fix. Walk the Top 10:

- **A01 Broken Access Control** — every new endpoint/action checks identity *and* permission;
  no missing ownership checks (IDOR); no trusting client-supplied roles/IDs.
- **A02 Cryptographic Failures** — sensitive data encrypted in transit and at rest where
  required; standard crypto libraries only (no home-rolled); sound randomness; sane token lifetimes/storage.
- **A03 Injection** — untrusted input validated and parameterized: SQL/NoSQL, command, path
  traversal, XSS, LDAP, template injection. Prefer allow-lists.
- **A04 Insecure Design** — the approach itself is sound: rate-limit sensitive actions, no
  dangerous defaults; flag design-level risk, not just bugs.
- **A05 Security Misconfiguration** — no debug endpoints, permissive CORS, default creds,
  **hardcoded secrets/keys/tokens** (use env/secret store), or verbose errors leaking internals.
- **A06 Vulnerable & Outdated Components** — new/updated packages reputable and pinned; flag
  known-vulnerable/abandoned ones; suggest the ecosystem audit (`npm audit`, `pip-audit`, …).
- **A07 Authentication Failures** — sound session/token handling; no weak or missing auth on sensitive paths.
- **A08 Software & Data Integrity** — no unsafe deserialization; artifacts/deps from trusted sources.
- **A09 Logging & Monitoring** — security-relevant events logged; **secrets/PII never in logs, traces, or fixtures**.
- **A10 SSRF** — server-side requests to user-supplied URLs are validated/restricted.

## Compliance hooks (regulated data)
When the change touches personal / health / financial data, also check:
- **Minimization** — only the data actually needed is collected/returned.
- **Encryption** — in transit (TLS) and at rest where required.
- **Retention & deletion** — data isn't kept longer than allowed; deletion paths exist.
- **Access & audit logging** — access to sensitive data is recorded (without logging the data itself).
- **Residency / consent** — honours any data-residency or consent constraints in the PRD/ADRs.
- **No real data in tests** — synthetic PHI/PII only.

## 4. Deliver
Present the review in chat; offer to post it to the PR/tracker (per `docs/agents/config.md`)
if wanted — don't post automatically. Structure it as:

```markdown
## Security review summary
Overall risk: none / low / medium / high, and the headline reason.

## Critical / High
- Risk → impact → fix

## Medium / Low
- ...

## Checked and OK
- Short list of what you verified is safe (so reviewers know it was looked at).
```

If you can't fully assess something (e.g. auth flows spanning services you can't see), say so
and name what a human should verify. Don't imply a change is secure beyond what you reviewed.
