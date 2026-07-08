# Triage labels

Canonical triage roles mapped to the label/status strings your issue tracker actually uses.
Update the right-hand column to match your tracker (GitHub label, Jira label/status, or a
front-matter field in local `.scratch/` markdown issues).

## Category (exactly one per issue)
| Canonical | Tracker label |
|-----------|---------------|
| `bug` | `bug` |
| `enhancement` | `enhancement` |

## State (exactly one per issue)
| Canonical | Tracker label/status |
|-----------|----------------------|
| `needs-triage` | `needs-triage` |
| `needs-info` | `needs-info` |
| `ready-for-agent` | `ready-for-agent` |
| `ready-for-human` | `ready-for-human` |
| `wontfix` | `wontfix` |

If your tracker expresses these as **statuses** rather than labels (e.g. a Jira workflow),
note that here and the `triage` skill transitions status instead of applying a label. For
local markdown issues, these are `category:` / `state:` front-matter fields.
