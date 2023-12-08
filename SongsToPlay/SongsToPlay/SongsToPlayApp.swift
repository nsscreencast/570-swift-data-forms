import SwiftUI
import SwiftData

@main
struct SongsToPlayApp: App {

    private var modelContainer: ModelContainer {
        let config = ModelConfiguration()
        let schema = Schema([Artist.self])
        return try! ModelContainer(for: schema, configurations: [config])
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                #if DEBUG
                .task {
                    let fileManager = FileManager.default
                    let dbURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
                        .appendingPathComponent("default.store")
                    let dbPath = dbURL.path(percentEncoded: false)
                    print("SwiftData db: \(dbPath)")

                    if ProcessInfo.processInfo.arguments.contains(where: { $0 == "-cleandb" }) &&
                        fileManager.fileExists(atPath: dbPath)
                    {
                        try! fileManager.removeItem(at: dbURL)
                    }
                }
                #endif
                .modelContainer(modelContainer)
        }
    }
}
