# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is **vita-cc-market**, a marketplace for Claude Code plugins. It contains the **Vengineer** plugin - a best practices and utility plugin for Claude Code workflows.

### Repository Structure

```
vita-cc-market/
├── plugins/
│   ├── Vengineer/              # Main BCP (Best Current Practice) plugin
│   │   ├── agents/             # Subagent definitions
│   │   ├── commands/           # Slash commands
│   │   ├── skills/             # User-invocable skills
│   │   └── hooks/              # Plugin hooks
│   └── Vengineer-RCP/          # RCP-specific plugin (legacy)
└── .claude-plugin/
    └── marketplace.json        # Plugin marketplace metadata
```

## Plugin Architecture

### Vengineer Plugin Components

**Commands** (`plugins/Vengineer/commands/`):
- `core/plan.md` - Transform feature descriptions into well-structured project plans
- `core/work.md` - Execute work plans efficiently while maintaining quality
- `core/review.md` - Perform exhaustive code reviews using multi-agent analysis
- `core/deepen-plan.md` - Enhance plans with parallel research agents
- `core/plan_review.md` - Get feedback from specialized reviewers
- `core/compound.md` - Document solved problems as categorized documentation
- `utils/` - Utility commands for agent skill creation, command creation, skill healing

**Agents** (`plugins/Vengineer/agents/`):
- `core/general.md` - General-purpose exploration agent
- `review/` - Specialized code reviewers (architecture, performance, security, patterns, etc.)
- `research/` - Research agents (best practices, framework docs, git history, repo analysis)

**Skills** (`plugins/Vengineer/skills/`):
- `compound-docs/` - Capture solved problems as categorized documentation with YAML frontmatter
- `create-agent-skills/` - Create or edit Claude Code skills
- `git-worktree/` - Manage Git worktrees for isolated parallel development
- `skill-creator/` - Guide for creating effective skills
- `hook-creator/` - Guide for creating Claude Code hooks

**Hooks** (`plugins/Vengineer/hooks/`):
- `add-language-context.py` - Automatically adds language preference (Chinese/English) to context based on user input

## MCP Server Configuration

The Vengineer plugin integrates several MCP servers (defined in `.mcp.json`):
- **exa** - Web search via https://mcp.exa.ai/mcp
- **deepwiki** - GitHub repository documentation via https://mcp.deepwiki.com/sse
- **context7** - Library documentation via https://mcp.context7.com/mcp

## Key Workflow Commands

### Planning Phase
Use `/core:plan` to create structured project plans:
- Runs parallel research agents (repo, best practices, framework docs)
- Performs SpecFlow analysis for gap identification
- Supports MINIMAL/MORE/A LOT detail levels
- Outputs to `plans/<issue_title>.md`

### Working Phase
Use `/core:work` to execute plans:
- Reads work documents and clarifies requirements
- Supports worktree-based parallel development
- Implements following existing patterns
- Runs tests continuously
- Creates commits and PRs with screenshots for UI changes

### Review Phase
Use `/core:review` for comprehensive code reviews:
- Runs 13+ parallel reviewer agents
- Creates structured todos in `todos/` directory using file-todos skill
- Supports P1/P2/P3 severity classification
- Optionally runs Playwright/Xcode tests

### Documentation
Use `/core:compound` to document solved problems:
- Auto-triggers on confirmation phrases ("that worked", "it's fixed")
- Creates categorized docs with YAML frontmatter in `docs/solutions/`
- Validates against YAML schema
- Supports cross-references and critical pattern detection

## Language Context Hook

The plugin includes an automatic language detection hook that:
- Detects Chinese vs English input (>30% Chinese characters)
- Adds appropriate language instructions to Claude's context
- Ensures user-facing content matches input language
- Keeps code/config files in English

## File-Based Todo System

Uses `file-todos` skill for structured issue tracking:
- Location: `todos/` directory
- Format: `{issue_id}-{status}-{priority}-{description}.md`
- Status values: `pending`, `ready`, `complete`
- Priority values: `p1` (critical), `p2` (important), `p3` (nice-to-have)
- YAML frontmatter with tags, dependencies, and metadata

## Development Guidelines

### When Adding New Commands

1. Create markdown file in appropriate `commands/` subdirectory
2. Include YAML frontmatter: `name`, `description`, `argument-hint`
3. Follow existing command structure (see `core/plan.md` as reference)
4. Use parallel Task agents for multi-step workflows
5. Include post-generation options with AskUserQuestion tool

### When Adding New Agents

1. Create markdown file in appropriate `agents/` subdirectory
2. Define clear purpose and expertise areas
3. Specify allowed tools and preconditions
4. Include integration protocols and handoff expectations

### When Adding New Skills

1. Use `/utils/create-agent-skill` command for structure
2. Create SKILL.md with proper frontmatter
3. Include allowed-tools, preconditions, and workflow steps
4. Add decision gates where user interaction is required
5. Test with `/utils/heal-skill` for validation

## Git Workflow

The repository uses multiple remotes:
- `origin` - git@codeup.aliyun.com:vbot/VitaCore/vita-cc-market.git
- `main` - https://github.com/VitaDynamics/vita-cc-market.git

Use git-worktree skill for parallel development without cluttering main branch.

## Marketplace Configuration

Plugin metadata is in `.claude-plugin/marketplace.json`:
- Plugin name, version, description
- Author contact information
- Source directory mapping

## Testing

No automated test suite exists. Manual testing involves:
- Invoking commands with various inputs
- Verifying agent outputs
- Testing hooks with different language inputs
- Validating skill YAML frontmatter
