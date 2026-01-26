---
name: clarify
description: Clarify requirements by asking targeted questions to reduce ambiguity before planning
allowed-tools:
  - AskUserQuestion
  - Read
  - Write
  - Edit
  - Grep
  - Glob
preconditions:
  - Feature description or context provided for clarification
---

# Clarify Skill

**Purpose**: Detect and reduce ambiguity in feature requests by asking targeted clarification questions and updating plans with the results.

User Input: "${ARGUMENTS}"

**If the input above is empty, ask the user using AskUserQuestion:** "What feature, bug, or improvement would you like to clarify? Please provide a brief description."

Do not proceed until you have input to clarify.

## Stage 1: Ambiguity & Coverage Scan

Analyze the user input against this taxonomy. For each category, mark status: **Clear** / **Partial** / **Missing**.

### Taxonomy Categories

| Category | What to Check |
|----------|---------------|
| **Functional Scope** | Core user goals, success criteria, out-of-scope declarations |
| **Domain & Data Model** | Entities, attributes, relationships, identity rules, state transitions |
| **Interaction & UX Flow** | User journeys, error/empty/loading states, accessibility |
| **Non-Functional Requirements** | Performance targets, scalability, reliability, security, observability |
| **Integration & Dependencies** | External services/APIs, data formats, failure modes |
| **Edge Cases & Errors** | Negative scenarios, rate limiting, conflict resolution |
| **Constraints & Tradeoffs** | Technical constraints, explicit tradeoffs, rejected alternatives |
| **Terminology** | Canonical terms, avoided synonyms |

### Coverage Assessment

After scanning, produce an internal coverage map:
- **Clear**: Sufficient information provided
- **Partial**: Some information but gaps exist
- **Missing**: No information provided, critical for implementation

## Stage 2: Generate Clarification Questions

Based on the coverage scan, generate a prioritized queue of up to **5 questions**.

### Question Constraints

Each question must be:
- Answerable with **multiple choice (2-5 options)** OR **short answer (≤5 words)**
- **High impact**: Materially affects architecture, data modeling, task decomposition, or testing
- **Not already answered** in the user input
- **Not trivial** stylistic preferences

### Question Prioritization

Prioritize by: `Impact × Uncertainty`
- Cover highest-impact unresolved categories first
- Avoid asking two low-impact questions when a high-impact area is unresolved

## Stage 3: Sequential Questioning (Using AskUserQuestion Tool)

**IMPORTANT:** Use the **AskUserQuestion tool** to present each question. Present **ONE question at a time**.

### For Multiple-Choice Questions

1. **Analyze options** and determine the most suitable based on:
   - Best practices for the project type
   - Common patterns in similar implementations
   - Risk reduction (security, performance, maintainability)

2. **Use AskUserQuestion with options:**
   - Put recommended option first with "(Recommended)" suffix
   - Provide 2-4 clear options
   - Include description for each option

3. **Example AskUserQuestion call:**
   ```
   Question: "How should user authentication be handled?"
   Options:
   - "JWT tokens (Recommended)" - Stateless, scalable, industry standard
   - "Session-based" - Server-side sessions with cookies
   - "OAuth only" - Delegate to third-party providers
   ```

### For Short-Answer Questions

Use AskUserQuestion with options that include common choices:
```
Question: "What is the expected maximum number of concurrent users?"
Options:
- "< 100 users" - Small scale, simple infrastructure
- "100-1000 users" - Medium scale, may need caching
- "1000+ users (Recommended)" - Large scale, requires optimization
```

### After Each Answer

- Record the answer
- Move to next question
- Stop when: all critical ambiguities resolved, user signals "done", or 5 questions asked

## Stage 4: Update Plan with Clarifications

**After all questions are answered, append clarifications to the plan file.**

### If plan file exists (`plans/<topic>.md`):

Add a new section to the plan:

```markdown
## Clarifications

**Session:** [DATE]

### Questions & Answers

| # | Question | Answer | Category |
|---|----------|--------|----------|
| 1 | [Question 1] | [Answer 1] | Functional Scope |
| 2 | [Question 2] | [Answer 2] | Data Model |
| ... | ... | ... | ... |

### Coverage Summary

| Category | Status |
|----------|--------|
| Functional Scope | Resolved |
| Domain & Data Model | Clear |
| Integration & Dependencies | Deferred |
| ... | ... |

### Key Decisions

- **[Decision 1]**: [Rationale based on answer]
- **[Decision 2]**: [Rationale based on answer]
```

### If plan file does not exist:

Create a new clarifications file at `plans/clarifications-<topic>.md` with the same format, which can be referenced when running `/core:plan`.

## Stage 5: Next Steps

Use AskUserQuestion to present options:

**Question:** "Clarification complete. [X] questions answered. Plan updated. What would you like to do next?"

**Options:**
1. **Run `/core:plan`** - Create/update the plan with these clarifications (Recommended)
2. **Ask more questions** - Continue clarifying specific areas
3. **View clarifications** - Show the clarifications section that was added
4. **Start over** - Reset and re-clarify from scratch

## Behavior Rules

- **Always use AskUserQuestion tool** for gathering user input
- If no meaningful ambiguities found → "No critical ambiguities detected. Ready for `/core:plan`."
- Never exceed 5 questions total
- Respect early termination signals ("done", "stop", "proceed")
- Do not ask speculative tech stack questions unless blocking functional clarity
- **Always update the plan file** with clarifications after completion