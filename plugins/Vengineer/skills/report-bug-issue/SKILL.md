---
name: report-bug-issue
description: Report a bug or request a feature in the Vengineer plugin
allowed-tools:
  - Read
  - Write
  - Bash
  - AskUserQuestion
preconditions:
  - Bug or feature description available
---

# Report Bug Issue Skill

**Purpose**: Report bugs or request features for the Vengineer plugin. This command gathers structured information and creates a GitHub issue in the VitaDynamics/vita-cc-market repository.

## Step 0: Verify GitHub CLI Authentication

Before proceeding, verify that the user has authenticated with the GitHub CLI:

```bash
# Check if gh is authenticated
gh auth status
```

If the user is NOT authenticated:
- Prompt them to run `gh auth login` first
- Explain this is required to create issues directly
- Offer to help them authenticate or provide the option to manually create the issue

If authenticated, proceed to Step 1.

## Step 1: Determine Request Type

First, ask the user what type of report they want to submit:

**Question: Report Type**
- Options:
  - Bug Report: Report a problem or unexpected behavior
  - Feature Request: Suggest a new feature or enhancement
  - Both: Report a bug AND request a feature

Proceed to Step 2 with the appropriate context.

## Step 2: Gather Bug Information

Use the AskUserQuestion tool to collect the following information:

**Question 1: Bug Category**
- What type of issue are you experiencing?
- Options: Agent not working, Command not working, Skill not working, MCP server issue, Installation problem, Other

**Question 2: Specific Component**
- Which specific component is affected?
- Ask for the name of the agent, command, skill, or MCP server

**Question 3: What Happened (Actual Behavior)**
- Ask: "What happened when you used this component?"
- Get a clear description of the actual behavior

**Question 4: What Should Have Happened (Expected Behavior)**
- Ask: "What did you expect to happen instead?"
- Get a clear description of expected behavior

**Question 5: Steps to Reproduce**
- Ask: "What steps did you take before the bug occurred?"
- Get reproduction steps

**Question 6: Error Messages**
- Ask: "Did you see any error messages? If so, please share them."
- Capture any error output

## Step 2: Collect Environment Information

Automatically gather:
```bash
# Get plugin version
cat ~/.claude/plugins/installed_plugins.json 2>/dev/null | grep -A5 "Vengineer" | head -10 || echo "Plugin info not found"

# Get Claude Code version
claude --version 2>/dev/null || echo "Claude CLI version unknown"

# Get OS info
uname -a
```

## Step 3: Format the Report

Create a well-structured report based on the request type:

**For Bug Reports:**
```markdown
## Bug Description

**Component:** [Type] - [Name]
**Summary:** [Brief description from argument or collected info]

## Environment

- **Plugin Version:** [from installed_plugins.json]
- **Claude Code Version:** [from claude --version]
- **OS:** [from uname]

## What Happened

[Actual behavior description]

## Expected Behavior

[Expected behavior description]

## Steps to Reproduce

1. [Step 1]
2. [Step 2]
3. [Step 3]

## Error Messages

```
[Any error output]
```

## Additional Context

[Any other relevant information]

---
*Reported via `/report-bug` command*
```

**For Feature Requests:**
```markdown
## Feature Request

**Component:** [Type] - [Name]
**Summary:** [Brief description]

## Proposed Feature

[Describe the feature you want to see implemented]

## Motivation

[Explain why this feature would be useful]

## Proposed Solution

[If you have ideas on how this could be implemented, describe them here]

## Alternatives Considered

[Any alternative approaches you've considered]

## Additional Context

[Any other relevant information]

---
*Reported via `/report-bug` command*
```

## Step 4: Offer to Create GitHub Issue

After formatting the report, ask the user:

**Question: Action**
- Options:
  - Create GitHub Issue: Automatically create issue using `gh issue create`
  - Copy to Clipboard: Just copy the formatted markdown
  - Show Preview: Display formatted markdown first

If user selects "Create GitHub Issue":
```bash
# Create issue with appropriate labels
gh issue create --title "[Report Type]: [Brief description]" --body "$REPORT_CONTENT" --label "bug" --label "plugin" --repo "VitaDynamics/vita-cc-market"
```

Provide the issue URL to the user.