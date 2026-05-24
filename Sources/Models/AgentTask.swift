import Foundation

enum AgentTaskStatus: String, CaseIterable, Identifiable, Sendable {
    case running
    case completed
    case history

    var id: String { rawValue }

    var title: String {
        switch self {
        case .running: "进行中"
        case .completed: "已完成"
        case .history: "历史任务"
        }
    }
}

struct AgentTask: Identifiable, Equatable, Sendable {
    let id: String
    var title: String
    var summary: String
    var agent: String
    var model: String
    var tokenUsage: Int
    var status: AgentTaskStatus
    var updatedAt: Date

    init(
        id: String = UUID().uuidString,
        title: String,
        summary: String,
        agent: String,
        model: String,
        tokenUsage: Int,
        status: AgentTaskStatus,
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.summary = summary
        self.agent = agent
        self.model = model
        self.tokenUsage = tokenUsage
        self.status = status
        self.updatedAt = updatedAt
    }
}
