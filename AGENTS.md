# praxl-oss: agent rules

Shared instructions for Claude Code, Cursor and Codex.

<!-- axiem-ai-standard:start (managed; edit the template, not this block) -->
## AI platform standard

Applies to Claude Code, Cursor and Codex, locally and in cloud agents.

### Connections and secrets: Composio only

- The **only** local credential is `COMPOSIO_API_KEY`, in the shell env or a gitignored `.env.local`
  (see `.env.example`). No other API key, token or password goes in `.env*`, code or chat.
- Platform connections (GitHub, Linear, Slack, Google, QBO, ...) go through Composio's native toolkits.
- Anything Composio has no native toolkit for is stored in **Doppler** and read at runtime through
  Composio's Doppler connection (Praxl skill `doppler`). Never print secret values.
- Deployed apps (Vercel, Render, ...) get secrets from Doppler's platform sync, never from committed files.

### Skills: Praxl only

- Skills live in Praxl (self-hosted, `https://axiem-praxl.onrender.com`). Edit them there; changes
  sync to `~/.claude/skills`, `~/.cursor/skills` and `~/.agents/skills` (Codex).
- Do **not** add `SKILL.md` files to this repo. If a skill needs changing, change it in Praxl.
- Missing a skill locally: `praxl sync --platforms claude-code,cursor,codex`.

### Cloud agents

`scripts/agent-setup.sh` installs Praxl skills in a fresh cloud machine. Each cloud environment needs
two secrets: `PRAXL_TOKEN` and `COMPOSIO_API_KEY`.

| Platform | Setup hook | Where secrets go |
|---|---|---|
| Claude Code (web) | `.claude/settings.json` SessionStart hook | Environment settings at claude.ai/code |
| Cursor background agents | `.cursor/environment.json` `install` | Cursor Settings → Background Agents → Secrets |
| Codex cloud | Environment setup script: `bash scripts/agent-setup.sh` | Codex environment secrets |
<!-- axiem-ai-standard:end -->
