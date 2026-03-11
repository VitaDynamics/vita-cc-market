---
name: adr
description: Capture architectural decisions as permanent, sequentially-numbered Architecture Decision Records in docs/adr/
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Glob
  - AskUserQuestion
preconditions:
  - A plan file, spec file, or inline decision description provided
---

# ADR Skill

**Purpose**: Generate permanent, sequentially-numbered Architecture Decision Records (ADRs) from completed plans, specs, or inline decision descriptions. ADRs are the long-lived artifact of the planning pipeline — never auto-deleted or overwritten.

## Input

```
$ARGUMENTS
```

Accepted inputs:
- Path to `docs/plans/<feature-name>.md` — extract decisions from the plan
- Path to `docs/specs/<feature-name>.md` — extract decisions from the spec
- Inline description of a decision — use directly
- Empty → use **AskUserQuestion**: "What architectural decision would you like to record? Provide a file path (docs/plans/ or docs/specs/) or describe the decision directly."

## Workflow

### Step 1: Extract Decision Candidates

When input is a plan or spec file, scan for signals of settled architectural decisions:

- Sections titled "Architecture", "Design Decisions", "Chosen Approach", "Technology Selection"
- Phrases like "We will use X", "We chose X over Y because...", "Rejected Y because..."
- Mermaid diagrams that encode a chosen structure
- Any explicit trade-off analysis

List each candidate decision (one sentence each) and present via **AskUserQuestion**:
> "Found these decision candidates in [file]. Which would you like to record as ADRs? (select one or more, or all)"

### Step 2: Determine Next ADR Number

```bash
ls docs/adr/ 2>/dev/null | grep -E '^[0-9]{4}-' | sort | tail -1
```

- If `docs/adr/` is empty or absent: NNNN = `0001`
- Otherwise: NNNN = highest existing number + 1, zero-padded to 4 digits

Create `docs/adr/` if it does not exist.

### Step 3: Write the ADR

Load the template from `plugins/Vengineer/skills/reference/adr_template.md` for structural reference.

Write `docs/adr/NNNN-<kebab-case-title>.md` with this structure:

```markdown
---
stage: adr
adr: NNNN
title: <Decision Title>
created: YYYY-MM-DD
status: Accepted
source-plan: <docs/plans/... or omit>
source-spec: <docs/specs/... or omit>
---

# NNNN. <Decision Title>

## Status
Accepted

## Context
[Forces at play — constraints, requirements, competing concerns. 2-4 sentences. Implementation-agnostic.]

## Decision
[The choice made. "We will use X." One clear paragraph.]

## Alternatives Considered
| Option | Why Rejected |
|--------|-------------|
| Option A | [reason] |

## Consequences
### Positive
- [benefit]

### Negative / Trade-offs
- [accepted cost]

## References
- Source plan: [docs/plans/...]
- Source spec: [docs/specs/...]
- Related ADRs: [if any]
```

### Step 4: Update Index

Update (or create) `docs/adr/README.md`:

```markdown
# Architecture Decision Records

| # | Title | Date | Status |
|---|-------|------|--------|
| [NNNN](NNNN-title.md) | Title | YYYY-MM-DD | Accepted |
```

Append new rows; never remove existing rows.

### Step 5: Cross-link Back (optional)

Offer via **AskUserQuestion**: "Add a reference to this ADR in the source plan/spec frontmatter?"

If yes, append to the source file's YAML frontmatter:
```yaml
adr-refs:
  - docs/adr/NNNN-<title>.md
```

### Step 6: Next Steps

Use **AskUserQuestion**:
> "ADR written at `docs/adr/NNNN-<title>.md`. What next?"

Options:
1. **Record another decision** — repeat for the next candidate
2. **Run `batch-issues`** — decompose `docs/plans/<feature-name>.md` into GitHub issues
3. **Done**

## Key Principles

- **One decision per ADR** — never bundle multiple unrelated choices
- **Permanent** — ADRs are never deleted; superseded ones get `status: Superseded` and a `supersedes: NNNN` field added to the new ADR
- **Implementation-agnostic context** — describe the problem, not the code
- **Honest about trade-offs** — always fill in "Negative / Trade-offs"
