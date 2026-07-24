---
name: using-codegate
description: |
  Use when starting coding work: features, refactors, bugfixes, PRs, "做完了", "帮我改一下".
  Establishes CodeGate hard gates for design, planning, tests, and verification before claims.
  触发词: 写功能, 修 bug, 重构, 实现, 提交, PR, 做完了, 帮我改代码.
  不要用于: 链上代币研究/加密行情(那是 TradeGate)、纯闲聊、已明确只要解释概念不要改代码.
---

<SUBAGENT-STOP>
If dispatched as a subagent for a specific CodeGate task, skip re-loading this skill and execute the assigned checklist.
</SUBAGENT-STOP>

<EXTREMELY-IMPORTANT>
If there is even a 1% chance the user wants code changed, a bug fixed, or work declared done,
apply CodeGate routing before free-form implementation.
</EXTREMELY-IMPORTANT>

# Using CodeGate

## The Rule

**No silent coding.** Pick a gate, announce it, follow it.

You may still answer conceptual questions without gates.  
You must NOT jump into files/edits for build work while skipping design/plan/test/verify when those gates apply.

## Skill Priority

| User intent | Load next |
|---|---|
| 新功能 / 新行为 / 产品怎么做 | `design-before-code` |
| 已有设计或明确需求，准备动手 | `plan-before-build` |
| Bug / 回归 / 测试红了 | `test-before-fix` |
| 声称完成 / 准备 commit / 开 PR / 说修好了 | `verify-before-done` |
| 纯解释、不改代码 | no CodeGate workflow required |

When multiple apply: **design → plan → (test-before-fix if bug) → implement → verify-before-done**.

## Red Flags (STOP)

| Thought | Reality |
|---|---|
| "太简单不用设计" | 简单需求最容易假设错误 |
| "先改再说" | 先锁目标与验收 |
| "我记得测试会过" | 没跑就等于没过 |
| "差不多做完了" | 没有新鲜证据不能说完成 |
| "用户很急" | 急也不能用谎言换速度 |

## Runtime

### Codex
- Skills under this plugin `skills/` or `~/.agents/skills` / `~/.codex/skills`
- Prefer Skill tool by name

### OpenCode
- Plugin injects this bootstrap once
- Use native `skill` tool for the next gate

## Not TradeGate

CodeGate = **software engineering discipline**.  
TradeGate = **on-chain research gates** (separate repo, personal). Do not mix routes.

## Minimal Promise

CodeGate does not make you write more code. It forces **visible checkpoints** before expensive mistakes.
