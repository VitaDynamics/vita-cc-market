---
name: plan_review
description: Get feedback from specialized reviewers on plans before implementation
allowed-tools:
  - Task
  - Read
  - Write
  - Edit
  - Bash
  - AskUserQuestion
preconditions:
  - Plan file or issue for review
---

# Plan Review Skill

**Purpose**: Get feedback from specialized reviewers on plans before implementation.

## Plan for Review

Review target: ${ARGUMENTS}

## Review Methodology

### Phase 1: Plan Preparation

1. **Read and Analyze Plan**
   - Read the complete plan document
   - Identify core objectives and requirements
   - Note areas that may need reviewer attention

2. **Reviewer Selection**
   - Determine which specialized reviewers are most relevant
   - Consider plan type, complexity, and domain
   - Choose reviewers based on expertise match

### Phase 2: Parallel Reviewer Agents

Launch specialized reviewer agents in parallel:

**Architecture & Design Reviewers:**
1. **System Architecture Reviewer** - Overall system design and boundaries
2. **Domain Model Reviewer** - Business logic and data relationships
3. **API Design Reviewer** - Endpoint specifications and contracts

**Implementation & Quality Reviewers:**
4. **Best Practices Reviewer** - Industry standards and conventions
5. **Performance Reviewer** - Optimization strategies and efficiency
6. **Security Reviewer** - Security considerations and mitigations
7. **Testing Strategy Reviewer** - Comprehensive testing approaches

**Language & Framework Reviewers:**
8. **Language-Specific Reviewer** - Language idioms and patterns
9. **Framework Reviewer** - Framework capabilities and constraints

**Project & Team Reviewers:**
10. **Project Conventions Reviewer** - Team standards and patterns
11. **Maintainability Reviewer** - Code quality and long-term sustainability
12. **Simplicity Reviewer** - KISS principles and minimalism

### Phase 3: Review Synthesis

1. **Collect Reviewer Feedback**
   - Gather insights and recommendations from all reviewers
   - Identify common themes and patterns
   - Note conflicting advice for resolution

2. **Categorize Feedback**
   - **P1 (Critical)**: Must address before proceeding
   - **P2 (Important)**: Should consider for improvement
   - **P3 (Nice-to-have)**: Optional enhancements

3. **Create Review Summary**
   - Compile structured feedback report
   - Highlight key issues and recommendations
   - Provide actionable next steps

### Phase 4: Plan Enhancement

1. **Update Plan Based on Feedback**
   - Incorporate reviewer recommendations
   - Address critical issues and concerns
   - Enhance clarity and completeness

2. **Create Revised Plan**
   - Generate updated version with improvements
   - Document changes and rationale
   - Highlight reviewer contributions

3. **Present Review Outcome**
   - Summarize key feedback and changes
   - Explain how plan was improved
   - Offer options for next steps

## Reviewer Specializations

**DHH Reviewer (Rails/DHH Principles):**
- Convention over configuration
- RESTful design patterns
- Rails best practices and idioms
- Simple, maintainable solutions

**Kieran Reviewer (Performance & Scalability):**
- Query optimization and caching
- Background job patterns
- Performance testing strategies
- Scalability considerations

**Simplicity Reviewer (KISS & Minimalism):**
- Remove unnecessary complexity
- Focus on core functionality
- Avoid over-engineering
- Clear, straightforward solutions

## Review Output

**Structured Feedback Report:**
- Executive summary of key findings
- Categorized feedback by section
- Priority classification (P1/P2/P3)
- Specific recommendations and examples

**Enhanced Plan Features:**
- Improved clarity and completeness
- Addressed architectural concerns
- Enhanced testing and validation strategies
- Better alignment with project standards

## Review Benefits

1. **Quality Assurance**: Catch issues before implementation
2. **Knowledge Sharing**: Leverage specialized expertise
3. **Risk Mitigation**: Identify potential problems early
4. **Team Alignment**: Ensure consistency with project conventions

## Next Steps Options

1. **Implement Revised Plan**: Proceed with enhanced plan
2. **Further Refinement**: Address specific feedback areas
3. **Review Summary Only**: Use feedback without plan update
4. **Start Work**: Begin implementation immediately