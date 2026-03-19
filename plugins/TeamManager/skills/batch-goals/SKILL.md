---
name: batch-goals
description: Parse planning documents and batch-create Goal Issues in your GitHub Project. Configure your team in references/config.md before first use.
---

# Batch Goals

## Overview

Batch-create Goal Issues from planning documents. Read the document semantically, extract goals per Area, and create fully-configured Issues in one shot.

## Setup Check

Before proceeding, verify `references/config.md` exists and contains the required GitHub Project configuration. If missing, direct the user to set it up (see team-manage skill for instructions).

Read config values: `org`, `repo`, `project-number`, `project-id`, `area-field-id`, `iteration-field-id`, `status-field-id`, `todo-option-id`, `members`, `areas`, `iterations`.

## Workflow

### Step 1: Receive and Understand the Document

The user pastes a planning document (sprint sketch, meeting notes, requirement list, or any freeform text). Read it holistically — do NOT apply rule-based parsing. Understand:

- Which **Area** each goal belongs to (from config.md area definitions)
- The concrete, actionable objectives
- Sub-task structure (parent goal → child tasks)
- Who should own each goal (infer from Area→member mapping in config)
- Which **Iteration** to target (match dates or sprint names from config)

### Step 2: Generate Creation Plan

Present a structured plan for confirmation:

```
## Creation Plan

### Area: [Area Name] (N goals)
1. [Goal Title] — @assignee — [Iteration Name]
   - Success criteria: ...
2. ...

Total: N Goal Issues
Iteration: [Name] ([start] ~ [end])
```

Wait for user confirmation. If the user wants changes, adjust and re-present.

### Step 3: Batch Create Issues

For each goal:

1. **Create the Issue**:

```bash
gh issue create --repo <org>/<repo> \
  --title "[Goal] <goal title>" \
  --label "goal" \
  --assignee "<github_username>" \
  --body "<body>"
```

Issue body structure:
```markdown
## Goal

<one-line goal description>

## Background

<context from the planning document>

## Success Criteria

- [ ] <criterion 1>
- [ ] <criterion 2>

## Scope

**Includes:** <scope>
**Excludes:** <out of scope, if mentioned>
```

2. **Add to Project**:

```bash
gh project item-add <project-number> --owner <org> --url <issue_url>
```

3. **Set Project fields** (Status=Todo, Area, Iteration) using field IDs from config.md.

### Step 4: Report Results

After all issues are created, provide a summary table:

```
## Done

| # | Title | Area | Assignee | Issue |
|---|-------|------|----------|-------|
| 1 | ... | Backend | @user | #XX |

Created N Goal Issues, added to [Project Name] [Iteration].
```

## Important Notes

- Always read `references/config.md` before starting
- If a goal's Area is ambiguous, ask the user
- If assignees are not clear, suggest based on Area→member mapping but confirm
- Set Status to "Todo" for all newly created issues
- Handle errors gracefully — if one issue fails, continue and report failures at the end
