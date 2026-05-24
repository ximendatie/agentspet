import AppKit
import SwiftUI

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
    private let taskStore = AgentTaskStore()
    private var petWindowController: PetWindowController?
    private var boardWindowController: BoardWindowController?

    func applicationDidFinishLaunching(_ notification: Notification) {
        let boardWindowController = BoardWindowController(taskStore: taskStore)
        let petWindowController = PetWindowController(taskStore: taskStore) {
            boardWindowController.toggle()
        }

        self.boardWindowController = boardWindowController
        self.petWindowController = petWindowController

        taskStore.startRefreshing()
        petWindowController.show()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        false
    }
}
