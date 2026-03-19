---
name: alphaxiv
description: Look up academic papers on AlphaXiv — given an arXiv ID or URL, fetch a structured AI-generated overview (problem, approach, key insights, results) and optionally save annotated notes to docs/research/.
allowed-tools:
  - WebFetch
  - Read
  - Write
  - AskUserQuestion
preconditions:
  - An arXiv paper ID or URL provided as input
---

# AlphaXiv Paper Research Skill

**Purpose**: Retrieve structured paper overviews from AlphaXiv's API and optionally save annotated research notes.

## Input

```text
$ARGUMENTS
```

**If empty**, ask via **AskUserQuestion**: "Please provide an arXiv paper ID or URL (e.g., `2301.07041` or `https://arxiv.org/abs/2301.07041`)."

## Step 1: Extract arXiv ID

Parse the arXiv ID from various input formats:

| Input Format | Example | Extracted ID |
|-------------|---------|-------------|
| Raw ID | `2301.07041` | `2301.07041` |
| arXiv URL | `https://arxiv.org/abs/2301.07041` | `2301.07041` |
| AlphaXiv URL | `https://alphaxiv.org/abs/2301.07041` | `2301.07041` |
| With version | `2301.07041v2` | `2301.07041v2` |

Pattern: `\d{4}\.\d{4,5}(v\d+)?`

## Step 2: Resolve Paper Version

Fetch the paper metadata to get the versionId:

```
GET https://alphaxiv.org/api/papers/{arxivId}
```

Extract the `versionId` from the response (used in the next step).

If the API returns an error, try without the version suffix (e.g., `2301.07041` instead of `2301.07041v2`).

## Step 3: Fetch Structured Overview

Fetch the machine-readable paper overview:

```
GET https://alphaxiv.org/api/papers/{versionId}/overview
```

The response contains a structured summary with sections:
- **Problem**: What problem does this paper address?
- **Approach**: What method or technique was used?
- **Key Insights**: What are the most important findings?
- **Results**: What were the quantitative/qualitative results?
- **Limitations**: What are the acknowledged limitations?

## Step 4: Present Summary

Display the structured overview in a readable format:

```
## 📄 [Paper Title]

**arXiv**: {id} | **Authors**: {authors} | **Published**: {date}

### Problem
{problem statement}

### Approach
{methodology}

### Key Insights
{key findings}

### Results
{results summary}

### Limitations
{limitations}

---
Source: https://alphaxiv.org/abs/{arxivId}
```

## Step 5: Save Research Note (Optional)

Ask via **AskUserQuestion**: "Would you like to save this to your research notes?"

Options:
- Save to docs/research/
- Skip

If saving, create `docs/research/YYYY-MM-DD-{arxiv-id}-{slug}.md`:

```yaml
---
type: paper
arxiv-id: {arxivId}
title: "{title}"
authors: [{author1}, {author2}]
date-read: {today}
published: {paper-date}
tags: []
relevance: medium
---

# {title}

**arXiv**: [{arxivId}](https://arxiv.org/abs/{arxivId}) | **AlphaXiv**: [discussion](https://alphaxiv.org/abs/{arxivId})

## Problem
{problem}

## Approach
{approach}

## Key Insights
{insights}

## Results
{results}

## Limitations
{limitations}

## My Notes

<!-- Add your annotations here -->

## Related Work

<!-- Links to related papers or docs -->
```

After saving, ask:

> "Saved. Would you like to link this paper to an existing artifact?"

Options:
- Link to a spec (`docs/specs/`)
- Link to a plan (`docs/plans/`)
- Link to an ADR (`docs/adr/`)
- Done

If linking, use `Edit` to add a `related-papers:` field to the target artifact's YAML frontmatter.

## Error Handling

- **API unavailable**: Fall back to fetching the arXiv abstract page via WebFetch from `https://arxiv.org/abs/{id}` and present the abstract instead
- **Paper not found on AlphaXiv**: Inform the user, offer to fetch from arXiv directly
- **Invalid ID format**: Show expected format and ask again

## Key Principles

- **Save as reference, not prescription** — paper notes are for understanding, not spec requirements
- **Tag for discoverability** — always suggest 2-3 relevant tags before saving
- **Link to work** — help connect paper insights to ongoing plans/specs
