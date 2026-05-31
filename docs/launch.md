# Launch Playbook

This playbook keeps mahjong's public launch focused: show the product quickly,
make the safety boundary obvious, and route interested developers toward a
download, issue, or contribution.

## Audience

Start with people who already feel the problem:

- Developers running multiple local AI agents.
- Codex, Claude, ChatGPT Desktop, Hermes, and terminal-agent power users.
- macOS users who prefer local-first tools.
- Contributors interested in adding provider integrations.

## Launch Assets

Before a wider post, prepare these assets:

| Asset | Purpose | Owner checklist |
| --- | --- | --- |
| 20-40 second demo video or GIF | Shows the floating tile, Board, provider status, and privacy posture quickly. | Record from a clean desktop, avoid private project names, and place it near the top of README. |
| `0.1.0-alpha` GitHub Release | Gives interested users something to try without cloning the repo. | Attach the release zip, include checksum if available, and link to privacy notes. |
| Short screenshot set | Helps posts and README previews travel well. | Include desktop companion, Board, Settings/Diagnostics, and provider list. |
| Provider support matrix | Answers "will this work for my setup?" immediately. | Keep README table current when provider behavior changes. |
| Good first issues | Turns attention into contribution. | Convert tasks from `docs/contributor-tasks.md` into GitHub issues. |

## GitHub Repository Setup

Suggested repository topics:

`macos`, `swift`, `ai-agents`, `codex`, `claude`, `chatgpt`, `local-first`,
`agent-monitoring`, `desktop-companion`

Recommended pinned links:

- Latest release.
- Visual showcase.
- Privacy notes.
- Contributor task board.

## Launch Sequence

1. Ship a small alpha release.
2. Update README with the demo asset, release link, provider matrix, and privacy
   boundary.
3. Convert at least five contributor tasks into GitHub issues.
4. Share the first post with a small group of agent-heavy developers and ask for
   concrete first-run feedback.
5. After obvious first-run issues are fixed, post to broader communities.

## Short English Post

```text
I am building mahjong, a local-first macOS desktop companion for watching AI
agents work across Codex, Claude, ChatGPT Desktop, Hermes, and terminal sessions.

It shows a small floating Mahjong tile and opens a Board with running,
completed, and archived local agent tasks. The app is intentionally read-only:
it does not upload conversation data, mutate provider config, send messages, or
control other apps.

I am looking for early users who often run multiple agents at once. Feedback on
first-run friction, missing providers, and confusing status labels would be the
most useful.

GitHub: https://github.com/ximendatie/mahjong
```

## Short Chinese Post

```text
我在做 mahjong，一个本地优先的 macOS 桌面伴侣，用来观察 Codex、Claude、
ChatGPT Desktop、Hermes 和终端里的 AI Agent 工作状态。

它会显示一个悬浮麻将牌，也可以打开 Board 查看运行中、已完成和已归档的本地
Agent 任务。设计边界是默认只读：不上传对话数据、不修改 provider 配置、不发
消息，也不控制其他应用。

现在想找一些经常同时跑多个 Agent 的早期用户试用。最需要的反馈是首次运行哪
里卡住、还缺哪些 provider、哪些状态文案不清楚。

GitHub: https://github.com/ximendatie/mahjong
```

## Community Targets

| Channel | Timing | Angle |
| --- | --- | --- |
| GitHub Release | First | Alpha release with clear safety boundary and known limitations. |
| X / Twitter | First | Demo video plus one-sentence problem statement. |
| V2EX | First | macOS local tool, privacy boundary, ask for early feedback. |
| Reddit `r/MacApps` | After release | Lightweight macOS utility for agent users. |
| Reddit `r/LocalLLaMA` | After provider docs are stable | Local-first agent monitoring, provider extensibility. |
| Hacker News `Show HN` | After first-run issues are fixed | Technical angle: local-first desktop companion for AI agent work. |

## Feedback To Ask For

- Did the app run within five minutes?
- Which providers did it detect correctly or miss?
- Were privacy boundaries clear before granting any permissions?
- Which status labels were confusing?
- What would make this useful enough to keep running all day?
