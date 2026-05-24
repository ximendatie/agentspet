#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
APP_PATH="$(script/build_app.sh)"
open -n "$APP_PATH"
echo "Opened $APP_PATH"
