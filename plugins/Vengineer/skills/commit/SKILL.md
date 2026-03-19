---
name: commit
description: Analyze recent session changes, propose a conventional commit message, and execute the commit after user confirmation. Use at the end of a work session to commit what was changed.
allowed-tools:
  - Bash
  - AskUserQuestion
preconditions:
  - Inside a git repository
  - Staged or unstaged changes present
---

# Commit Skill

**Purpose**: Analyze the current git state, propose a well-structured conventional commit message, and execute the commit after user confirmation.

## Step 1: Assess Changes

Run these in parallel:

```bash
git status
git diff --staged
git diff
```

If nothing to commit (clean working tree and no staged changes), report:
```
Nothing to commit — working tree is clean.
```
and exit.

## Step 2: Group Changes by Context

Review the diff and identify logical change groups:

- If all changes relate to a **single concern** → propose one commit
- If changes span **multiple unrelated areas** → present via **AskUserQuestion**:

  > "These changes touch multiple areas: [area 1], [area 2]. Would you like to split into separate commits, or group them into one?"

  Options:
  - Group into one commit
  - Split into N commits (name each one)
  - Let me decide (show me the diff)

## Step 3: Propose Commit Message

Generate a commit message following [Conventional Commits](https://www.conventionalcommits.org/):

**Type selection** (pick the most accurate):
- `feat`: new feature or capability
- `fix`: bug fix
- `chore`: maintenance, config, dependencies
- `docs`: documentation only
- `refactor`: code restructure without behavior change
- `style`: formatting, missing semicolons, etc.
- `test`: adding or updating tests
- `perf`: performance improvement

**Format**:
```
<type>(<optional-scope>): <subject>

<optional body — explain WHY if not obvious>
```

**Rules**:
- Subject ≤ 72 characters
- Subject in imperative mood ("add", "fix", "update" not "added", "fixed")
- No period at end of subject
- Body explains motivation, not mechanics

**Present to user via AskUserQuestion**:

> "Proposed commit message:
>
> ```
> <type>(<scope>): <subject>
>
> <body if needed>
> ```
>
> What would you like to do?"

Options:
- Accept and commit
- Edit the message
- Cancel — don't commit

## Step 4: Execute Commit

If user accepts:

```bash
# Stage all modified tracked files (don't use git add -A, stage specifically)
git add <list of changed files from git status>
git commit -m "<message>"
```

Show result:
```
✓ Committed: <hash> — <subject>
```

If user wants to edit the message:
- Ask them to provide the revised message
- Then execute with their message

If user cancels:
- Exit without committing

## Step 5: Optional Next Steps

After successful commit, ask via **AskUserQuestion**:

> "Commit created. What next?"

Options:
- Done
- Push to remote (`git push`)
- Create a PR (`gh pr create`)

## Key Principles

- **Never use `git add -A` or `git add .`** — only stage the files that appear in the diff
- **Never commit without user confirmation**
- **Conventional Commits only** — always include a type prefix
- **One logical concern per commit** — flag mixed changes
- **Never skip hooks** (`--no-verify`) unless explicitly asked
