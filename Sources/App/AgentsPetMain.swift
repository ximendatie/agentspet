import AppKit

@main
enum AgentsPetMain {
    @MainActor private static var appDelegate: AppDelegate?

    @MainActor
    static func main() {
        let application = NSApplication.shared
        let delegate = AppDelegate()
        appDelegate = delegate
        application.delegate = appDelegate
        application.setActivationPolicy(.accessory)
        application.run()
    }
}
