# Team Manager Configuration

Copy this file to `references/config.md` and fill in your team's details.

## GitHub Project

```
org: YOUR_ORG
repo: YOUR_REPO
project-number: 9
project-id: PVT_xxxxxxxxxxxxxxxxxxxx
```

## GitHub Project Field IDs

Get these with:
```bash
gh project field-list <project-number> --owner <org> --format json
```

```
status-field-id: PVTSSF_xxxxxxxxxxxxxxxxxxxx
area-field-id: PVTSSF_xxxxxxxxxxxxxxxxxxxx
iteration-field-id: PVTIF_xxxxxxxxxxxxxxxxxxxx
```

## Status Option IDs

Get these with the field-list command above:
```
todo-option-id: xxxxxxxx
in-progress-option-id: xxxxxxxx
done-option-id: xxxxxxxx
```

## Team Members

```
members:
  - username: github_username_1
    display: "Name 1"
    areas: [Area1, Area2]
  - username: github_username_2
    display: "Name 2"
    areas: [Area3]
```

## Areas / Labels

Define the work areas your team uses:
```
areas:
  - name: Backend
    label: backend
  - name: Frontend
    label: frontend
  - name: Infrastructure
    label: infra
```

## Iterations / Sprints

```
iterations:
  - name: "Iteration 1"
    start: YYYY-MM-DD
    end: YYYY-MM-DD
```

## GitHub Discussions (for post-discussion skill)

Get repository ID with:
```bash
gh api graphql -f query='{ repository(owner: "YOUR_ORG", name: "YOUR_REPO") { id } }'
```

```
repository-id: R_xxxxxxxxxxxxxxxxxxxx
discussion-categories:
  - name: General
    id: DIC_xxxxxxxxxxxxxxxxxxxx
  - name: Design
    id: DIC_xxxxxxxxxxxxxxxxxxxx
```

## Linear (optional)

If using linear-manage skill, fill in your Linear workspace details:
```
linear:
  team-id: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
  project-id: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  # optional
```
