import Foundation

class SongService: ObservableObject {
    @Published var currentSong: Song?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // TODO: Replace with your actual API endpoint
    private let baseURL = "https://your-api-endpoint.com/api"
    
    func fetchSongOfTheDay() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        do {
            // TODO: Replace with actual API call
            // For now, we'll use sample data
            try await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds delay
            
            await MainActor.run {
                self.currentSong = Song.random()
                self.isLoading = false
            }
            
            // Example of how the actual API call would look:
            /*
            guard let url = URL(string: "\(baseURL)/song-of-the-day") else {
                throw URLError(.badURL)
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let song = try JSONDecoder().decode(Song.self, from: data)
            
            await MainActor.run {
                self.currentSong = song
                self.isLoading = false
            }
            */
            
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func refreshSong() {
        Task {
            await fetchSongOfTheDay()
        }
    }
}