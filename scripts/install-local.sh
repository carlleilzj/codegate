#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS=(using-codegate design-before-code plan-before-build test-before-fix verify-before-done)
AGENTS_DIR="${HOME}/.agents/skills"
CODEX_DIR="${CODEX_HOME:-$HOME/.codex}/skills"
OPENCODE_CFG="${HOME}/.config/opencode/opencode.jsonc"
MODE="${1:-link}"

mkdir -p "$AGENTS_DIR" "$CODEX_DIR"
echo "== remove old CodeGate installs =="
for s in "${SKILLS[@]}"; do
  for dest in "$AGENTS_DIR/$s" "$CODEX_DIR/$s"; do
    [[ -e "$dest" || -L "$dest" ]] && rm -rf "$dest" && echo "  removed $dest" || true
  done
done
rm -rf "$AGENTS_DIR/codegate" "$CODEX_DIR/codegate" 2>/dev/null || true

echo "== install ($MODE) =="
for s in "${SKILLS[@]}"; do
  src="$ROOT/skills/$s"
  if [[ "$MODE" == "copy" ]]; then
    cp -R "$src" "$AGENTS_DIR/$s"
    cp -R "$src" "$CODEX_DIR/$s"
  else
    ln -sfn "$src" "$AGENTS_DIR/$s"
    ln -sfn "$src" "$CODEX_DIR/$s"
  fi
  echo "  $s"
done

echo "== OpenCode plugin =="
mkdir -p "$(dirname "$OPENCODE_CFG")"
python3 - "$OPENCODE_CFG" "$ROOT" <<'PY'
import json, re, sys
from pathlib import Path
cfg_path, root = Path(sys.argv[1]), sys.argv[2]
text = cfg_path.read_text() if cfg_path.exists() else "{}"
clean = re.sub(r"/\*.*?\*/", "", text, flags=re.S)
clean = re.sub(r"(^|[^:])//.*?$", r"\1", clean, flags=re.M)
try:
    data = json.loads(clean) if clean.strip() else {}
except json.JSONDecodeError:
    data = {}
plugins = data.get("plugin") or []
if isinstance(plugins, str):
    plugins = [plugins]
# keep tradegate if present; ensure codegate path once
plugins = [p for p in plugins if p and Path(str(p)).name != 'codegate' and 'codegate' not in str(p)]
plugins.append(root)
data["plugin"] = plugins
cfg_path.write_text(json.dumps(data, indent=2, ensure_ascii=False) + "\n")
print("  plugin +=", root)
PY

echo "== verify =="
for s in "${SKILLS[@]}"; do
  test -e "$AGENTS_DIR/$s/SKILL.md"
  test -e "$CODEX_DIR/$s/SKILL.md"
  echo "  OK $s"
done
node --input-type=module -e "import {CodeGatePlugin} from 'file://$ROOT/.opencode/plugins/codegate.js'; if (typeof CodeGatePlugin!=='function') process.exit(2); console.log('  OK plugin')"
echo "STATUS: CodeGate local install complete — restart Codex/OpenCode"
