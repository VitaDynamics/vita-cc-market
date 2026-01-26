---
name: heal-skill
description: Fix incorrect SKILL.md files when a skill has wrong instructions or outdated API references
allowed-tools:
  - Read
  - Edit
  - Bash(ls:*)
  - Bash(git:*)
preconditions:
  - Skill with incorrect instructions identified
---

# Heal Skill Skill

**Purpose**: Fix incorrect SKILL.md files when a skill has wrong instructions or outdated API references.

<objective>
Update a skill's SKILL.md and related files based on corrections discovered during execution.

Analyze the conversation to detect which skill is running, reflect on what went wrong, propose specific fixes, get user approval, then apply changes with optional commit.
</objective>

<context>
Skill detection: !`ls -1 ./skills/*/SKILL.md | head -5`
</context>

<quick_start>
<workflow>
1. **Detect skill** from conversation context (invocation messages, recent SKILL.md references)
2. **Reflect** on what went wrong and how you discovered the fix
3. **Present** proposed changes with before/after diffs
4. **Get approval** before making any edits
5. **Apply** changes and optionally commit
</workflow>
</quick_start>

<process>
<step_1 name="detect_skill">
Identify the skill from conversation context:

- Look for skill invocation messages
- Check which SKILL.md was recently referenced
- Examine current task context

Set: `SKILL_NAME=[skill-name]` and `SKILL_DIR=./skills/$SKILL_NAME`

If unclear, ask the user.
</step_1>

<step_2 name="reflection_and_analysis">
Focus on $ARGUMENTS if provided, otherwise analyze broader context.

Determine:
- **What was wrong**: Quote specific sections from SKILL.md that are incorrect
- **Discovery method**: Context7, error messages, trial and error, documentation lookup
- **Root cause**: Outdated API, incorrect parameters, wrong endpoint, missing context
- **Scope of impact**: Single section or multiple? Related files affected?
- **Proposed fix**: Which files, which sections, before/after for each
</step_2>

<step_3 name="present_changes">
Present before/after for each affected section:

```
**Before:** [incorrect text]
**After:** [corrected text]

**Reasoning:** [why this change is needed]
```

Get user approval via AskUserQuestion for each significant change.
</step_3>

<step_4 name="apply_changes">
After approval:

1. Use `Read` to load current file
2. Use `Edit` with exact old_string/new_string
3. Verify changes with `Read` after editing
4. Optionally run tests or validation commands
</step_4>

<step_5 name="optional_commit">
If the skill is in a git repository:

1. Check status: `git status`
2. Add changes: `git add [files]`
3. Commit: `git commit -m "fix(skill): correct [specific issue]"`

Present commit hash to user.
</step_5>
</process>