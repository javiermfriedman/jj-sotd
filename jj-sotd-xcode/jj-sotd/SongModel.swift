import Foundation

struct Song: Codable, Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let album: String
    let releaseYear: String
    let albumArtURL: String?
    let previewURL: String?
    let spotifyURL: String?
    
    enum CodingKeys: String, CodingKey {
        case title, artist, album, releaseYear
        case albumArtURL = "album_art_url"
        case previewURL = "preview_url"
        case spotifyURL = "spotify_url"
    }
}

// Sample data for development
extension Song {
    static let sampleSongs: [Song] = [
        Song(title: "Bohemian Rhapsody", artist: "Queen", album: "A Night at the Opera", releaseYear: "1975", albumArtURL: nil, previewURL: nil, spotifyURL: nil),
        Song(title: "Hotel California", artist: "Eagles", album: "Hotel California", releaseYear: "1976", albumArtURL: nil, previewURL: nil, spotifyURL: nil),
        Song(title: "Stairway to Heaven", artist: "Led Zeppelin", album: "Led Zeppelin IV", releaseYear: "1971", albumArtURL: nil, previewURL: nil, spotifyURL: nil),
        Song(title: "Imagine", artist: "John Lennon", album: "Imagine", releaseYear: "1971", albumArtURL: nil, previewURL: nil, spotifyURL: nil),
        Song(title: "Hey Jude", artist: "The Beatles", album: "The Beatles 1967-1970", releaseYear: "1968", albumArtURL: nil, previewURL: nil, spotifyURL: nil),
        Song(title: "Smells Like Teen Spirit", artist: "Nirvana", album: "Nevermind", releaseYear: "1991", albumArtURL: nil, previewURL: nil, spotifyURL: nil),
        Song(title: "Like a Rolling Stone", artist: "Bob Dylan", album: "Highway 61 Revisited", releaseYear: "1965", albumArtURL: nil, previewURL: nil, spotifyURL: nil),
        Song(title: "Respect", artist: "Aretha Franklin", album: "I Never Loved a Man the Way I Love You", releaseYear: "1967", albumArtURL: nil, previewURL: nil, spotifyURL: nil)
    ]
    
    static func random() -> Song {
        sampleSongs.randomElement() ?? sampleSongs[0]
    }
}