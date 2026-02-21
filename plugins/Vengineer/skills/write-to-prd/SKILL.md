This skill will be invoked when the user wants to create a PRD. You should go through the steps below. You may skip steps if you don't consider them necessary.

**Check for existing brainstorm first:**

Before starting from scratch, check if there's an existing product brainstorm in `plans/sketches/`:
- List files in `plans/sketches/` directory
- If brainstorm files exist (`*-brainstorm.md`), ask the user: "I found existing brainstorms. Would you like to create a PRD from one of them, or start fresh?"
- If user selects a brainstorm, read it and use it as the foundation for the PRD
- The brainstorm should contain: user context, visual concepts, chosen approach, key interactions, and open questions
- Use this information to jump-start steps 1-4 below

1. **Problem Understanding** (skip or enhance if using brainstorm):

If starting from scratch: Ask the user for a long, detailed description of the problem they want to solve and any potential ideas for solutions.

If using brainstorm: Extract the problem statement, user context (WHO/WHAT/WHY), and chosen approach from the brainstorm. Clarify any open questions noted in the brainstorm.

2. **Codebase Exploration**:

Explore the repo to verify their assertions and understand the current state of the codebase.

If using brainstorm: Focus exploration on areas relevant to the chosen approach from the brainstorm.

3. **Deep Dive Interview**:

Interview the user relentlessly about every aspect of this plan until you reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one.

If using brainstorm: Use the "Key Interactions" and "Open Questions" sections from the brainstorm as starting points for this interview. The visual concepts may already provide a shared understanding, so you may be able to move faster.

4. **Module Design**:

Sketch out the major modules you will need to build or modify to complete the implementation. Actively look for opportunities to extract deep modules that can be tested in isolation.

A deep module (as opposed to a shallow module) is one which encapsulates a lot of functionality in a simple, testable interface which rarely changes.

Check with the user that these modules match their expectations. Check with the user which modules they want tests written for.

If using brainstorm: The visual concepts and chosen approach may already hint at module boundaries. Use these as a starting point for module design discussions.

5. Once you have a complete understanding of the problem and solution, use the template below to write the PRD. The PRD should be submitted as a GitHub issue.

<prd-template>

## Problem Statement

The problem that the user is facing, from the user's perspective.

## Solution

The solution to the problem, from the user's perspective.

## User Stories

A LONG, numbered list of user stories. Each user story should be in the format of:

1. As an <actor>, I want a <feature>, so that <benefit>

<user-story-example>
1. As a mobile bank customer, I want to see balance on my accounts, so that I can make better informed decisions about my spending
</user-story-example>

This list of user stories should be extremely extensive and cover all aspects of the feature.

## Implementation Decisions

A list of implementation decisions that were made. This can include:

- The modules that will be built/modified
- The interfaces of those modules that will be modified
- Technical clarifications from the developer
- Architectural decisions
- Schema changes
- API contracts
- Specific interactions

Do NOT include specific file paths or code snippets. They may end up being outdated very quickly.

## Testing Decisions

A list of testing decisions that were made. Include:

- A description of what makes a good test (only test external behavior, not implementation details)
- Which modules will be tested
- Prior art for the tests (i.e. similar types of tests in the codebase)

## Out of Scope

A description of the things that are out of scope for this PRD.

## Further Notes

Any further notes about the feature.

</prd-template>

## Integration with Talk Skill

This skill can consume output from the **talk(product-brainstorm)** skill:

**Workflow:**
1. **talk** skill → Creates visual brainstorm in `plans/sketches/YYYY-MM-DD-<topic>-brainstorm.md`
2. **write-to-prd** skill (this skill) → Consumes brainstorm, creates formal PRD
3. **medium-plan** skill → Creates technical implementation plan from PRD

**Brainstorm Structure:**
When reading a brainstorm file, expect these sections:
- **User Context**: WHO the user is, WHAT they need, WHY it matters
- **Visual Concepts**: 2-3 ASCII sketches of different approaches
- **Chosen Approach**: Detailed sketch with flows and rationale
- **Key Interactions**: Critical user actions and system responses
- **Open Questions**: Things to explore during PRD creation

**Benefits of Using Brainstorm:**
- Jump-starts problem understanding (step 1)
- Provides visual foundation for discussions (step 3)
- Hints at module boundaries (step 4)
- Resolves open questions early in the process

**Note:** The brainstorm is exploratory and may lack technical depth. Your job is to formalize the product thinking into a structured PRD with implementation decisions, user stories, and testing strategy.