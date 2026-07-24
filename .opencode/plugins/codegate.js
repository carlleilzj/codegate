import path from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
let _bootstrapCache = undefined;

const stripFrontmatter = (content) => {
  const match = content.match(/^---\n[\s\S]*?\n---\n([\s\S]*)$/);
  return match ? match[1] : content;
};

export const CodeGatePlugin = async () => {
  const skillsDir = path.resolve(__dirname, '../../skills');
  const getBootstrap = () => {
    if (_bootstrapCache !== undefined) return _bootstrapCache;
    const p = path.join(skillsDir, 'using-codegate', 'SKILL.md');
    if (!fs.existsSync(p)) {
      _bootstrapCache = null;
      return null;
    }
    const body = stripFrontmatter(fs.readFileSync(p, 'utf8'));
    _bootstrapCache = `<EXTREMELY_IMPORTANT>
You have CodeGate.

**using-codegate is already loaded. Do NOT reload it.**

${body}

**OpenCode tools:** todos→todowrite · skill→skill · shell→bash · edit→apply_patch · search→grep/glob · fetch→webfetch
</EXTREMELY_IMPORTANT>`;
    return _bootstrapCache;
  };

  return {
    config: async (config) => {
      config.skills = config.skills || {};
      config.skills.paths = config.skills.paths || [];
      if (!config.skills.paths.includes(skillsDir)) config.skills.paths.push(skillsDir);
    },
    'experimental.chat.messages.transform': async (_input, output) => {
      const bootstrap = getBootstrap();
      if (!bootstrap || !output.messages?.length) return;
      const firstUser = output.messages.find((m) => m.info.role === 'user');
      if (!firstUser?.parts?.length) return;
      if (firstUser.parts.some((p) => p.type === 'text' && p.text.includes('EXTREMELY_IMPORTANT'))) return;
      const ref = firstUser.parts[0];
      firstUser.parts.unshift({ ...ref, type: 'text', text: bootstrap });
    },
  };
};
