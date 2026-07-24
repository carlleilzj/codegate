---
name: verify-before-done
description: |
  Hard gate before claiming complete, fixed, passing, or before commit/PR.
  Requires fresh verification commands and evidence in the same turn as the claim.
  Use when: 做完了, 修好了, 可以提交, open PR, all tests pass, 搞定了.
  不要用于: 中途进度汇报且明确说尚未完成、用户只要看 diff 不要结论.
---

# Verify Before Done

## Overview

Claiming done without fresh evidence is not speed — it is fiction.

**Core principle:** Evidence before claims. Always.

<HARD-GATE>
NO completion / fixed / passing / "可以合并" claims without verification run in this turn.
If you did not run the proving command in this message window, you cannot claim it passed.
</HARD-GATE>

## The Gate Function

Before any success claim:

1. **IDENTIFY** — what command or check proves the claim?
2. **RUN** — full command, fresh
3. **READ** — exit code, failures, relevant logs
4. **MATCH** — does output actually support the claim?
5. **CLAIM** — only then, with evidence attached

Skip any step = invalid claim.

## Checklist

1. List claims you want to make ("feature works", "tests pass", "lint clean")
2. Map each claim → command
3. Run commands
4. Report: command, result, residual risk
5. Only then: commit/PR language if user wants

## Output shape

```markdown
## Done Gate

| Claim | Command | Result |
|---|---|---|
| unit tests | `pnpm test` | PASS / FAIL + summary |
| typecheck | `...` | ... |

**Residual risk:** ...
**Status:** DONE with evidence / NOT DONE — blocked on ...
```

## Common false dones

| Claim | Not enough |
|---|---|
| tests pass | ran a different subset earlier |
| bug fixed | no repro, only code reading |
| ready to merge | didn't run project’s CI-equivalent checks |
| lint clean | IDE underline vibes |

## Anti-patterns

- "should be fine"
- Reusing yesterday’s CI green screenshot
- Marking todos complete before commands finish

## Relationship

- Bugs: prefer `test-before-fix` before this gate
- Features: prefer `design-before-code` + `plan-before-build` earlier in the path
