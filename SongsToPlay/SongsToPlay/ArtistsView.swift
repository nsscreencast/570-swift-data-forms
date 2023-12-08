import SwiftData
import SwiftUI

struct ArtistsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var artists: [Artist]
    @State var editingArtist: Artist?

    var body: some View {
        List {
            ForEach(artists) { artist in
                Text(artist.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        editingArtist = artist
                    }
            }
            .onDelete(perform: { indexSet in
                for index in indexSet {
                    modelContext.delete(artists[index])
                }
            })
        }
        .toolbar {
            Button("Add", systemImage: "person.add") {
                editingArtist = Artist(name: "New Artist")
            }
        }
        .navigationTitle("Artists")
        .sheet(item: $editingArtist) { artist in
            NavigationStack {
                ArtistForm(artistID: artist.id, isNewRecord: artist.isNewRecord, container: modelContext.container)
                    .navigationTitle(artist.isNewRecord ? "New Artist" : "Edit Artist")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .presentationDetents([.height(200)])
        }
    }
}

extension PersistentModel {
    var isNewRecord: Bool {
        persistentModelID.storeIdentifier == nil
    }
}

#Preview {
    NavigationStack {
        ArtistsView()
    }
    .modelContainer(for: Artist.self, inMemory: true)
}

#Preview("Showing sheet") {
    let container = try! ModelContainer(for: Artist.self, configurations: .init(isStoredInMemoryOnly: true))
    let artist = Artist(name: "")

    return NavigationStack {
        ArtistsView(editingArtist: artist)
    }
    .modelContainer(container)
}
