#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

pkill -x AgentsPet 2>/dev/null || true
sleep 0.3

APP_PATH="$(script/build_app.sh)"
open -n "$APP_PATH"
echo "Opened $APP_PATH"
