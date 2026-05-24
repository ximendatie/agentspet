import Foundation

protocol AgentRuntimeProvider: Sendable {
    var providerName: String { get }

    func fetchRuntimes() async -> [AgentRuntime]
}
