import SwiftUI

struct BoardView: View {
    @ObservedObject var taskStore: AgentTaskStore

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            columns
        }
        .frame(minWidth: 760, minHeight: 420)
        .background(.regularMaterial)
    }

    private var header: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Agent Board")
                    .font(.title3.weight(.semibold))
                Text("全局 Agent 运行状态")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            runningBadge

            Button {
                taskStore.refreshNow()
            } label: {
                Label("刷新", systemImage: "arrow.clockwise")
            }

            Button {
                taskStore.addMockRunningTask()
            } label: {
                Label("新增", systemImage: "plus")
            }

            Button {
                taskStore.completeOldestRunningTask()
            } label: {
                Label("完成", systemImage: "checkmark")
            }

            Button {
                taskStore.archiveCompletedTasks()
            } label: {
                Label("归档", systemImage: "archivebox")
            }
        }
        .buttonStyle(.bordered)
        .padding(.horizontal, 18)
        .padding(.top, 18)
        .padding(.bottom, 14)
    }

    private var runningBadge: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(taskStore.isWorking ? Color.cyan : Color.secondary.opacity(0.45))
                .frame(width: 8, height: 8)
            Text("\(taskStore.runningCount) running")
                .font(.caption.weight(.medium))
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Capsule().fill(Color.primary.opacity(0.07)))
    }

    private var columns: some View {
        HStack(spacing: 0) {
            TaskColumnView(status: .running, tasks: taskStore.tasks(for: .running))
            Divider()
            TaskColumnView(status: .completed, tasks: taskStore.tasks(for: .completed))
            Divider()
            TaskColumnView(status: .history, tasks: taskStore.tasks(for: .history))
        }
    }
}

private struct TaskColumnView: View {
    let status: AgentTaskStatus
    let tasks: [AgentTask]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(status.title)
                    .font(.headline)
                Spacer()
                Text("\(tasks.count)")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .frame(minWidth: 24)
                    .padding(.vertical, 3)
                    .background(Capsule().fill(Color.primary.opacity(0.07)))
            }
            .padding(.horizontal, 16)
            .padding(.top, 14)

            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(tasks) { task in
                        TaskCardView(task: task)
                    }

                    if tasks.isEmpty {
                        EmptyColumnView(status: status)
                    }
                }
                .padding(.horizontal, 14)
                .padding(.bottom, 16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

private struct TaskCardView: View {
    let task: AgentTask

    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(statusColor)
                .frame(width: 4)

            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(task.title)
                        .font(.system(size: 14, weight: .semibold))
                        .lineLimit(2)
                    Text(task.summary)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }

                VStack(spacing: 5) {
                    metadataRow("Agent", task.agent)
                    metadataRow("Model", task.model)
                    metadataRow("Tokens", Formatters.tokens(task.tokenUsage))
                }
            }
            .padding(12)
        }
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color(nsColor: .controlBackgroundColor).opacity(task.status == .history ? 0.55 : 0.9))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(Color.primary.opacity(0.08), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    private var statusColor: Color {
        switch task.status {
        case .running: .cyan
        case .completed: .green
        case .history: .secondary.opacity(0.45)
        }
    }

    private func metadataRow(_ label: String, _ value: String) -> some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer(minLength: 8)
            Text(value)
                .fontWeight(.medium)
                .lineLimit(1)
                .truncationMode(.middle)
        }
        .font(.caption2)
    }
}

private struct EmptyColumnView: View {
    let status: AgentTaskStatus

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: iconName)
                .font(.title3)
                .foregroundStyle(.secondary)
            Text("暂无\(status.title)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }

    private var iconName: String {
        switch status {
        case .running: "pause.circle"
        case .completed: "checkmark.circle"
        case .history: "clock"
        }
    }
}
