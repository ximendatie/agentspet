import AppKit
import SwiftUI

@MainActor
final class PetWindowController {
    private let window: NSWindow

    init(taskStore: AgentTaskStore, onToggleBoard: @escaping () -> Void) {
        let size = NSSize(width: 89, height: 89)
        let frame = Self.defaultFrame(size: size)
        let rootView = PetView(taskStore: taskStore, onToggleBoard: onToggleBoard)

        window = NSWindow(
            contentRect: frame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        window.title = "mahjong"
        window.isOpaque = false
        window.backgroundColor = .clear
        window.hasShadow = false
        window.level = .floating
        window.collectionBehavior = [.canJoinAllSpaces, .stationary, .fullScreenAuxiliary, .ignoresCycle]
        window.isMovableByWindowBackground = true
        window.contentView = NSHostingView(rootView: rootView)
    }

    func show() {
        window.orderFrontRegardless()
    }

    private static func defaultFrame(size: NSSize) -> NSRect {
        let visibleFrame = NSScreen.main?.visibleFrame ?? NSRect(x: 0, y: 0, width: 1440, height: 900)
        return NSRect(
            x: visibleFrame.maxX - size.width - 32,
            y: visibleFrame.minY + 48,
            width: size.width,
            height: size.height
        )
    }
}
