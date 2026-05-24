import Foundation

protocol AgentTaskProvider: Sendable {
    var providerName: String { get }

    func fetchTasks() async -> [AgentTask]
}
