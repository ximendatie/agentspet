#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

APP_PATH="$(script/build_app.sh)"
DIST_DIR="$PWD/.build/dist"
VERSION="${MAHJONG_VERSION:-$(tr -d '[:space:]' < VERSION)}"
ZIP_PATH="$DIST_DIR/mahjong-${VERSION}-macos.zip"

mkdir -p "$DIST_DIR"
rm -f "$ZIP_PATH"
rm -f "$DIST_DIR/mahjong.zip"
ditto -c -k --sequesterRsrc --keepParent "$APP_PATH" "$ZIP_PATH"

echo "$ZIP_PATH"
