import Foundation
import Supabase

class SongService: ObservableObject {
    @Published var currentSong: Song?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let supabase = SupabaseManager.shared.supabase
    
    func fetchSongOfTheDay() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        do {
            // Get today's date in the format used in the database (YYYY-MM-DD)
            let today = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let todayString = dateFormatter.string(from: today)
            
            // Fetch song for today from Supabase
            let songs: [Song] = try await supabase
                .from(Config.tracksTableName)
                .select()
                .eq("id", value: todayString)
                .execute()
                .value
            
            await MainActor.run {
                if let song = songs.first {
                    self.currentSong = song
                } else {
                    // Fallback to sample data if no song found for today
                    self.currentSong = Song.random()
                }
                self.isLoading = false
            }
            
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
                // Fallback to sample data on error
                self.currentSong = Song.random()
            }
        }
    }
    
    func refreshSong() {
        Task {
            await fetchSongOfTheDay()
        }
    }
}