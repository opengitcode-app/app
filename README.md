# OpenGitCode

**Your own AI coding agent, with a VM and VS Code, in one click.**

Sign in with GitHub, create a workspace, and get your own private repo and a
Codespace with OpenCode installed. Chat with your agent from a browser, VS Code,
or a mobile app.

[Try it](https://opengitcode-app.github.io/app/) ·
[Dashboard repo](https://github.com/opengitcode-app/opengitcode) ·
[Report an issue](https://github.com/opengitcode-app/opengitcode/issues)

---

## Elevator pitch

OpenGitCode is a one-click provisioning layer for AI coding agents. It turns your
GitHub account into a disposable Linux VM with OpenCode already installed — a
private repo, a browser terminal, and VS Code — reachable from your laptop or
your phone. No new account, no credit card, no local setup.

## Problem

- **Local agents run on your laptop.** Fan noise, battery drain, lost state when
  you close the lid, and a different setup on every machine.
- **Hosted sandboxes want a new account and a credit card**, and they lock you
  into their agent.
- **Raw Codespaces give you a VM and nothing else.** You still install the agent,
  wire up auth, and manage start/stop by hand.

## Solution

- **One click → a working agent.** A private repo and a Codespace with OpenCode,
  Git, and VS Code ready on first boot.
- **One dashboard for the lifecycle.** Start, stop, delete, open — from any
  device.
- **Reachable anywhere.** Browser, desktop VS Code, or an OpenCode v2 mobile app.
- **No markup.** Compute is your GitHub Codespaces allowance; models are your
  OpenCode account.

## What you get

- **Your own agent chat.** OpenCode runs inside your workspace, with shell, git,
  and your tools.
- **A VM and VS Code.** A full Linux environment and browser VS Code. No local
  setup, no Docker, no devcontainer debugging.
- **Accessible anywhere.** Browser, desktop VS Code, or an OpenCode v2 mobile app.
- **No repo picking.** Each workspace comes with your own private repo.
- **Your accounts.** Compute from your GitHub, models from your OpenCode setup.

## Quick start

1. **Sign in with GitHub.** OAuth with `repo` and `codespace` scopes. The token
   stays server-side, never in your browser.
2. **Create your own workspace.** You get your own private repo and a Codespace
   with OpenCode, Git, and VS Code ready on first boot.
3. **Open it anywhere.** Chat in the browser, open VS Code, or connect a mobile
   app.

## Open it anywhere

| Surface | How |
|---|---|
| Browser | Open the workspace URL and sign in with your workspace password |
| VS Code | Open the Codespace in browser VS Code or desktop VS Code |
| iOS | [OpenCody](https://apps.apple.com/us/app/opencody-an-opencode-client/id6760118911), an OpenCode mobile app for iPhone and iPad |
| Android / iOS | [OpenCode Mobile](https://github.com/beppe2880/opencode-mobile), a community mobile app for Android and iOS |

The OpenCode server listens on port `4096` and is protected by the password you
set as a Codespaces secret. Mobile apps are independent community projects, not
affiliated with OpenGitCode or OpenCode.

## Limits

Two quotas apply, and they are independent. Running out of one does not consume
the other.

### GitHub Codespaces

| Resource | Free allowance | At the limit |
|---|---|---|
| Compute | 120 core-hours/month on a personal free plan (more on paid plans) | Workspaces stop until the month resets or you add minutes |
| Storage | 15 GB-month | New workspaces may fail to start |
| Retention | 30 days after stop by default | GitHub deletes the stopped workspace |

Compute and storage come from your GitHub account. OpenGitCode never asks for a
credit card and never resells compute.

### OpenCode

| Resource | Free allowance | At the limit |
|---|---|---|
| Agent | Open source, installed in your workspace | — |
| Models | Rotating free models via OpenCode Zen, pay-as-you-go, or your own provider keys | Model requests fail; the workspace and your files stay |
| Subscription | OpenCode Go is optional; see [opencode.ai](https://opencode.ai) for current pricing | Falls back to free or BYOK models |

Model access is yours. Free rotating models are available in the OpenCode CLI,
which is what runs in your workspace. Availability and limits are set by
OpenCode. You can also add your own provider key as a Codespace secret.

## Security

- GitHub OAuth runs server-side. Tokens are encrypted in Supabase Vault and
  revoked when you disconnect.
- Row-level security means you can only see your own workspaces.
- We store workspace metadata and connection state, not your code.
- Model keys are optional and live in your Codespace secrets.

## FAQ

**Do I need to pick a repo?**
No. Each workspace comes with your own private repo.

**Do I need a paid GitHub plan?**
No. A free personal account includes Codespaces minutes. If you run out, GitHub
lets you add more; the app never asks for a credit card.

**Is it free? What is the catch?**
The app is free. Compute comes from your GitHub Codespaces allowance and model
usage comes from your OpenCode account. Two quotas, two providers, no markup.

**Which agent does it run?**
OpenCode today. Claude Code and Codex CLI profiles are next; the workspace spec
is agent-agnostic.

**Where does my code live?**
In your private repo, created for your workspace.

**What happens when I stop a workspace?**
It stops billing. Files persist until GitHub's retention window.

**Can I use my own model key?**
Yes. Add it as a Codespace secret; it never touches our database.

## Development

| Path | Purpose |
|---|---|
| `.devcontainer/devcontainer.json` | Ports, install, startup |
| `.devcontainer/start-opencode.sh` | Starts `opencode serve` and publishes port `4096` |

Before the first start, add a Codespaces secret named `OPENCODE_PASSWORD`.
`OPENCODE_SERVER_PASSWORD` is accepted as a fallback. Adding the secret after
creation requires a stop and start.

The built dashboard site lives on the `gh-pages` branch and is not part of this
template. The dashboard source is in
[opengitcode-app/opengitcode](https://github.com/opengitcode-app/opengitcode).

## Credits

Not affiliated with GitHub or OpenCode. Mobile apps listed above are independent
community projects.
