# Release Guide

mahjong release artifacts are generated from the version in `VERSION`.

## Local Dry Run

```bash
swift test
script/build_release_zip.sh
script/build_release_dmg.sh
```

Artifacts are written to `.build/dist/`:

- `mahjong-<version>-macos.zip`
- `mahjong-<version>-macos.dmg`

## Version Metadata

`script/build_app.sh` writes these bundle fields from the shared version source:

- `CFBundleShortVersionString`: `VERSION`
- `CFBundleVersion`: `MAHJONG_BUILD_NUMBER` or the git commit count

Override locally when needed:

```bash
MAHJONG_VERSION=0.5.1 MAHJONG_BUILD_NUMBER=42 script/build_release_zip.sh
```

## Signing

Local development builds are ad-hoc signed. For Developer ID signing, set:

```bash
export APPLE_DEVELOPER_ID_APPLICATION="Developer ID Application: Example, Inc. (TEAMID)"
script/build_app.sh
script/sign_app.sh .build/mahjong.app
```

Verify:

```bash
codesign --verify --deep --strict --verbose=2 .build/mahjong.app
```

## Notarization

Use either a notarytool keychain profile:

```bash
export NOTARYTOOL_KEYCHAIN_PROFILE=mahjong-notary
script/notarize.sh .build/dist/mahjong-0.5.0-macos.dmg
```

Or Apple ID credentials:

```bash
export APPLE_ID="developer@example.com"
export APPLE_TEAM_ID="TEAMID"
export APPLE_APP_SPECIFIC_PASSWORD="app-specific-password"
script/notarize.sh .build/dist/mahjong-0.5.0-macos.dmg
```

`script/notarize.sh` staples `.app` and `.dmg` artifacts after notarization.

## GitHub Release

The release workflow runs on tags that start with `v`, for example:

```bash
git tag v0.5.0
git push origin v0.5.0
```

The workflow runs tests, builds zip and dmg artifacts, uploads workflow
artifacts, and attaches them to the GitHub Release.

The current workflow builds unsigned release artifacts. Developer ID signing and
notarization require Apple credentials to be configured outside the repository.
