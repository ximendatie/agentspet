#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

APP_PATH="$(script/build_app.sh)"
VERSION="${MAHJONG_VERSION:-$(tr -d '[:space:]' < VERSION)}"
DIST_DIR="$PWD/.build/dist"
STAGING_DIR="$PWD/.build/dmg-staging"
DMG_PATH="$DIST_DIR/mahjong-${VERSION}-macos.dmg"

rm -rf "$STAGING_DIR"
mkdir -p "$STAGING_DIR" "$DIST_DIR"

cp -R "$APP_PATH" "$STAGING_DIR/mahjong.app"
ln -s /Applications "$STAGING_DIR/Applications"
rm -f "$DMG_PATH"
rm -f "$DIST_DIR/mahjong.dmg"

hdiutil create \
  -volname "mahjong ${VERSION}" \
  -srcfolder "$STAGING_DIR" \
  -ov \
  -format UDZO \
  "$DMG_PATH" >/dev/null

echo "$DMG_PATH"
