---
name: create-command
description: Create a new custom slash command following conventions and best practices
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
preconditions:
  - Command purpose and requirements provided
---

# Create Command Skill

**Purpose**: Create a new custom slash command following Claude Code conventions and best practices.

## Goal

"${ARGUMENTS}"

## Key Capabilities to Leverage

**File Operations:**
- Read, Edit, Write - modify files precisely
- Glob, Grep - search codebase
- MultiEdit - atomic multi-part changes

**Development:**
- Bash - run commands (git, tests, linters)
- Task - launch specialized agents for complex tasks
- TodoWrite - track progress with todo lists

**Web & APIs:**
- WebFetch, WebSearch - research documentation
- GitHub (gh cli) - PRs, issues, reviews
- Playwright - browser automation, screenshots

**Integrations:**
- AppSignal - logs and monitoring
- Context7 - framework docs
- Stripe, Todoist, Featurebase (if relevant)

## Best Practices

1. **Be specific and clear** - detailed instructions yield better results
2. **Break down complex tasks** - use step-by-step plans
3. **Use examples** - reference existing code patterns
4. **Include success criteria** - tests pass, linting clean, etc.
5. **Think first** - use "think hard" or "plan" keywords for complex problems
6. **Iterate** - guide the process step by step

## Required: YAML Frontmatter

**EVERY command MUST start with YAML frontmatter:**

```yaml
---
name: command-name
description: Brief description of what this command does (max 100 chars)
argument-hint: "[what arguments the command accepts]"
---
```

**Fields:**
- `name`: Lowercase command identifier (used internally)
- `description`: Clear, concise summary of command purpose
- `argument-hint`: Shows user what arguments are expected (e.g., `[file path]`, `[PR number]`, `[optional: format]`)

## Structure Your Command

```markdown
# [Command Name]

[Brief description of what this command does]

## Steps

1. [First step with specific details]
   - Include file paths, patterns, or constraints
   - Reference existing code if applicable

2. [Second step]
   - Use parallel tool calls when possible
   - Check/verify results

3. [Final steps]
   - Run tests
   - Lint code
   - Commit changes (if appropriate)

## Success Criteria

- [ ] Tests pass
- [ ] Code follows style guide
- [ ] Documentation updated (if needed)
```

## Tips for Effective Commands

- **Use $ARGUMENTS placeholder** for dynamic inputs
- **Reference CLAUDE.md** patterns and conventions
- **Include verification steps** - tests, linting, visual checks
- **Be explicit about constraints** - don't modify X, use pattern Y
- **Use XML tags** for structured prompts: `<task>`, `<requirements>`, `<constraints>`