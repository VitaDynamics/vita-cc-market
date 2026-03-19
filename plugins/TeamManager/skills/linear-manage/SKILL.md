---
name: linear-manage
description: Manage Linear issues and projects via Linear MCP. View active issues, create issues from descriptions, update status/priority/assignee, and view cycle progress. Requires Linear MCP configured in .mcp.json.
allowed-tools:
  - mcp__linear__*
  - AskUserQuestion
preconditions:
  - Linear MCP server configured and authenticated
---

# Linear Manage

**Purpose**: Manage your team's Linear workspace — view active issues, create issues from planning content, update status, and track cycle progress.

## Prerequisites

This skill uses the **Linear MCP server** configured in `.mcp.json`. Ensure you have:
1. Linear MCP enabled in your Claude Code settings
2. A Linear API key configured (Linear MCP handles auth via OAuth or API key)

## Capabilities

### 1. View Active Issues

**Trigger**: User asks about current issues, sprint status, or team workload.

Use Linear MCP tools to:
- List issues for the current cycle/sprint
- Group by: Project, Assignee, Priority, Status
- Filter by: team, label, priority

Present as a grouped table:
```
## Active Issues — [Team Name] — [Cycle Name]

### In Progress (N)
- [ENG-123] Fix auth token refresh — @alice — High
- [ENG-124] Add rate limiting — @bob — Medium

### Todo (N)
- [ENG-125] Update API docs — unassigned — Low

### Done this cycle (N)
- [ENG-120] ✓ Deploy new CI pipeline
```

### 2. Create Issue

**Trigger**: User wants to create a Linear issue from a description or planning doc.

1. Gather: title, description, team, priority (default: Medium), assignee (optional), cycle (optional)
2. Use Linear MCP `create_issue` to create
3. Report: issue ID, URL, and key fields

For batch creation from a plan doc: parse goals/tasks from the document, present a creation plan, confirm with user, then create all issues.

### 3. Update Issue

**Trigger**: User wants to change status, priority, or assignee.

Supported updates:
- Status: Backlog → Todo → In Progress → In Review → Done → Cancelled
- Priority: No Priority / Urgent / High / Medium / Low
- Assignee: team member name or email
- Add label, set due date

### 4. Link to GitHub

**Trigger**: User wants to associate a Linear issue with a GitHub PR or commit.

Use Linear's GitHub integration (if configured) or add a GitHub URL as a comment/attachment on the issue.

### 5. View Cycle Progress

**Trigger**: User asks about sprint health, burndown, or delivery confidence.

Fetch current cycle data and present:
- Issues completed vs. total
- Completion percentage
- Blocked or stale issues (no activity in >3 days)
- Estimate: on track / at risk / behind

## Key Principles

- **Always confirm** before bulk operations (creating 5+ issues)
- **Show URLs** in all issue references for easy click-through
- **Respect priority** — when creating issues from docs, infer priority from language ("critical", "blocker" → Urgent; "nice to have" → Low)
- **One Linear workspace** — this skill operates on the team configured via Linear MCP auth
