---
name: batch-issues
description: Decompose one or more plan files into actionable GitHub issues — one issue per concrete implementation task (~1-4h of work) with title, body, labels, and effort estimate.
allowed-tools:
  - Read
  - Glob
  - Bash
  - Task
  - AskUserQuestion
preconditions:
  - At least one plan file exists in docs/plans/ OR the user provides plan content directly
  - gh CLI is authenticated (gh auth status)
---

# Batch Issues Skill

**Purpose**: Read one or more plan files and decompose them into a set of small, actionable GitHub issues. Each issue maps to a single concrete implementation task estimated at 1-4 hours of work.

## Arguments

`${ARGUMENTS}` — optional path(s) to plan file(s). If omitted, the skill lists available plans and lets the user choose.

---

## Workflow

### 0. Pre-flight check

1. Verify `gh` is available and authenticated:
   ```bash
   gh auth status
   ```
   If not authenticated, print:
   > `gh` CLI is not authenticated. Run `gh auth login` and try again.
   Then stop.

2. Identify the current GitHub repo context:
   ```bash
   gh repo view --json name,owner,defaultBranchRef
   ```

### 1. Select plan file(s)

- If `${ARGUMENTS}` contains file paths, use those directly.
- Otherwise, list all files under `docs/plans/`:
  ```bash
  ls docs/plans/
  ```
  Use **AskUserQuestion** to present the list and let the user pick one or more files (multiple selection enabled).
- If `docs/plans/` is empty or absent, ask the user to paste or describe the plan content directly.

### 2. Analyse each plan — parallel agents

For each selected plan file, spawn a **Task (general)** agent with the following prompt:

```
You are an issue decomposition analyst. Read the plan at <path> and produce a JSON array of actionable GitHub issues.

Rules:
- One issue per concrete implementation task (roughly 1-4 hours of work).
- Tasks that are larger than 4h MUST be split further.
- Group tasks into logical work packages: backend, frontend, infra, test, docs, chore.
- Preserve traceability — reference the originating plan section in each issue body.

For each issue output:
{
  "title": "<conventional-commit-style title, e.g. feat: add OAuth callback endpoint>",
  "work_package": "<backend|frontend|infra|test|docs|chore>",
  "effort": "<S|M|L>",   // S = <2h, M = 2-4h, L = >4h (flag, should be split)
  "body": "<markdown body — see body template below>",
  "labels": ["<type>", "effort:<S|M|L>"],
  "milestone": "<inferred from plan filename or section, or null>"
}

Body template:
## Overview
<1-2 sentence description of the task>

## Acceptance Criteria
- [ ] <specific, testable criterion>
- [ ] ...

## Context
<relevant background, references to plan sections, file paths, or related issues>
```

Collect all agent outputs and merge into a single flat issue list.

### 3. Present issue list for review

Display the full list in a readable table:

```
#  | Work Package | Effort | Title
---|--------------|--------|-------
1  | backend      | M      | feat: add OAuth callback endpoint
2  | backend      | S      | chore: add env var for OAuth client secret
...
```

Flag any `effort: L` items with a warning:
> ⚠ Issue #N has effort L — consider splitting it before creating.

Use **AskUserQuestion** to ask:
> "Here are the N issues I've derived from the plan(s). How would you like to proceed?"

Options:
- **Create all issues** — proceed immediately
- **Edit before creating** — show full issue details; let user adjust titles, bodies, or remove items
- **Cancel** — exit without creating anything

### 4. Create labels & milestone (if needed)

Before creating issues:

1. Fetch existing labels:
   ```bash
   gh label list --json name --jq '.[].name'
   ```
2. For each required label not yet present, create it:
   ```bash
   gh label create "<label>" --color "<auto-pick color>" --description "<description>"
   ```
   Use these default colors:
   | Label | Color |
   |-------|-------|
   | enhancement | `#a2eeef` |
   | bug | `#d73a4a` |
   | chore | `#e4e669` |
   | test | `#0075ca` |
   | docs | `#cfd3d7` |
   | effort:S | `#c2e0c6` |
   | effort:M | `#fef2c0` |
   | effort:L | `#f9d0c4` |

3. If a milestone was inferred, check whether it exists:
   ```bash
   gh milestone list --json title --jq '.[].title'
   ```
   If not, create it:
   ```bash
   gh milestone create --title "<milestone>" --description "Auto-created by batch-issues skill"
   ```

### 5. Create GitHub issues

For each issue in the approved list:

```bash
gh issue create \
  --title "<title>" \
  --body "<body>" \
  --label "<label1>" --label "<label2>" \
  [--milestone "<milestone>"]
```

Print progress as each issue is created:
```
✓ Created #42 — feat: add OAuth callback endpoint
✓ Created #43 — chore: add env var for OAuth client secret
...
```

### 6. Summary & post-creation options

Print a summary table linking each created issue:

```
Created N issues:
#42  [M] feat: add OAuth callback endpoint          → https://github.com/...
#43  [S] chore: add env var for OAuth client secret → https://github.com/...
```

Use **AskUserQuestion** to present options:

> "All N issues created. What next?"

Options:
1. **Open issues in browser** — run `gh issue list --web`
2. **Start `/core:work`** — begin implementing the first issue
3. **Done** — exit

---

## Error Handling

| Situation | Action |
|-----------|--------|
| `gh` not installed | Print install instructions: `brew install gh` |
| Not authenticated | Print `gh auth login` and stop |
| No remote GitHub repo | Print `gh repo create` suggestion and stop |
| Plan file not found | Ask user to verify path or paste content directly |
| Issue creation fails | Print the error, skip that issue, continue with the rest, list failures at end |

---

## Key Principles

- **One task per issue** — resist bundling; small issues are easier to assign, review, and ship
- **Effort L is a smell** — always flag and encourage splitting before creation
- **Traceability** — every issue body must reference the source plan section
- **Review before create** — never create issues without user confirmation
- **Idempotent-friendly** — if the same plan is run twice, remind the user to check for duplicates (`gh issue list --search "<title>"`) before confirming creation
