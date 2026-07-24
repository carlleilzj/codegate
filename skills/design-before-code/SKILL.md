---
name: design-before-code
description: |
  Hard gate before creative coding work: features, new behavior, non-trivial refactors.
  Explore intent, propose 2-3 approaches, get approval, then write a short design note.
  Use when: 新功能, 加个, 实现, 重构行为, 产品怎么做, design this.
  不要用于: 已批准设计的纯执行、单行 typo、明确的机械重命名、只问概念.
---

# Design Before Code

## Overview

Turn "帮我做 X" into an **approved design** before touching implementation skills.

**Core principle:** Unexamined assumptions are the most expensive bugs.

<HARD-GATE>
Do NOT write production code, scaffold projects, or invoke implementation plans until:
1) You understand goal/constraints/success criteria
2) You proposed 2-3 approaches with a recommendation
3) User approved the design (explicit OK / "就这个" / equivalent)
Exception: user explicitly says "跳过设计直接写" — then record the skip and proceed to plan-before-build.
</HARD-GATE>

## Checklist

1. **Context** — relevant files, existing patterns, recent commits (brief)
2. **Clarify** — ask questions one at a time if blocked; otherwise state assumptions
3. **Approaches** — 2–3 options, trade-offs, recommendation
4. **Design slice** — scope, non-goals, interfaces/files likely touched, risks
5. **Approval** — stop and wait
6. **Write design note** (after approval) — `docs/codegate/designs/YYYY-MM-DD-<topic>.md` if repo allows; else chat-summary is OK
7. **Handoff** — load `plan-before-build`

## Output shape (before approval)

```markdown
## Design Gate

**Goal:** ...
**Success looks like:** ...
**Constraints / non-goals:** ...

### Approaches
1. ... — pros / cons
2. ... — pros / cons
3. ... — pros / cons (optional)

**Recommendation:** ...
**Why:** ...

### Proposed design (recommended)
- Scope: ...
- Main touch points: ...
- Risks: ...

Approve this design? (or pick another approach)
```

## Failure modes

| Failure | Behavior |
|---|---|
| User wants code now, design unclear | still present minimal design; offer skip only if they insist |
| "小改动" | keep design short (5–10 lines), do not skip entirely |
| Scope sprawls | split into sub-designs; do not plan mega-PR |

## Anti-patterns

- Implementing while "just exploring"
- One approach presented as destiny
- Design docs full of TODOs and placeholders after approval

## Disclaimer

This gate improves engineering clarity; it does not replace product ownership.
