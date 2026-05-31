#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

VERSION="${MAHJONG_VERSION:-$(tr -d '[:space:]' < VERSION)}"
ARTIFACT_PATH="${1:-.build/dist/mahjong-${VERSION}-macos.dmg}"
PROFILE="${NOTARYTOOL_KEYCHAIN_PROFILE:-}"

if [[ ! -e "$ARTIFACT_PATH" ]]; then
  echo "Artifact not found: $ARTIFACT_PATH" >&2
  exit 1
fi

if [[ -n "$PROFILE" ]]; then
  xcrun notarytool submit "$ARTIFACT_PATH" --keychain-profile "$PROFILE" --wait
elif [[ -n "${APPLE_ID:-}" && -n "${APPLE_TEAM_ID:-}" && -n "${APPLE_APP_SPECIFIC_PASSWORD:-}" ]]; then
  xcrun notarytool submit "$ARTIFACT_PATH" \
    --apple-id "$APPLE_ID" \
    --team-id "$APPLE_TEAM_ID" \
    --password "$APPLE_APP_SPECIFIC_PASSWORD" \
    --wait
else
  echo "Notarization credentials are missing." >&2
  echo "Set NOTARYTOOL_KEYCHAIN_PROFILE or APPLE_ID, APPLE_TEAM_ID, and APPLE_APP_SPECIFIC_PASSWORD." >&2
  exit 1
fi

case "$ARTIFACT_PATH" in
  *.app|*.dmg)
    xcrun stapler staple "$ARTIFACT_PATH"
    ;;
  *)
    echo "Skipping stapler for non-stapleable artifact: $ARTIFACT_PATH" >&2
    ;;
esac

spctl --assess --type open --verbose "$ARTIFACT_PATH" || true
echo "$ARTIFACT_PATH"
