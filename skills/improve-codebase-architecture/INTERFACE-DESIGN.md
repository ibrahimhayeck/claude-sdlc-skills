# Interface Design

When the user wants to explore alternative interfaces for a chosen deepening candidate, use
this parallel sub-agent pattern. Based on "Design It Twice" (Ousterhout) — your first idea is
unlikely to be the best. Uses the vocabulary in [LANGUAGE.md](./LANGUAGE.md).

## Process

### 1. Frame the problem space
Before spawning sub-agents, write a user-facing explanation of the problem space for the
chosen candidate:
- The constraints any new interface must satisfy.
- The dependencies it relies on, and which category they fall into (see [DEEPENING.md](./DEEPENING.md)).
- A rough illustrative code sketch to ground the constraints — not a proposal.

Show this to the user, then proceed to Step 2 (they read and think while sub-agents work).

### 2. Spawn sub-agents
Spawn 3+ sub-agents in parallel using the Agent tool. Each produces a **radically different**
interface for the deepened module. Give each a separate technical brief (file paths, coupling
details, dependency category, what sits behind the seam) and a different design constraint:
- Agent 1: minimise the interface — 1–3 entry points, maximise leverage per entry point.
- Agent 2: maximise flexibility — many use cases and extension.
- Agent 3: optimise for the most common caller — make the default case trivial.
- Agent 4 (if applicable): design around ports & adapters for cross-seam dependencies.

Include both [LANGUAGE.md](./LANGUAGE.md) vocabulary and `CONTEXT.md` vocabulary in each
brief. Each sub-agent outputs: (1) the interface (types, methods, params + invariants,
ordering, error modes), (2) a usage example, (3) what the implementation hides behind the
seam, (4) dependency strategy and adapters, (5) trade-offs.

### 3. Present and compare
Present designs sequentially, then compare in prose — contrast by **depth** (leverage),
**locality** (where change concentrates), and **seam placement**. Give your own opinionated
recommendation; propose a hybrid if elements combine well. The user wants a strong read, not
a menu.
