---
name: post-discussion
description: Post a plan or design document to GitHub Discussions to request team review. Creates a bilingual post with Chinese summary as main post and full original content as a comment. Configure your team in references/config.md before first use.
---

# Post Discussion

## Overview

Post a plan/design document to GitHub Discussions in two phases:

1. **Main post** — Chinese summarization: design rationale, key points, and questions for the team
2. **Follow-up comment** — Original plan content in full (for reference and deep reading)

## Setup Check

Before proceeding, read `references/config.md` and extract:
- `repository-id` (GitHub repository GraphQL ID)
- `discussion-categories` (list of category names and IDs)

If config is missing or incomplete, direct the user to set it up.

## Inputs

- **Plan file path** (required) — the markdown/text file to post
- **Discussion category** (optional, default: `General`)
- **Custom title** (optional, default: derive from plan content)

## Workflow

### Step 1: Read the Plan

Read the plan file in full. Understand:
- The overall goal or problem this plan addresses
- Key design decisions and reasoning
- Important trade-offs or constraints
- What's in scope and out of scope
- Open questions for team input

### Step 2: Write the Chinese Summary

Write the main discussion body in Chinese:

```
## 📋 方案概述

<2-3 sentences: what this plan proposes and why it's needed>

## 🎯 核心目标

- <goal 1>
- <goal 2>

## 💡 设计思路

<key design decisions and the reasoning — not just what, but why>

## 🔑 关键要点

<most important technical or design points>

## ❓ 请大家讨论

<specific questions for team input>

---

> 📎 完整方案原文见评论区 👇
```

### Step 3: Create the Discussion

Use `repository-id` and `categoryId` from config.md:

```bash
cat > /tmp/discussion_body.md << 'ENDBODY'
<Chinese summary here>
ENDBODY

TITLE="[讨论] <title>"
BODY=$(cat /tmp/discussion_body.md)

RESULT=$(gh api graphql \
  -F repositoryId="<repository-id>" \
  -F categoryId="<category-id>" \
  -F title="$TITLE" \
  -F body="$BODY" \
  -f query='
  mutation CreateDiscussion($repositoryId: ID!, $categoryId: ID!, $title: String!, $body: String!) {
    createDiscussion(input: {
      repositoryId: $repositoryId,
      categoryId: $categoryId,
      title: $title,
      body: $body
    }) {
      discussion { id number url }
    }
  }')

DISCUSSION_ID=$(echo "$RESULT" | python3 -c "import json,sys; print(json.load(sys.stdin)['data']['createDiscussion']['discussion']['id'])")
DISCUSSION_URL=$(echo "$RESULT" | python3 -c "import json,sys; print(json.load(sys.stdin)['data']['createDiscussion']['discussion']['url'])")
```

### Step 4: Post Original Plan as Comment

```bash
cat > /tmp/comment_body.md << 'ENDCOMMENT'
## 📄 原始方案内容

<full plan content here>
ENDCOMMENT

COMMENT_BODY=$(cat /tmp/comment_body.md)

gh api graphql \
  -F discussionId="$DISCUSSION_ID" \
  -F body="$COMMENT_BODY" \
  -f query='
  mutation AddComment($discussionId: ID!, $body: String!) {
    addDiscussionComment(input: {
      discussionId: $discussionId,
      body: $body
    }) {
      comment { id url }
    }
  }'
```

> For large plans (>50KB): split into multiple comments with headings like `## 📄 原始方案内容 (1/2)`.

### Step 5: Report to User

```
✅ Discussion posted!

🔗 <discussion_url>

- Main post: Chinese summary (design thinking + key points + discussion questions)
- Comment: Full original plan content
```

## Title Convention

- `[设计] <topic>` — architecture or design decisions
- `[讨论] <topic>` — open-ended discussion
- `[方案] <topic>` — implementation proposals
- `[RFC] <topic>` — formal request-for-comments

Keep title under 80 characters.

## Important Notes

- **Don't truncate** — the comment must contain the full original plan
- **Use `-F` (not `-f`) for body/title** — handles JSON-encoding safely
- Always write bodies to temp files before reading into shell variables
