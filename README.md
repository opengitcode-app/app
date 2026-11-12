# OpenCode Codespaces template

Public template that starts an OpenCode server inside a Codespace.

## Use

1. Generate a repository from this template, or create a codespace directly from it.
2. Before the codespace starts, add a Codespaces secret named `OPENCODE_PASSWORD`.
3. Open port `4096` and sign in as `opencode` with that password.

`OPENCODE_SERVER_PASSWORD` is accepted as a fallback. Adding the secret after creation requires a stop/start.

## Layout

| Path | Purpose |
|---|---|
| `.devcontainer/devcontainer.json` | Ports, install, startup |
| `.devcontainer/start-opencode.sh` | Starts `opencode serve` and publishes port 4096 |

The `gh-pages` branch holds the built dashboard site. It is not part of the template.

## Notes

- No Gmail MCP is configured. Add `.opencode/opencode.json` and your own credentials if you need it.
- The devcontainer does not request write access to other repositories.
