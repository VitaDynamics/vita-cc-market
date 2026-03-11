---
name: arch-flow
description: Orchestrate the full planning pipeline (Sketch → Spec → Plan → ADR) for a feature, resuming automatically from wherever the pipeline left off
allowed-tools:
  - Task
  - Read
  - Write
  - Edit
  - Bash
  - Glob
  - AskUserQuestion
preconditions:
  - A feature topic, idea, or path to an existing pipeline artifact
---

# Arch-Flow Skill

**Purpose**: Top-level orchestrator for the planning pipeline. Runs Sketch → Spec → Plan → ADR in sequence, pausing at each stage gate for user confirmation. Detects existing `docs/` artifacts and resumes from the right stage automatically.

## Input

```
$ARGUMENTS
```

Can be:
- A plain-text feature idea → start from Stage 1 (Sketch)
- `docs/sketches/<file>.md` → start from Stage 2 (Spec)
- `docs/specs/<file>.md` → start from Stage 3 (Plan)
- `docs/plans/<file>.md` → start from Stage 4 (ADR)
- A topic keyword (no path) → auto-detect stage (see below)
- Empty → ask via **AskUserQuestion**: "What feature or topic would you like to plan?"

## Auto-Detection (Resume Protocol)

When given a topic string (not a file path), search for existing artifacts in this order:

```bash
ls docs/plans/ 2>/dev/null | grep -i "<topic>"   # → Stage 4
ls docs/specs/ 2>/dev/null | grep -i "<topic>"   # → Stage 3
ls docs/sketches/ 2>/dev/null | grep -i "<topic>" # → Stage 2
```

If an existing artifact is found, present via **AskUserQuestion**:
> "Found existing [plan/spec/sketch] at [path]. Resume from Stage N ([stage name])? Or start fresh from Stage 1?"

---

## Pipeline

Each stage ends with a **gate** — do not proceed to the next stage without explicit user confirmation.

Display a progress banner at each gate:
```
Pipeline: [✓ Sketch] → [✓ Spec] → [→ Plan] → [ ADR]
```

---

### Stage 1: Sketch (`light-plan`)

**Goal**: Capture a freeform brainstorm/design through dialogue.

Follow the `light-plan` skill workflow:
1. Check current project state (files, docs, recent commits)
2. Ask questions one at a time (multiple choice preferred) to refine the idea
3. Propose 2-3 approaches with trade-offs; lead with your recommendation
4. Present the design in sections of 200-300 words, validate each section
5. Write final sketch to `docs/sketches/YYYY-MM-DD-<topic>.md` with frontmatter:
   ```yaml
   ---
   stage: sketch
   created: YYYY-MM-DD
   topic: <topic>
   status: draft
   ---
   ```

**Gate**: "Sketch complete at `docs/sketches/<file>`. Proceed to spec generation? (Y / edit / stop)"

---

### Stage 2: Spec (`turn2spec`)

**Goal**: Transform the sketch into a formal, implementation-agnostic feature specification.

Follow the `turn2spec` skill workflow:
1. Load `docs/sketches/<file>.md` as source material
2. Extract: Feature Name, Actors, Core Actions, Constraints, Success Signals, Decisions Made, Open Questions, Data Entities
3. Map extracted content to the spec template (`plugins/Vengineer/skills/reference/spec_template.md`)
4. Write spec to `docs/specs/<feature-name>.md` with frontmatter:
   ```yaml
   ---
   stage: spec
   created: YYYY-MM-DD
   feature: <feature-name>
   source-sketch: docs/sketches/<file>.md
   status: draft
   ---
   ```
5. Update sketch frontmatter: add `next-spec: docs/specs/<feature-name>.md`
6. Handle up to 3 `[NEEDS CLARIFICATION]` markers via **AskUserQuestion** (one at a time)
7. Validate: no implementation details, all acceptance scenarios in Given/When/Then format

**Gate**: "Spec complete at `docs/specs/<feature-name>.md`. Proceed to implementation plan? (Y / review / stop)"

---

### Stage 3: Plan (`medium-plan` + optional `deepen-plan`)

**Goal**: Produce a structured implementation plan with parallelization strategy.

Follow the `medium-plan` skill workflow:
1. Run these three agents in parallel:
   - Task repo-research-analyst(feature from spec)
   - Task best-practices-researcher(feature from spec)
   - Task framework-docs-researcher(feature from spec)
2. Run: Task spec-flow-analyzer(spec content, research findings)
3. Build the plan following the spec's requirements and research findings
4. **Include an Execution Strategy section** with:
   - Mermaid `graph LR` dependency diagram (green fill = can start immediately)
   - Phase table: Phase | Name | Depends On | Can Parallelize With | Effort
   - Inline task tags: `[PARALLEL:group-id]` or `[SERIAL:after-group-id]`
5. Write plan to `docs/plans/<feature-name>.md` with frontmatter:
   ```yaml
   ---
   stage: plan
   created: YYYY-MM-DD
   feature: <feature-name>
   source-spec: docs/specs/<feature-name>.md
   status: draft
   ---
   ```
6. Update spec frontmatter: add `next-plan: docs/plans/<feature-name>.md`

Then ask: "Run `deepen-plan` for maximum research depth? (Y / skip)"
- If Y: follow the `deepen-plan` workflow on `docs/plans/<feature-name>.md` — launch 12 parallel research agents across architecture, performance, security, testing, integration dimensions; integrate findings

**Gate**: "Plan complete at `docs/plans/<feature-name>.md`. Proceed to ADR generation? (Y / review / stop)"

---

### Stage 4: ADR (`adr`)

**Goal**: Crystallize the key architectural decisions into permanent records.

Follow the `adr` skill workflow on `docs/plans/<feature-name>.md`:
1. Scan plan for architectural decision candidates
2. Present candidate list via **AskUserQuestion** — user selects which to record
3. For each selected decision: determine next NNNN, write `docs/adr/NNNN-<title>.md`, update `docs/adr/README.md`
4. Update plan frontmatter: add `adr-refs:` list

**Gate**: "ADR(s) written. Create GitHub issues from the plan? (Y / skip / done)"

---

### Stage 5: Issues (`batch-issues`, optional)

**Goal**: Decompose the plan into actionable GitHub issues.

Follow the `batch-issues` skill workflow on `docs/plans/<feature-name>.md`.

---

## Pipeline Summary (displayed at end)

```
## Pipeline Complete

| Stage  | Artifact         | Path                          |
|--------|------------------|-------------------------------|
| Sketch | Brainstorm/design | docs/sketches/YYYY-MM-DD-...  |
| Spec   | Feature spec      | docs/specs/<feature-name>.md  |
| Plan   | Impl plan         | docs/plans/<feature-name>.md  |
| ADR    | Decision record(s)| docs/adr/NNNN-*.md            |
```

## Key Principles

- **Gate at every stage** — never auto-advance without user confirmation
- **Resume, don't restart** — detect existing artifacts and offer to continue from the right point
- **Pipeline stages are inline** — run each stage's workflow directly in this conversation (not as Task subagents), preserving context across stage transitions
- **Stop is always valid** — the user can stop at any gate; all artifacts written so far are valid standalone documents
