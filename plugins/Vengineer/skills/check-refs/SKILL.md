---
name: check-refs
description: Scan all docs/ markdown files for broken cross-references, validate frontmatter links, detect orphaned documents, and offer to fix inconsistencies.
allowed-tools:
  - Read
  - Glob
  - Grep
  - Edit
  - AskUserQuestion
preconditions:
  - A docs/ directory exists with markdown files
---

# Check-Refs Skill

**Purpose**: Audit cross-reference integrity across all planning and documentation artifacts in `docs/`. Finds broken links, inconsistent frontmatter back-links, and orphaned documents.

## Overview

The planning pipeline creates linked artifacts:
```
docs/sketches/ ←→ docs/specs/ ←→ docs/plans/ ←→ docs/adr/
```

Each file should have frontmatter cross-links (e.g., `next-spec:`, `source-sketch:`). This skill validates all such links are consistent and that no markdown links point to missing files.

## Step 1: Discover All Docs

Glob all markdown files:
```
docs/**/*.md
```

Build an inventory: `{ path → frontmatter fields + markdown links }`

## Step 2: Extract Links

For each file, parse:

### Frontmatter cross-links (YAML fields that reference other files):
- `source-sketch:`
- `next-spec:`
- `next-plan:`
- `source-spec:`
- `source-plan:`
- `adr-refs:` (list)
- Any field whose value looks like a file path (`docs/...`)

### Markdown links:
- Pattern: `[text](path)` where path starts with `docs/` or is a relative `.md` file

## Step 3: Validate Links

For each extracted link:
1. Check if the referenced file exists (`Read` or existence check)
2. Track: source file → referenced file (build a link graph)

Classify issues:

| Type | Description | Severity |
|------|-------------|----------|
| **Broken link** | Referenced file does not exist | Critical |
| **Orphan** | File has no incoming OR outgoing links (standalone, unconnected) | Warning |
| **Missing back-link** | e.g., spec has `source-sketch: X` but sketch X lacks `next-spec:` pointing back | Warning |
| **Stale stage** | File has `status: draft` but downstream artifacts are complete | Info |

## Step 4: Report Findings

Present a structured report:

```
## Cross-Reference Audit

### Critical: Broken Links (N)
- docs/specs/auth.md → source-sketch: docs/sketches/auth-design.md [FILE NOT FOUND]
- docs/plans/billing.md → line 42: [see spec](docs/specs/billing-spec.md) [FILE NOT FOUND]

### Warning: Missing Back-Links (N)
- docs/specs/auth.md has source-sketch: docs/sketches/2026-01-15-auth.md
  but docs/sketches/2026-01-15-auth.md is missing next-spec: field

### Warning: Orphaned Docs (N)
- docs/sketches/2025-11-01-old-idea.md — no incoming or outgoing links

### Info: Stale Status (N)
- (none)

Total: N critical, N warnings, N info
```

If no issues found:
```
✓ All cross-references are consistent. No broken links or orphans found.
```

## Step 5: Offer Fixes

For each issue, offer to auto-fix via **AskUserQuestion**:

> "Found N issues. What would you like to do?"

Options:
- Fix all auto-fixable issues (back-links only — broken links cannot be auto-fixed)
- Review and fix one by one
- Show the full report and exit

**Auto-fixable repairs**:
- **Missing back-link**: Add the missing frontmatter field to the target file (e.g., add `next-spec: docs/specs/X.md` to the sketch)
- Use `Edit` tool to insert the field inside the existing `---` YAML block

**Cannot auto-fix**:
- Broken links (file doesn't exist) — report only, suggest the user check if the file was deleted or renamed
- Orphans — report only, let user decide whether to delete or connect them

## Behavior Rules

- **Read-only by default** — only modify files when user explicitly approves fixes
- **Report all issues** before asking about fixes
- **Preserve YAML integrity** — when adding frontmatter fields, insert inside the existing `---` block without duplicating or corrupting existing fields
- **One file at a time** for fixes if user chooses "review one by one"
