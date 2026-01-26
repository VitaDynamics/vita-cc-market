---
name: deepen-plan
description: Enhance existing plans with parallel research agents for maximum depth and grounding
allowed-tools:
  - Task
  - Read
  - Write
  - Edit
  - Bash
  - AskUserQuestion
preconditions:
  - Existing plan file or issue to deepen
---

# Deepen Plan Skill

**Purpose**: Enhance existing plans with parallel research agents for maximum depth and grounding.

## Plan to Deepen

Deepen target: ${ARGUMENTS}

## Deepening Methodology

### Phase 1: Plan Analysis

1. **Read and Understand Plan**
   - Read the entire plan document
   - Identify key sections and requirements
   - Note areas that need additional depth or clarification

2. **Scope Definition**
   - Determine which sections benefit most from deepening
   - Identify knowledge gaps or uncertainties
   - Prioritize based on impact and complexity

### Phase 2: Parallel Research Agents

Launch specialized research agents in parallel based on plan needs:

**Architecture & Design Agents:**
1. **System Architecture Researcher** - Overall system design and integration
2. **Domain Model Researcher** - Business logic and data relationships
3. **API Design Researcher** - Endpoint specifications and contracts

**Implementation & Quality Agents:**
4. **Best Practices Researcher** - Industry standards and conventions
5. **Performance Researcher** - Optimization strategies and patterns
6. **Security Researcher** - Security considerations and mitigations
7. **Testing Strategy Researcher** - Comprehensive testing approaches

**Language & Framework Agents:**
8. **Language-Specific Researcher** - Language idioms and patterns
9. **Framework Researcher** - Framework capabilities and constraints

**Integration & Operations Agents:**
10. **Integration Researcher** - External dependencies and APIs
11. **Database Researcher** - Data modeling and query patterns
12. **UI/UX Researcher** - User interface patterns and best practices

### Phase 3: Knowledge Integration

1. **Collect Research Findings**
   - Gather insights from all research agents
   - Identify patterns and common themes
   - Evaluate conflicting recommendations

2. **Update Plan Sections**
   - Enhance existing sections with new insights
   - Add new sections for uncovered aspects
   - Include references and citations

3. **Create Deepened Plan**
   - Integrate research findings into coherent plan
   - Highlight key decisions and trade-offs
   - Provide implementation guidance

### Phase 4: Validation and Refinement

1. **Review Deepened Plan**
   - Check for consistency and completeness
   - Validate technical feasibility
   - Assess alignment with project goals

2. **Present Enhancements**
   - Summarize key additions and improvements
   - Highlight critical insights and recommendations
   - Explain rationale for changes

3. **Next Steps**
   - Option to further refine specific sections
   - Proceed to implementation planning
   - Generate documentation from deepened plan

## Output Features

**Enhanced Plan Sections:**
- Expanded technical specifications
- Detailed implementation strategies
- Comprehensive testing approaches
- Performance and security considerations

**Supporting Materials:**
- Reference links and documentation
- Code examples and patterns
- Architecture diagrams and flowcharts
- Risk assessment and mitigation strategies

## Key Benefits

1. **Depth**: Uncover hidden complexities and edge cases
2. **Breadth**: Consider multiple perspectives and approaches
3. **Validation**: Ground decisions in research and best practices
4. **Actionability**: Provide concrete implementation guidance

## Use Cases

**Best for:**
- Complex feature implementations
- Architectural changes or migrations
- Performance-critical optimizations
- Security-sensitive functionality
- Integration with external systems