#!/usr/bin/env bash
set -eu

PORT=4096
PASSWORD="${OPENCODE_PASSWORD:-${OPENCODE_SERVER_PASSWORD:-}}"

export PATH="$HOME/.opencode/bin:$HOME/.local/bin:$PATH"
export XDG_DATA_HOME=/workspaces/.opencode-persistent

if [ -z "$PASSWORD" ]; then
  echo "ERROR: set OPENCODE_PASSWORD (or OPENCODE_SERVER_PASSWORD) as a Codespaces secret"
  exit 1
fi

export OPENCODE_PASSWORD="$PASSWORD"
export OPENCODE_SERVER_PASSWORD="$PASSWORD"

# A tmux session survives stop/start inside the same container and keeps the
# password it was started with, so always replace it.
tmux kill-session -t opencode-server 2>/dev/null || true
pkill -f "opencode serve --hostname 0.0.0.0 --port $PORT" 2>/dev/null || true

for i in $(seq 1 15); do
  ss -ltn "( sport = :$PORT )" | grep -q LISTEN || break
  sleep 1
done

if ss -ltn "( sport = :$PORT )" | grep -q LISTEN; then
  echo "ERROR: port $PORT is still in use"
  exit 1
fi

tmux new-session -d -s opencode-server \
  "opencode serve --hostname 0.0.0.0 --port $PORT >> /tmp/opencode-serve.log 2>&1"

for i in $(seq 1 30); do
  # /api/info answers 200 only when the server accepts the password.
  if curl -fsS -u "opencode:$PASSWORD" \
    "http://127.0.0.1:$PORT/api/info" \
    >/dev/null 2>&1; then
    break
  fi

  if [ "$i" -eq 30 ]; then
    echo "ERROR: OpenCode failed to start; see /tmp/opencode-serve.log"
    exit 1
  fi

  sleep 1
done

if [ -n "${CODESPACE_NAME:-}" ]; then
  timeout 20s gh codespace ports visibility "$PORT:public" -c "$CODESPACE_NAME" >/dev/null 2>&1 \
    || echo "WARN: could not set port $PORT public; set it from the dashboard"
fi

echo "OpenCode ready on port $PORT"
