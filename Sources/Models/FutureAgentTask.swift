import Foundation

enum FutureAgent: String, CaseIterable, Codable, Identifiable, Sendable {
    case codex
    case claude
    case chatGPT
    case terminal

    var id: String { rawValue }

    var title: String {
        switch self {
        case .codex: "Codex"
        case .claude: "Claude"
        case .chatGPT: "ChatGPT"
        case .terminal: "Terminal"
        }
    }

    var modelPlaceholder: String {
        switch self {
        case .codex: "GPT-5 / 默认 Codex 模型"
        case .claude: "Claude Sonnet / 默认 Claude 模型"
        case .chatGPT: "GPT-5 / ChatGPT"
        case .terminal: "本地 CLI 默认模型"
        }
    }

    var systemImage: String {
        switch self {
        case .codex: "sparkles"
        case .claude: "text.bubble"
        case .chatGPT: "bubble.left.and.bubble.right"
        case .terminal: "terminal"
        }
    }
}

struct FutureAgentTask: Identifiable, Codable, Equatable, Sendable {
    let id: UUID
    var title: String
    var prompt: String
    var agent: FutureAgent
    var modelHint: String
    var scheduledAt: Date
    var createdAt: Date

    init(
        id: UUID = UUID(),
        title: String,
        prompt: String,
        agent: FutureAgent,
        modelHint: String,
        scheduledAt: Date,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.prompt = prompt
        self.agent = agent
        self.modelHint = modelHint
        self.scheduledAt = scheduledAt
        self.createdAt = createdAt
    }
}
