#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
FAIL=0
pass(){ echo "  [PASS] $1"; }
fail(){ echo "  [FAIL] $1"; FAIL=$((FAIL+1)); }
need(){ [[ -e "$1" ]] && pass "exists $1" || fail "missing $1"; }

for s in using-codegate design-before-code plan-before-build test-before-fix verify-before-done; do
  need "skills/$s/SKILL.md"
done
need ".codex-plugin/plugin.json"
need ".opencode/plugins/codegate.js"
need "package.json"
need "README.md"
need "docs/中文说明.md"
need "scripts/install-local.sh"
need "hooks/session-start"
need "hooks/hooks.json"

grep -q 'design-before-code' skills/using-codegate/SKILL.md && pass 'router has design' || fail 'router missing design'
grep -q 'HARD-GATE' skills/design-before-code/SKILL.md && pass 'design hard gate' || fail 'design hard gate missing'
grep -q 'HARD-GATE' skills/verify-before-done/SKILL.md && pass 'verify hard gate' || fail 'verify hard gate missing'
grep -q 'TradeGate' skills/using-codegate/SKILL.md && pass 'explicit non-crypto boundary' || fail 'missing TradeGate boundary note'
grep -qi '加密' README.md && pass 'README says not crypto' || fail 'README crypto disclaimer weak'
if CLAUDE_PLUGIN_ROOT="$ROOT" bash hooks/session-start | grep -q CodeGate; then
  pass 'session-start injects CodeGate'
else
  fail 'session-start inject failed'
fi

if node --input-type=module -e "import {CodeGatePlugin} from './.opencode/plugins/codegate.js'; if (typeof CodeGatePlugin!=='function') process.exit(2)"; then
  pass 'opencode plugin loads'
else
  fail 'opencode plugin load failed'
fi

# bootstrap inject smoke
node --input-type=module <<'JS'
import { CodeGatePlugin } from './.opencode/plugins/codegate.js';
const plugin = await CodeGatePlugin();
const config = { skills: { paths: [] } };
await plugin.config(config);
if (!config.skills.paths.length) throw new Error('no skills path');
const output = { messages: [{ info: { role: 'user' }, parts: [{ type: 'text', text: 'hi' }] }] };
await plugin['experimental.chat.messages.transform']({}, output);
if (!output.messages[0].parts[0].text.includes('CodeGate')) throw new Error('no bootstrap');
console.log('  [PASS] bootstrap inject');
JS

if [[ "$FAIL" -eq 0 ]]; then echo "STATUS: PASSED"; exit 0; fi
echo "STATUS: FAILED ($FAIL)"; exit 1
