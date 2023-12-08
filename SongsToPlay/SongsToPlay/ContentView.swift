import SwiftUI

struct ContentView: View {
    enum Tab: Hashable {
        case artists
    }

    var body: some View {
        TabView {
            NavigationStack {
                ArtistsView()
            }.tag(Tab.artists)
        }
    }
}

#Preview {
    ContentView()
}
