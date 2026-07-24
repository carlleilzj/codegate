<div align="center">

<sub>📄 <a href="docs/中文说明.md"><b>中文说明</b></a> · <a href="说明.md">入口</a></sub>

# CodeGate

> *「写码前先过闸——没有设计、计划、失败复现和新鲜证据，不许说做完了。」*

[![Agent Skills](https://img.shields.io/badge/Agent%20Skills-CodeGate-2563EB)](skills/using-codegate/SKILL.md)
[![Codex](https://img.shields.io/badge/Codex-plugin-black)](.codex-plugin/plugin.json)
[![OpenCode](https://img.shields.io/badge/OpenCode-plugin-7C3AED)](.opencode/INSTALL.md)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**面向编码 Agent 的硬闸门套件：设计 → 计划 →（修 bug 先红）→ 验证后才能宣称完成。**

</div>

---

## 它是什么 / 不是什么

| CodeGate | 不是 |
|---|---|
| **代码工程纪律** skill 套件 | 加密货币 / 链上研究工具（那是独立的 TradeGate，自用） |
| 精简硬闸门（5 个 skill） | Superpowers 的零差镜像 |
| Codex + OpenCode 双通道 | 「支持一切」的万能框架 |

手艺参考 [obra/superpowers](https://github.com/obra/superpowers) 的闸门与反合理化，**正文原创、范围更窄、中文触发优先**。

## Skills

| Skill | 闸门 |
|---|---|
| [`using-codegate`](skills/using-codegate/SKILL.md) | 入口路由 |
| [`design-before-code`](skills/design-before-code/SKILL.md) | 设计批准前不写生产代码 |
| [`plan-before-build`](skills/plan-before-build/SKILL.md) | 有可验证任务清单再开干 |
| [`test-before-fix`](skills/test-before-fix/SKILL.md) | 先 RED 再修 bug |
| [`verify-before-done`](skills/verify-before-done/SKILL.md) | 没新鲜证据不许说做完 |

## 快速开始

```bash
bash scripts/install-local.sh
```

安装到 `~/.agents/skills` + `~/.codex/skills`，并写入 OpenCode `plugin`。然后**重启会话**。

### 触发示例

```text
帮我加一个导出 CSV 的功能，先过设计闸
这个登录 bug 先写失败测试再修
说做完了之前跑一遍 verify-before-done
```

## Codex + OpenCode

| Runtime | 方式 |
|---|---|
| Codex | `install-local.sh` symlink / `.codex-plugin` |
| OpenCode | `package.json` → `.opencode/plugins/codegate.js` 注入 bootstrap |

## 和 TradeGate / Superpowers

| 项目 | 用途 |
|---|---|
| **CodeGate**（本仓库） | 写代码的纪律 |
| TradeGate（自用） | 链上研究过闸，不混进本仓库 |
| Superpowers | 完整上游方法论；需要全套 SDD 等请装官方源 |

## 验证

```bash
bash scripts/check-structure.sh
```

## 文档

- [中文说明](docs/中文说明.md)
- [OpenCode 安装](.opencode/INSTALL.md)

## License

[MIT](LICENSE)
