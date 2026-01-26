---
name: review
description: Perform exhaustive code reviews using multi-agent analysis across 13+ specialized reviewer agents
allowed-tools:
  - Task
  - Read
  - Write
  - Bash
  - Skill
  - AskUserQuestion
preconditions:
  - Code to review identified (PR, branch, or commit)
---

# Review Skill

**Purpose**: Perform exhaustive code reviews using multi-agent analysis across 13+ specialized reviewer agents.

## Review Context

Review target: ${ARGUMENTS}

## Review Methodology

### Phase 1: Setup and Context Gathering

1. **Identify Review Target**
   - Determine if reviewing a PR, branch, or commit
   - Gather basic information about the changes

2. **Setup Work Environment**
   - Check if already on review branch
   - If not, consider using git-worktree for isolated review
   - Skill: git-worktree (if needed)

3. **Initial Scan**
   - Get overview of changed files and lines
   - Identify major areas of change

### Phase 2: Parallel Agent Reviews (13+ Reviewers)

Launch specialized reviewer agents in parallel:

**Architecture Reviewers:**
1. **System Architecture Reviewer** - Overall system design and boundaries
2. **Domain Model Reviewer** - Business logic and data modeling
3. **API Design Reviewer** - Endpoint design and contracts

**Code Quality Reviewers:**
4. **Patterns & Practices Reviewer** - Design patterns and best practices
5. **Performance Reviewer** - Efficiency and scalability considerations
6. **Security Reviewer** - Security vulnerabilities and best practices
7. **Test Coverage Reviewer** - Testing strategy and coverage

**Language & Framework Reviewers:**
8. **Language-Specific Reviewer** - Language idioms and conventions
9. **Framework Reviewer** - Framework-specific patterns and APIs

**Integration & Operations Reviewers:**
10. **Integration Reviewer** - External dependencies and APIs
11. **Database Reviewer** - Data modeling and query optimization
12. **UI/UX Reviewer** - User interface and experience considerations
13. **DevOps & Observability Reviewer** - Deployment, monitoring, logging

### Phase 3: Analysis and Synthesis

1. **Collect Agent Findings**
   - Gather reports from all reviewer agents
   - Identify common themes and patterns
   - Prioritize issues by severity and impact

2. **Create Structured Review**
   - Categorize findings by type and priority
   - Provide specific, actionable feedback
   - Include code examples and suggestions

3. **Generate Review Summary**
   - Overall assessment of code quality
   - Key strengths and areas for improvement
   - Recommendations for next steps

### Phase 4: Report and Follow-up

1. **Create Review Document**
   - Write comprehensive review report
   - Include detailed findings with code references
   - Suggest fixes and improvements

2. **Present Findings**
   - Share review summary with user
   - Highlight critical issues first
   - Offer to help with specific fixes

3. **Next Steps Options**
   - Fix issues identified in review
   - Run additional validation tests
   - Proceed with merge/approval process

## Review Output

- **Structured Review Document**: Detailed analysis with categorized findings
- **Priority Classification**: P1 (Critical), P2 (Important), P3 (Nice-to-have)
- **Actionable Recommendations**: Specific fixes and improvements
- **File Path References**: Exact locations of issues (e.g., `app/services/example.rb:42`)

## Severity Classification

**P1 (Critical)**: Must fix before merging
- Security vulnerabilities
- Breaking API changes without migration
- Data loss risks
- Performance regressions > 50%

**P2 (Important)**: Should fix soon
- Code quality issues affecting maintainability
- Missing error handling
- Incomplete test coverage
- Minor performance issues

**P3 (Nice-to-have)**: Optional improvements
- Code style nitpicks
- Documentation improvements
- Test optimization
- Refactoring opportunities