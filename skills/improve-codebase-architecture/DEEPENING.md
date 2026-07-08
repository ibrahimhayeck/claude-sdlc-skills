# Deepening

How to deepen a cluster of shallow modules safely, given its dependencies. Assumes the
vocabulary in [LANGUAGE.md](./LANGUAGE.md) — **module**, **interface**, **seam**, **adapter**.

## Dependency categories
Classify a candidate's dependencies; the category determines how the deepened module is
tested across its seam.

1. **In-process** — pure computation, in-memory state, no I/O. Always deepenable; merge and
   test through the new interface directly. No adapter needed.
2. **Local-substitutable** — dependencies with local test stand-ins (PGLite for Postgres,
   in-memory filesystem). Deepenable if the stand-in exists; the seam is internal.
3. **Remote but owned (Ports & Adapters)** — your own services across a network boundary.
   Define a **port** at the seam; inject the transport as an **adapter**. Tests use an
   in-memory adapter; production uses HTTP/gRPC/queue. Shape: *"Define a port at the seam,
   implement an HTTP adapter for production and an in-memory adapter for testing, so the logic
   sits in one deep module even though it's deployed across a network."*
4. **True external (Mock)** — third-party services you don't control (Stripe, Twilio). Inject
   as a port; tests provide a mock adapter.

## Seam discipline
- **One adapter = hypothetical seam. Two adapters = real one.** Don't introduce a port unless
  at least two adapters are justified (typically production + test). A single-adapter seam is
  just indirection.
- **Internal vs external seams.** A deep module can have internal seams (private, used by its
  own tests) as well as the external seam at its interface. Don't expose internal seams
  through the interface just because tests use them.

## Testing strategy: replace, don't layer
- Old unit tests on shallow modules become waste once tests at the deepened interface exist —
  delete them.
- Write new tests at the deepened module's interface. The **interface is the test surface**.
- Assert on observable outcomes through the interface, not internal state. Tests should
  survive internal refactors.
