---
name: plan-before-build
description: |
  Hard gate after design approval (or explicit skip): write a bite-sized implementation plan
  with tasks, files, and test strategy before coding.
  Use when: 开始写, 按设计实现, implementation plan, 拆任务.
  不要用于: 还在聊需求未设计、只改文案的琐碎任务、用户明确只要直接改且任务 < ~15 分钟可验证.
---

# Plan Before Build

## Overview

Assume the implementer has **weak taste and no project memory**. Plans must be executable without re-deriving the design.

**Core principle:** Tasks small enough to verify; YAGNI; tests named up front.

<HARD-GATE>
Do NOT start multi-file implementation until a plan exists with:
- ordered tasks
- files to touch per task
- how to verify each task (command or observable check)
Then get a go-ahead unless user already said "按这个直接做".
</HARD-GATE>

## Checklist

1. Restate design goal in one paragraph
2. Map files / modules
3. Slice tasks (prefer vertical slices that leave the tree working)
4. Attach verification to each task
5. Note risks / rollback
6. Save plan when useful: `docs/codegate/plans/YYYY-MM-DD-<feature>.md`
7. On go: implement task-by-task; for bugs switch to `test-before-fix`; finish with `verify-before-done`

## Plan template

```markdown
## Implementation Plan: <feature>

**Goal:** ...
**Design ref:** ...

### File map
| File | Responsibility |
|---|---|
| ... | ... |

### Tasks
#### Task 1: <title>
- Change: ...
- Test / verify: `<command>` or manual check ...
- Done when: ...

#### Task 2: ...

### Risks
- ...
```

## Task sizing

- Prefer tasks finishable in one focused session segment
- Include test work inside the task, not as a final "phase 99"
- No "do everything" tasks

## Failure modes

| Failure | Behavior |
|---|---|
| Design missing | return to `design-before-code` |
| Plan is a novel | cut scope; link out instead of pasting books |
| User says just code | write a 3-bullet micro-plan in chat, then proceed |

## Anti-patterns

- Planning only happy path
- Tasks without verification
- Refactoring the world in Task 1
