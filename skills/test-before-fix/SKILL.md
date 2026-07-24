---
name: test-before-fix
description: |
  Hard gate for bugs and regressions: reproduce with a failing test (or minimal repro) before fixing.
  Use when: bug, 修, 坏了, 回归, failing test, 报错, doesn't work.
  不要用于: 纯文档改动、环境凭证问题且无法单测、用户明确只要应急热修并接受无测试风险.
---

# Test Before Fix

## Overview

A fix without a failing repro is a guess. Guesses regress.

**Core principle:** RED first — see the failure, then make it green.

<HARD-GATE>
Do NOT land a bugfix until you have either:
A) a failing automated test that fails for the right reason, or
B) a minimal documented repro steps + observed failure output when automation is truly impractical
Then implement the fix and show green / resolved evidence.
</HARD-GATE>

## Checklist

1. **Reproduce** — capture actual error / wrong behavior
2. **Narrow** — smallest input that fails
3. **RED** — add/adjust test (preferred) or scripted repro
4. **Confirm RED** — run and paste/summarize failure
5. **Fix** — root cause, not symptom-only when avoidable
6. **GREEN** — same command passes
7. **Regress check** — nearby tests or quick smoke
8. Handoff to `verify-before-done` before claiming fixed

## Output shape

```markdown
## Fix Gate

**Symptom:** ...
**Repro:** ...
**Root cause hypothesis:** ...

### RED
- Command: `...`
- Result: failing as expected (summary)

### Fix
- Change: ...

### GREEN
- Command: `...`
- Result: pass / evidence
```

## When tests are hard

Allowed fallbacks (declare which):

- golden file / snapshot
- scripted CLI repro
- HTTP contract check
- browser assertion

Not allowed as sole evidence: "I read the code and it looks fine."

## Anti-patterns

- Fix first, test later (and forgetting later)
- Delete / skip the failing test to go green
- Mock until the bug disappears from the test but not from reality
