#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

APP_PATH="${1:-.build/mahjong.app}"

if [[ ! -d "$APP_PATH" ]]; then
  echo "App bundle not found: $APP_PATH" >&2
  exit 1
fi

SIGN_IDENTITY="${APPLE_DEVELOPER_ID_APPLICATION:-}"

if [[ -z "$SIGN_IDENTITY" ]]; then
  echo "APPLE_DEVELOPER_ID_APPLICATION is not set; applying ad-hoc signature." >&2
  codesign --force --deep --sign - "$APP_PATH"
else
  codesign --force --deep --options runtime --timestamp --sign "$SIGN_IDENTITY" "$APP_PATH"
fi

codesign --verify --deep --strict --verbose=2 "$APP_PATH"

echo "$APP_PATH"
