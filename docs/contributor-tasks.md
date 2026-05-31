# Contributor Task Board

This document tracks good first issues and help-wanted tasks for the 0.4.x contributor-growth phase. Convert these entries into GitHub issues as maintainers are ready to triage them.

## Good First Issues

| Title | Labels | Suggested files | Acceptance |
| --- | --- | --- | --- |
| Add README demo GIF or video | `good first issue`, `docs`, `ui` | `README.md`, `README.zh-CN.md`, `docs/assets/*` | README shows a short demo near the top without exposing private local data. |
| Add launch screenshots | `good first issue`, `docs`, `ui` | `docs/assets/*`, `docs/launch.md` | Launch docs include desktop companion, Board, Settings/Diagnostics, and provider list screenshots. |
| Add last refresh time to Diagnostics header | `good first issue`, `ui`, `diagnostics` | `Sources/Stores/AgentTaskStore.swift`, `Sources/Views/SettingsView.swift` | Settings shows one clear "last refreshed" timestamp for diagnostics. |
| Add clearer empty states for task columns | `good first issue`, `ui` | `Sources/Views/TaskColumnView.swift` | Empty running/completed/interrupted/history columns explain what the state means. |
| Document ChatGPT Accessibility behavior | `good first issue`, `docs`, `privacy` | `docs/privacy.md`, `README.md`, `README.zh-CN.md` | Docs explain why Accessibility is optional and that conversation text is not read. |
| Add Provider support matrix to README | `good first issue`, `docs`, `provider` | `README.md`, `README.zh-CN.md` | README table distinguishes task metadata, runtime detection, and required permissions. |
| Add one parser edge-case fixture | `good first issue`, `tests`, `parser` | `Tests/MahjongTests/*Tests.swift` | A provider parser covers a missing/partial field case without crashing. |

## Launch Help Wanted

| Title | Labels | Suggested files | Acceptance |
| --- | --- | --- | --- |
| Prepare `0.1.0-alpha` release notes | `help wanted`, `release`, `docs` | `CHANGELOG.md`, GitHub Release draft | Release notes explain status, install steps, known limitations, and privacy boundary. |
| Convert contributor tasks into GitHub issues | `help wanted`, `docs` | GitHub issues, `docs/contributor-tasks.md` | At least five tasks have clear labels, acceptance criteria, and links back to relevant docs. |
| Test first-run instructions on a clean Mac | `help wanted`, `release`, `docs` | `README.md`, `docs/launch.md` | A tester can download or build mahjong and report whether it runs within five minutes. |

## Help Wanted Provider Tasks

| Provider | Initial scope | Labels | Notes |
| --- | --- | --- | --- |
| Gemini CLI | Process detection plus safe local metadata if available | `help wanted`, `provider`, `privacy` | Start with runtime detection if metadata format is unclear. |
| Aider | Local session or process detection | `help wanted`, `provider`, `parser` | Confirm local paths before parsing. |
| OpenCode | Local session or process detection | `help wanted`, `provider`, `parser` | Keep first PR narrow. |
| Cursor | Desktop runtime detection | `help wanted`, `provider`, `ui` | No project content parsing in the first version. |
| Windsurf | Desktop runtime detection | `help wanted`, `provider`, `ui` | No project content parsing in the first version. |
| Goose | Safe local metadata review | `help wanted`, `provider`, `privacy` | Document paths before implementation. |
| Continue | Safe local metadata review | `help wanted`, `provider`, `privacy` | Document paths before implementation. |

## Issue Template For Provider Work

```markdown
## Goal
Add initial support for <Provider> while keeping mahjong local-first and read-only.

## Initial scope
- [ ] Identify local data paths or runtime signal.
- [ ] Document what data is read.
- [ ] Implement the smallest useful task or runtime provider.
- [ ] Add fixture tests.
- [ ] Update README and privacy docs.

## Out of scope
- Sending messages or controlling <Provider>.
- Uploading local data.
- Displaying full conversation bodies by default.

## Acceptance
- `swift test` passes.
- Missing files or permissions do not crash the app.
- User-facing docs explain the provider behavior.
```
