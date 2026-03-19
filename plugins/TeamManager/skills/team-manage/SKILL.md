---
name: team-manage
description: Agentic team management for GitHub Projects. View project status, update goals, manage assignments, check workload, and clean up duplicates. Configure your team in references/config.md before first use.
---

# Team Manage

## Overview

Manage your team's GitHub Project. Query status, update goals, reassign work, and maintain project hygiene.

## Setup Check

**Before any action**, verify `references/config.md` exists in the current directory (or plugin root).

If it does NOT exist:
```
⚠️ Team Manager is not configured.

To get started:
1. Copy references/config-template.md → references/config.md
2. Fill in your org, repo, project number, field IDs, and team members
3. Get field IDs with: gh project field-list <number> --owner <org> --format json

Once configured, run this skill again.
```
Then stop.

If it exists, read it and proceed.

## Capabilities

### 1. View Status

**Trigger**: User asks about project status, current goals, sprint progress.

```bash
gh project item-list <project-number> --owner <org> --format json --limit 100
```

Default grouping: **Area → Status**. Also support: Iteration, Assignee, Status.

Present as a grouped list with emoji status indicators:
- `[ ]` Todo
- `[~]` In Progress
- `[x]` Done

### 2. Update Goal Status

**Trigger**: User wants to change an issue's status.

1. Find the issue by number, title search, or previous listing
2. Update the Status field using IDs from config.md:

```bash
gh project item-edit \
  --project-id <project-id> \
  --id <ITEM_ID> \
  --field-id <status-field-id> \
  --single-select-option-id <status-option-id>
```

### 3. Manage Assignments

**Trigger**: User wants to reassign a goal.

```bash
# Add assignee
gh issue edit <NUMBER> --repo <org>/<repo> --add-assignee <username>

# Remove assignee
gh issue edit <NUMBER> --repo <org>/<repo> --remove-assignee <username>
```

### 4. Close Goal

**Trigger**: User wants to close/complete a goal.

1. Close the issue:
```bash
gh issue close <NUMBER> --repo <org>/<repo>
```

2. Update project status to "Done" using the done-option-id from config.md.

### 5. View Workload

**Trigger**: User asks about team workload or capacity.

Query all open items and aggregate by assignee. Present as a table showing Todo / In Progress / Done counts per member per area.

### 6. Clean Duplicates

**Trigger**: User asks to check for or clean up duplicate issues.

1. Fetch all open issues with "goal" label
2. Compare titles for similarity (semantic, not just exact match)
3. Present potential duplicates for user review
4. Close confirmed duplicates with a comment linking to the canonical issue

## Important Notes

- Always read `references/config.md` before executing commands
- For bulk operations, confirm with the user before executing
- Show issue URLs in results so the user can click through
- When listing items, use `--limit 100` to ensure full results
