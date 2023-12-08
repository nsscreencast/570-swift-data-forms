import Foundation
import SwiftData

@Model
class Artist {
    var name: String

    @Relationship(deleteRule: .cascade, inverse: \Song.artist)
    var songs: [Song] = []

    init(name: String) {
        self.name = name
    }
}
