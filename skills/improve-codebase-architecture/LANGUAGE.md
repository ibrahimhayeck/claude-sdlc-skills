# Language

Shared vocabulary for every suggestion this skill makes. Use these terms exactly — don't
substitute "component," "service," "API," or "boundary." Consistent language is the whole point.

## Terms

**Module** — anything with an interface and an implementation. Scale-agnostic: a function,
class, package, or tier-spanning slice. _Avoid_: unit, component, service.

**Interface** — everything a caller must know to use the module correctly: the type
signature, plus invariants, ordering constraints, error modes, required configuration, and
performance characteristics. _Avoid_: API, signature (too narrow).

**Implementation** — what's inside a module. Distinct from **Adapter**: a thing can be a
small adapter with a large implementation (a Postgres repo) or a large adapter with a small
implementation (an in-memory fake).

**Depth** — leverage at the interface: how much behaviour a caller (or test) can exercise per
unit of interface they must learn. **Deep** = lots of behaviour behind a small interface.
**Shallow** = interface nearly as complex as the implementation.

**Seam** _(Michael Feathers)_ — a place where you can alter behaviour without editing in that
place; the location where a module's interface lives. _Avoid_: boundary (overloaded with
DDD's bounded context).

**Adapter** — a concrete thing satisfying an interface at a seam. Describes role, not substance.

**Leverage** — what callers get from depth: more capability per unit of interface learned.

**Locality** — what maintainers get from depth: change, bugs, knowledge, and verification
concentrate in one place. Fix once, fixed everywhere.

## Principles
- **Depth is a property of the interface, not the implementation.** A deep module can be
  internally composed of small, swappable parts — they just aren't part of the interface.
- **The deletion test.** Delete the module in your head. If complexity vanishes, it was a
  pass-through. If it reappears across N callers, it was earning its keep.
- **The interface is the test surface.** Callers and tests cross the same seam. Wanting to
  test *past* the interface means the module is the wrong shape.
- **One adapter = hypothetical seam. Two adapters = real seam.** Don't introduce a seam
  unless something actually varies across it.

## Rejected framings
- Depth as implementation-lines ÷ interface-lines (rewards padding). Use depth-as-leverage.
- "Interface" as just the `interface` keyword or public methods (too narrow).
- "Boundary" (overloaded with DDD). Say **seam** or **interface**.
