import SwiftUI
import SwiftData

struct ArtistForm: View {
    @Environment(\.dismiss) var dismiss
    private let modelContext: ModelContext
    private let artist: Artist

    init(artistID: PersistentIdentifier, isNewRecord: Bool, container: ModelContainer) {
        let context = ModelContext(container)
        context.autosaveEnabled = false
        if isNewRecord {
            artist = Artist(name: "")
        } else {
            artist = context.model(for: artistID) as! Artist
        }
        modelContext = context
    }

    var body: some View {
        ArtistFormContent(artist: artist)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        saveChanges()
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
    }

    private func saveChanges() {
        if artist.isNewRecord {
            modelContext.insert(artist)
        }
        try! modelContext.save()
    }
}

private struct ArtistFormContent: View {
    @Bindable var artist: Artist

    var body: some View {
        Form {
            TextField("Name", text: $artist.name)
        }
    }
}

#Preview {
    _ = try! ModelContainer(for: Artist.self, configurations: .init(isStoredInMemoryOnly: true))

    return NavigationStack {
        ArtistFormContent(artist: .init(name: "Jimi Hendrix"))
    }
}
