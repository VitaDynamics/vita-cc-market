---
name: ask
description: Ask a question about the codebase using parallel exploration agents
allowed-tools:
  - Task
preconditions:
  - Question about codebase provided
  - User wants comprehensive answer
---

# Ask Skill

**Purpose**: Answer questions about the codebase by orchestrating parallel exploration agents.

User Question: "${ARGUMENTS}"

## Strategy

1. **Analyze**: Determine if the question is simple or complex.
   - **Simple** (targeted query): Launch 1-3 parallel agents.
   - **Complex** (broad/architectural): Launch >3 parallel agents.

2. **Orchestrate**:
   - Break the question into distinct search angles (e.g., "Find definitions", "Check usage", "Search config", "Check tests").
   - Use the `Task` tool to launch multiple agents in parallel.
   - Set `subagent_type` to `"Explore"` for each task (builtin agent).
   - If Explore agent is unavailable, use `subagent_type="general-purpose"` as fallback.
   - **Include the search directory scope** in each agent's prompt (e.g., "Search in /path/to/module for...").
   - Pass specific, distinct instructions to each agent.

3. **Synthesize**:
   - Review the findings from all agents.
   - Provide a comprehensive answer to the user's question.
   - Reference specific file paths found.

## Execution

Perform the analysis and launch the parallel tasks now.