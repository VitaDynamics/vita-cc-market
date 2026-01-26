---
name: work
description: Execute work plans efficiently while maintaining quality and finishing features
allowed-tools:
  - Task
  - Read
  - Write
  - Edit
  - Bash
  - Skill
  - AskUserQuestion
preconditions:
  - Plan file, specification, or todo file path provided
---

# Work Skill

**Purpose**: Execute a work plan efficiently while maintaining quality and finishing features.

## Input Document

<input_document> ${ARGUMENTS} </input_document>

## Execution Workflow

### Phase 1: Quick Start

1. **Read Plan and Clarify**
   - Read the work document completely
   - Review any references or links provided in the plan
   - If anything is unclear or ambiguous, ask clarifying questions now
   - Get user approval to proceed
   - **Do not skip this** - better to ask questions now than build the wrong thing

2. **Setup Environment**
   Choose your work style:

   **Option A: Live work on current branch**
   ```bash
   git checkout main && git pull origin main
   git checkout -b feature-branch-name
   ```

   **Option B: Parallel work with worktree (recommended for parallel development)**
   ```bash
   # Ask user first: "Work in parallel with worktree or on current branch?"
   # If worktree:
   skill: git-worktree
   # The skill will create a new branch from main in an isolated worktree
   ```

   **Recommendation**: Use worktree if:
   - You want to work on multiple features simultaneously
   - You need to keep the main branch clean
   - You're reviewing code in isolation

### Phase 2: Implementation

1. **Analyze and Decompose**
   - Break the plan into manageable tasks
   - Identify dependencies between tasks
   - Create a todo list for tracking progress

2. **Follow Existing Patterns**
   - Search for similar implementations in the codebase
   - Reuse established patterns and conventions
   - Avoid reinventing the wheel

3. **Continuous Testing**
   - Run tests after each significant change
   - Verify behavior matches acceptance criteria
   - Fix issues as they arise, not at the end

4. **Iterative Development**
   - Build in small, verifiable increments
   - Get feedback on each increment
   - Adjust approach based on findings

### Phase 3: Quality Assurance

1. **Code Review**
   - Review your own code before considering it complete
   - Check for common issues and edge cases
   - Ensure readability and maintainability

2. **Final Testing**
   - Run full test suite
   - Verify all acceptance criteria are met
   - Test edge cases and error conditions

3. **Documentation**
   - Update relevant documentation
   - Add comments where necessary
   - Record any decisions or trade-offs

### Phase 4: Completion

1. **Final Review**
   - Verify all requirements are satisfied
   - Ensure no regressions introduced
   - Confirm code follows project standards

2. **Commit and Push**
   - Create descriptive commit message
   - Push changes to remote repository
   - Link back to original plan or issue

3. **Next Steps**
   - Present options for what to do next
   - Offer to create PR, run additional tests, or move to next task

## Key Principles

1. **Ship Complete Features**: Focus on delivering working, tested functionality
2. **Follow Conventions**: Adhere to project patterns and best practices
3. **Maintain Quality**: Never compromise on testing and code review
4. **Communicate Clearly**: Ask questions early, provide updates regularly

## Output

- Implemented feature with passing tests
- Updated documentation as needed
- Commit with descriptive message
- Optionally: PR ready for review