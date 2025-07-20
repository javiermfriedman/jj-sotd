import Foundation

struct Song: Codable, Identifiable {
    let id: String
    let title: String
    let artist: String
    let albumArtURL: String?
    let spotifyURL: String?
    let appleMusicURL: String?
    let amazonMusicURL: String?
    let youtubeURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, artist
        case albumArtURL = "album_art_url"
        case spotifyURL = "audio_url_spotify"
        case appleMusicURL = "audio_url_apple"
        case amazonMusicURL = "audio_url_amazon"
        case youtubeURL = "audio_url_ytube"
    }
    
    // Generate URLs for different music platforms
    func generateAppleMusicURL() -> URL? {
        if let appleMusicURL = appleMusicURL, let url = URL(string: appleMusicURL) {
            return url
        }
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
        Song(id: "2025-07-20", title: "Slicedat_", artist: "Knxwledge", albumArtURL: "https://i.scdn.co/image/ab67616d0000b27320f5dac1b5c6ddfe2f11c07d", spotifyURL: "https://open.spotify.com/track/6NYjwsMjq0ZTZ0j27tLjz6", appleMusicURL: "https://geo.music.apple.com/us/album/_/1500350655?i=1500350659&mt=1&app=music&ls=1&at=1000lHKX&ct=api_http&itscg=30200&itsct=odsl_m", amazonMusicURL: "https://music.amazon.com/albums/B08546N5BY?trackAsin=B0854BBGRH", youtubeURL: "https://www.youtube.com/watch?v=GUrxmy52TkM"),
        Song(id: "2025-07-21", title: "Get Jiggy", artist: "B Jack$, ZEDDY WILL", albumArtURL: "https://i.scdn.co/image/ab67616d0000b2730cc0b36379c71e1276ba35da", spotifyURL: "https://open.spotify.com/track/55NuTxRk1TyKzpgD8dC1IY", appleMusicURL: "https://geo.music.apple.com/us/album/_/1794826235?i=1794826236&mt=1&app=music&ls=1&at=1000lHKX&ct=api_http&itscg=30200&itsct=odsl_m", amazonMusicURL: "https://music.amazon.com/albums/B0DWB98XWJ?trackAsin=B0DWBC1GRL", youtubeURL: "https://www.youtube.com/watch?v=khwLYLx2gJ8"),
        Song(id: "2025-07-22", title: "All In", artist: "Earl Sweatshirt, LUCKI", albumArtURL: "https://i.scdn.co/image/ab67616d0000b273ea5c803c889b985833ae8b8e", spotifyURL: "https://open.spotify.com/track/3usWHldhgpQvKVaW5uC9Ke", appleMusicURL: "https://geo.music.apple.com/us/album/_/1452018190?i=1452018439&mt=1&app=music&ls=1&at=1000lHKX&ct=api_http&itscg=30200&itsct=odsl_m", amazonMusicURL: "https://music.amazon.com/albums/B07NJLZKDS?trackAsin=B07NJM5WPP", youtubeURL: "https://www.youtube.com/watch?v=UYlpTQZZK5A")
    ]
    
    static func random() -> Song {
        sampleSongs.randomElement() ?? sampleSongs[0]
    }
}