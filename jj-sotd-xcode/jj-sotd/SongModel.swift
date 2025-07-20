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
    let appleMusicURL: String?
    let amazonMusicURL: String?
    let youtubeURL: String?
    
    enum CodingKeys: String, CodingKey {
        case title, artist, album, releaseYear
        case albumArtURL = "album_art_url"
        case previewURL = "preview_url"
        case spotifyURL = "spotify_url"
        case appleMusicURL = "apple_music_url"
        case amazonMusicURL = "amazon_music_url"
        case youtubeURL = "youtube_url"
    }
    
    // Generate URLs for different music platforms
    func generateAppleMusicURL() -> URL? {
        let searchQuery = "\(title) \(artist)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return URL(string: "https://music.apple.com/search?term=\(searchQuery)")
    }
    
    func generateSpotifyURL() -> URL? {
        if let spotifyURL = spotifyURL, let url = URL(string: spotifyURL) {
            return url
        }
        let searchQuery = "\(title) \(artist)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return URL(string: "https://open.spotify.com/search/\(searchQuery)")
    }
    
    func generateAmazonMusicURL() -> URL? {
        if let amazonMusicURL = amazonMusicURL, let url = URL(string: amazonMusicURL) {
            return url
        }
        let searchQuery = "\(title) \(artist)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return URL(string: "https://music.amazon.com/search?query=\(searchQuery)")
    }
    
    func generateYouTubeURL() -> URL? {
        if let youtubeURL = youtubeURL, let url = URL(string: youtubeURL) {
            return url
        }
        let searchQuery = "\(title) \(artist) official".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return URL(string: "https://www.youtube.com/results?search_query=\(searchQuery)")
    }
}

// Sample data for development
extension Song {
    static let sampleSongs: [Song] = [
        Song(title: "Bohemian Rhapsody", artist: "Queen", album: "A Night at the Opera", releaseYear: "1975", albumArtURL: nil, previewURL: nil, spotifyURL: nil, appleMusicURL: nil, amazonMusicURL: nil, youtubeURL: nil),
        Song(title: "Hotel California", artist: "Eagles", album: "Hotel California", releaseYear: "1976", albumArtURL: nil, previewURL: nil, spotifyURL: nil, appleMusicURL: nil, amazonMusicURL: nil, youtubeURL: nil),
        Song(title: "Stairway to Heaven", artist: "Led Zeppelin", album: "Led Zeppelin IV", releaseYear: "1971", albumArtURL: nil, previewURL: nil, spotifyURL: nil, appleMusicURL: nil, amazonMusicURL: nil, youtubeURL: nil),
        Song(title: "Imagine", artist: "John Lennon", album: "Imagine", releaseYear: "1971", albumArtURL: nil, previewURL: nil, spotifyURL: nil, appleMusicURL: nil, amazonMusicURL: nil, youtubeURL: nil),
        Song(title: "Hey Jude", artist: "The Beatles", album: "The Beatles 1967-1970", releaseYear: "1968", albumArtURL: nil, previewURL: nil, spotifyURL: nil, appleMusicURL: nil, amazonMusicURL: nil, youtubeURL: nil),
        Song(title: "Smells Like Teen Spirit", artist: "Nirvana", album: "Nevermind", releaseYear: "1991", albumArtURL: nil, previewURL: nil, spotifyURL: nil, appleMusicURL: nil, amazonMusicURL: nil, youtubeURL: nil),
        Song(title: "Like a Rolling Stone", artist: "Bob Dylan", album: "Highway 61 Revisited", releaseYear: "1965", albumArtURL: nil, previewURL: nil, spotifyURL: nil, appleMusicURL: nil, amazonMusicURL: nil, youtubeURL: nil),
        Song(title: "Respect", artist: "Aretha Franklin", album: "I Never Loved a Man the Way I Love You", releaseYear: "1967", albumArtURL: nil, previewURL: nil, spotifyURL: nil, appleMusicURL: nil, amazonMusicURL: nil, youtubeURL: nil)
    ]
    
    static func random() -> Song {
        sampleSongs.randomElement() ?? sampleSongs[0]
    }
}