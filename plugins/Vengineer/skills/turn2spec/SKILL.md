---
name: turn2spec
description: Transform design docs, ADRs, or rough plans into proper feature specifications
allowed-tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - AskUserQuestion
preconditions:
  - A design document, ADR, rough plan, or file path provided as input
---

# Turn-Into-Spec Skill

**Purpose**: Transform existing design documents, Architecture Decision Records (ADRs), or rough plans into well-structured feature specifications following the project's spec template.

## User Input

```text
$ARGUMENTS
```

**If the input above is empty**, use **AskUserQuestion** to ask: "Please provide a file path to your design doc/ADR/rough plan, or paste the content directly."

Do not proceed until you have material to transform.

## Stage 1: Load Source Material

Determine input type and load accordingly:

- **File path** (e.g., `docs/sketches/2026-01-15-auth.md`, `docs/plans/rough-plan.md`): Read the file using the Read tool.
- **Inline text**: Use the pasted content directly.
- **Multiple files**: Read each file and merge context.

Also load the spec template for reference:
```
plugins/Vengineer/skills/reference/spec_template.md
```

## Stage 2: Analyze & Extract

Parse the source material and extract:

| Element | What to Look For |
|---------|-----------------|
| **Feature Name** | Title, heading, or dominant topic |
| **Actors** | Who uses this — users, admins, systems, services |
| **Core Actions** | What users/systems do — verbs and flows described |
| **Constraints** | Limitations, non-goals, scope boundaries |
| **Success Signals** | Goals, KPIs, "done when" statements |
| **Decisions Made** | ADR rationale, chosen approaches, rejected alternatives |
| **Open Questions** | Unresolved items, TBDs, items marked for future |
| **Data Entities** | Models, schemas, key objects mentioned |

> **Note**: Design docs and ADRs often contain implementation details (tech stack, APIs, framework choices). Strip these during extraction — the spec must remain implementation-agnostic.

## Stage 3: Map to Spec Structure

Using the loaded spec template, map extracted content to spec sections:

### Feature Name & Branch
- Derive a 2-5 word feature name from the document title or dominant theme
- Format branch name as `###-feature-name` (use `000` if no issue number is known)

### User Scenarios & Testing
For each distinct user flow found in the source:
- Write it as a plain-language user story
- Assign priority (P1 = core flow, P2 = important variant, P3 = edge/advanced)
- Define acceptance scenarios as Given/When/Then

### Requirements
- Convert design decisions into `FR-XXX: System MUST [capability]` statements
- Each requirement must be testable and implementation-agnostic
- Mark anything unclear: `[NEEDS CLARIFICATION: specific question]`
- **Hard limit**: Maximum 3 `[NEEDS CLARIFICATION]` markers total

### Key Entities
- List entities from the source, stripped of implementation details (no table schemas, ORM fields, or type annotations — just what the entity represents and its relationships)

### Success Criteria
- Transform goals/KPIs from the source into measurable, technology-agnostic outcomes
- Format: `SC-XXX: [Measurable metric from user/business perspective]`

### Edge Cases
- Surface any unresolved scenarios, failure modes, or boundary conditions mentioned in the source

## Stage 4: Write the Spec

Write the completed spec to `docs/specs/<feature-name>.md` using the template structure.

Add YAML frontmatter at the top of the spec file:
```yaml
---
stage: spec
created: YYYY-MM-DD
feature: <feature-name>
source-sketch: <path to input sketch file if input was from docs/sketches/, else omit>
status: draft
---
```

If the input was from `docs/sketches/`, also update the sketch file's frontmatter to add:
```yaml
next-spec: docs/specs/<feature-name>.md
```
Use the Edit tool to append this field inside the existing `---` block without corrupting other fields.

**Quality rules** (apply before writing):

- [ ] No implementation details: no framework names, language choices, database types, API paths, or infrastructure specifics
- [ ] Written for non-technical stakeholders — business language, not engineering jargon
- [ ] Every requirement is testable and unambiguous
- [ ] Success criteria are measurable and technology-agnostic
- [ ] All mandatory sections from the template are present

## Stage 5: Handle Gaps & Clarifications

If `[NEEDS CLARIFICATION]` markers remain after writing:

1. **Limit check**: Keep only the 3 most critical (by scope/security/UX impact). Make informed guesses for the rest.
2. Present each clarification using **AskUserQuestion** with suggested options:

```
Question: [Topic from NEEDS CLARIFICATION marker]

Context: [Relevant quote from source material]

Options:
- Option A: [Description + implications]
- Option B: [Description + implications]
- Custom: provide your own answer
```

3. Ask **one question at a time**.
4. After all answers collected, update the spec and remove the markers.

## Stage 6: Validate & Finalize

After all clarifications are resolved, do a final pass:

- Confirm all `[NEEDS CLARIFICATION]` markers are resolved or removed
- Confirm no implementation details leaked into the spec
- Confirm every acceptance scenario follows Given/When/Then format
- Confirm success criteria are measurable

Report the result: spec path, number of user stories, number of requirements, any remaining notes.

## Stage 7: Next Steps

Use **AskUserQuestion** to present options:

**Question:** "Spec ready at `docs/specs/<feature-name>.md`. What would you like to do next?"

**Options:**
1. **Run `medium-plan docs/specs/<feature-name>.md`** — Generate implementation plan from this spec (Recommended)
2. **Run `/core:clarify`** — Ask targeted questions to deepen the spec further
3. **Run `/core:plan_review`** — Get feedback from specialized reviewers
4. **Edit spec** — Open the spec file for manual review
5. **Done** — No further action needed

## Behavior Rules

- **Never invent requirements** not grounded in the source material — flag gaps instead
- **Strip implementation details** aggressively: the spec is about *what* and *why*, not *how*
- **Preserve intent**: when source material contains rationale (especially ADR context), surface it in user stories or edge cases rather than discarding it
- **One question at a time** when clarifying
- **Respect existing decisions**: if the source explicitly chose an approach, note it in context but do not encode the choice as a requirement
