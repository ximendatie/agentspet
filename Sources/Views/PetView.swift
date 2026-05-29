import AppKit
import SwiftUI

struct PetView: View {
    @ObservedObject var taskStore: AgentTaskStore
    let onToggleBoard: () -> Void

    @State private var breathe = false
    @State private var workingPhase = false
    @State private var jump = false

    var body: some View {
        ZStack {
            Color.clear

            VStack(spacing: 0) {
                activePetIcon
                    .scaleEffect(idleScale)
                    .rotationEffect(.degrees(taskStore.isWorking ? (workingPhase ? 4 : -4) : 0))
                    .offset(y: jump ? -18 : 0)
                    .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: workingPhase)
                    .animation(.easeInOut(duration: 3.2).repeatForever(autoreverses: true), value: breathe)
                    .animation(.spring(response: 0.32, dampingFraction: 0.42), value: jump)

                feet
                    .offset(y: jump ? -10 : 0)
            }
            .padding(8)
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: onToggleBoard)
        .onAppear {
            breathe = true
            workingPhase = true
        }
        .onChange(of: taskStore.completionPulseID) { _, _ in
            triggerJump()
        }
    }

    @ViewBuilder
    private var activePetIcon: some View {
        if let image = MahjongTileImages.image(for: taskStore.runningCount) {
            Image(nsImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 69, height: 69)
                .shadow(color: .black.opacity(0.18), radius: 9, y: 5)
                .accessibilityLabel(Text(MahjongTileImages.accessibilityLabel(for: taskStore.runningCount)))
        } else {
            petBody
        }
    }

    private var petBody: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(taskStore.isWorking ? Color.cyan.opacity(0.8) : Color.primary.opacity(0.16), lineWidth: 1.5)
                )
                .shadow(color: taskStore.isWorking ? .cyan.opacity(0.28) : .black.opacity(0.16), radius: 18, y: 8)

            VStack(spacing: 8) {
                HStack(spacing: 18) {
                    eye
                    eye
                }

                CodexMark(isWorking: taskStore.isWorking)
                    .frame(width: 30, height: 30)

                Capsule()
                    .fill(Color.primary.opacity(taskStore.isWorking ? 0.55 : 0.24))
                    .frame(width: 36, height: 4)
                    .overlay(alignment: .trailing) {
                        if taskStore.isWorking {
                            Circle()
                                .fill(Color.cyan)
                                .frame(width: 6, height: 6)
                                .offset(x: workingPhase ? 2 : -30)
                                .animation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true), value: workingPhase)
                        }
                    }
            }

            if taskStore.runningCount > 0 {
                Text("\(taskStore.runningCount)")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(width: 24, height: 24)
                    .background(Circle().fill(Color.cyan.gradient))
                    .overlay(Circle().stroke(.white.opacity(0.55), lineWidth: 1))
                    .offset(x: 36, y: -36)
            }
        }
        .frame(width: 86, height: 82)
    }

    private var eye: some View {
        RoundedRectangle(cornerRadius: 4, style: .continuous)
            .fill(taskStore.isWorking ? Color.cyan : Color.primary.opacity(0.42))
            .frame(width: 12, height: taskStore.isWorking ? 13 : 9)
            .shadow(color: .cyan.opacity(taskStore.isWorking ? 0.5 : 0), radius: 8)
    }

    private var feet: some View {
        HStack(spacing: 22) {
            Capsule().fill(Color.primary.opacity(0.22)).frame(width: 18, height: 7)
            Capsule().fill(Color.primary.opacity(0.22)).frame(width: 18, height: 7)
        }
    }

    private var idleScale: CGFloat {
        if taskStore.isWorking {
            return 1.0
        }

        return breathe ? 1.025 : 0.985
    }

    private func triggerJump() {
        jump = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
            jump = false
        }
    }
}

private enum MahjongTileImages {
    static func image(for runningCount: Int) -> NSImage? {
        let resourceName = resourceName(for: runningCount)
        guard let url = Bundle.main.url(
            forResource: resourceName,
            withExtension: "png",
            subdirectory: "MahjongTiles"
        ) else {
            return nil
        }

        return NSImage(contentsOf: url)
    }

    static func accessibilityLabel(for runningCount: Int) -> String {
        guard runningCount > 0 else {
            return "白板"
        }

        return "\(min(runningCount, 9))筒"
    }

    private static func resourceName(for runningCount: Int) -> String {
        guard runningCount > 0 else {
            return "white"
        }

        return "dot-\(min(runningCount, 9))"
    }
}

private struct CodexMark: View {
    let isWorking: Bool

    var body: some View {
        ZStack {
            Hexagon()
                .stroke(isWorking ? Color.cyan : Color.primary.opacity(0.55), lineWidth: 2)

            ForEach(0..<6) { index in
                Circle()
                    .fill(isWorking ? Color.cyan : Color.primary.opacity(0.42))
                    .frame(width: 4, height: 4)
                    .offset(y: -14)
                    .rotationEffect(.degrees(Double(index) * 60))
            }

            Circle()
                .fill(isWorking ? Color.cyan.opacity(0.85) : Color.primary.opacity(0.32))
                .frame(width: 8, height: 8)
        }
    }
}

private struct Hexagon: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        var path = Path()

        for index in 0..<6 {
            let angle = (Double(index) * 60 - 30) * .pi / 180
            let point = CGPoint(
                x: center.x + CGFloat(cos(angle)) * radius,
                y: center.y + CGFloat(sin(angle)) * radius
            )

            if index == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }

        path.closeSubpath()
        return path
    }
}
