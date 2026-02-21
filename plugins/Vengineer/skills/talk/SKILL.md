---
name: talk(product-brainstorm)
description: "Brainstorm product ideas through visual sketch notes. Use for product discussions and rapid exploration before formal planning. Output feeds into write-to-prd skill."
---

# Talk: Product Brainstorming

## Overview

Quickly explore product ideas through conversational brainstorming and visual sketch notes. Think of this as "talking through an idea on a whiteboard" - rough, visual, and collaborative.

Start by understanding the user problem, then sketch out approaches visually. Use ASCII art, simple diagrams, and bullet points. Keep it fast and conversational - this is about rapid exploration, not polished documentation.

## The Process

**Understanding the problem:**
- Quickly scan current project context (files, recent commits)
- Ask ONE question to understand: "What are we exploring?"
- Use multiple choice when possible:
  - New feature/capability
  - Improvement to existing feature
  - User experience problem
  - New product/initiative
  - Just have an idea to discuss
- Keep it conversational - 1-2 follow-up questions maximum
- Focus on: WHO is the user, WHAT they need, WHY it matters

**Sketching approaches:**
- Present 2-3 visual concepts using ASCII wireframes/diagrams
- Each sketch shows a different approach or perspective
- Keep sketches simple: boxes for screens, arrows for flows, labels for key actions
- Explain trade-offs conversationally with your recommendation
- Lead with your recommended option and explain why

**Refining the sketch:**
- Once user picks an approach, add detail to that sketch
- Add:
  - Key screens/views (as ASCII wireframes)
  - Main user flow (as arrow diagram)
  - Critical interactions (as numbered steps)
  - Edge cases (as "What if..." callouts)
- Keep it visual - avoid long text descriptions

## Visual Sketch Patterns

**ASCII Wireframe Pattern:**
```
┌─────────────────────────┐
│ [Header]                │
├─────────────────────────┤
│                         │
│  [Main Content Area]    │
│                         │
│  • Item 1               │
│  • Item 2               │
│                         │
├─────────────────────────┤
│ [Action Button]         │
└─────────────────────────┘
```

**User Flow Pattern:**
```
[Start] → [Screen 1] → [Action] → [Screen 2] → [End]
              ↓
           [Error]
              ↓
           [Retry]
```

**Concept Diagram Pattern:**
```
     ┌──────────┐
     │  User    │
     └────┬─────┘
          │ wants to
          ↓
     ┌──────────┐      ┌──────────┐
     │  Goal    │ ←─── │ Obstacle │
     └──────────┘      └──────────┘
          ↑
          │ solution
     ┌──────────┐
     │ Feature  │
     └──────────┘
```

**Keep sketches:**
- Simple (5-10 elements max)
- Focused on user perspective
- Free of technical implementation details

## After the Brainstorm

**Save the sketch:**
- Write the brainstorm output to `plans/sketches/YYYY-MM-DD-<topic>-brainstorm.md`
- Format:
  ```markdown
  # [Feature Name] - Product Brainstorm

  **Date:** YYYY-MM-DD
  **Problem:** [One sentence user problem]

  ## User Context
  [WHO the user is, WHAT they need, WHY it matters]

  ## Visual Concepts
  [2-3 ASCII sketches of different approaches]

  ## Chosen Approach
  [Detailed sketch of selected approach with flows]

  ## Key Interactions
  [Critical user actions and responses]

  ## Open Questions
  [Things to explore in PRD phase]
  ```

**Next steps:**
- Ask: "Ready to create a formal PRD from this brainstorm?"
- If yes: Guide user to use the **write-to-prd** skill, which will consume this brainstorm file
- If no: Sketch is saved for future reference

**How write-to-prd uses this output:**
The write-to-prd skill will:
1. Check `plans/sketches/` for existing brainstorms
2. Read the chosen approach, user context, and open questions
3. Use the visual concepts as a foundation for deeper technical discussion
4. Convert the exploratory brainstorm into a formal PRD with user stories, implementation decisions, and testing strategy

**DO NOT:**
- Commit to git (brainstorms are exploratory, may change rapidly)
- Create implementation plans
- Set up worktrees or development environment
- Get into technical architecture or data flow

## Example Brainstorm Output

**File:** `plans/sketches/2026-02-21-user-dashboard-brainstorm.md`

```markdown
# User Dashboard - Product Brainstorm

**Date:** 2026-02-21
**Problem:** Users can't see their recent activity at a glance

## User Context
**WHO:** Returning users who want quick status check
**WHAT:** Need to see recent activity and pending actions
**WHY:** Currently have to navigate to multiple pages

## Visual Concepts

### Option 1: Activity Feed Focus
┌─────────────────────────┐
│ Dashboard               │
├─────────────────────────┤
│ Recent Activity         │
│ • Action 1 (2h ago)     │
│ • Action 2 (1d ago)     │
│ • Action 3 (3d ago)     │
├─────────────────────────┤
│ [Quick Stats]           │
└─────────────────────────┘

### Option 2: Stats + Feed Split
┌──────────┬──────────────┐
│ Stats    │ Activity     │
│ ┌──────┐ │ • Recent...  │
│ │ 42   │ │ • ...        │
│ │items │ │              │
│ └──────┘ │              │
│ ┌──────┐ │              │
│ │ 5    │ │              │
│ │urgent│ │              │
│ └──────┘ │              │
└──────────┴──────────────┘

### Option 3: Card-Based Layout
┌─────────┐ ┌─────────┐
│ Card 1  │ │ Card 2  │
│ [Stat]  │ │ [Stat]  │
└─────────┘ └─────────┘
┌─────────────────────┐
│ Recent Activity     │
│ • Item 1            │
│ • Item 2            │
└─────────────────────┘

## Chosen Approach: Option 2 (Stats + Feed Split)
Balances information density with scannability. Users can see key metrics at a glance while also having access to recent activity detail.

Detailed flow:
[Login] → [Dashboard Home] → [View Stats + Activity]
                               ↓
                          [Click Stat] → [Filtered Activity View]

## Key Interactions
1. User opens dashboard → sees stats + recent activity
2. Clicks stat card → filters activity by type
3. Clicks activity item → navigates to detail

## Open Questions
- Should stats be customizable?
- How many activity items to show initially?
- Need for activity filtering/search?
```

## Key Principles

- **Conversational** - This is a dialogue, not a formal document
- **Visual first** - Use ASCII diagrams, wireframes, and flow charts over long text
- **Rapid exploration** - This is whiteboarding, not documentation
- **User perspective** - Focus on WHO/WHAT/WHY, not HOW (technical)
- **One concept at a time** - Sketch one flow or screen at a time
- **Multiple options** - Always show 2-3 visual approaches before settling
- **Embrace imperfection** - Rough sketches are better than polished docs at this stage
- **No technical details** - No architecture, data flow, or implementation discussion
