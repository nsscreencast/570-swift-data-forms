import Foundation
import SwiftData

@Model
class Song {
    var artist: Artist
    var title: String
    var yearReleased: Int?
    var duration: TimeInterval?

    init(artist: Artist, title: String, yearReleased: Int? = nil, duration: TimeInterval? = nil) {
        self.artist = artist
        self.title = title
        self.yearReleased = yearReleased
        self.duration = duration
    }
}
