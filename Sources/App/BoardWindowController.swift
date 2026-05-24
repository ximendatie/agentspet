import AppKit
import SwiftUI

@MainActor
final class BoardWindowController: NSObject, NSWindowDelegate {
    private let window: NSPanel

    init(taskStore: AgentTaskStore) {
        let rootView = BoardView(taskStore: taskStore)
        let frame = Self.defaultFrame()

        window = NSPanel(
            contentRect: frame,
            styleMask: [.titled, .closable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        window.title = "Agent Board"
        window.minSize = NSSize(width: 760, height: 420)
        window.level = .floating
        window.isReleasedWhenClosed = false
        window.titlebarAppearsTransparent = true
        window.toolbarStyle = .unifiedCompact
        window.collectionBehavior = [.fullScreenAuxiliary]
        window.contentView = NSHostingView(rootView: rootView)

        super.init()
        window.delegate = self
    }

    func toggle() {
        if window.isVisible {
            window.orderOut(nil)
        } else {
            show()
        }
    }

    private func show() {
        NSApp.activate(ignoringOtherApps: true)
        window.makeKeyAndOrderFront(nil)
    }

    private static func defaultFrame() -> NSRect {
        let visibleFrame = NSScreen.main?.visibleFrame ?? NSRect(x: 0, y: 0, width: 1440, height: 900)
        let size = NSSize(width: 920, height: 560)
        return NSRect(
            x: visibleFrame.midX - size.width / 2,
            y: visibleFrame.midY - size.height / 2,
            width: size.width,
            height: size.height
        )
    }
}

