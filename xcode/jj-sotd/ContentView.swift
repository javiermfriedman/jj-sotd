import SwiftUI

struct ContentView: View {
    @StateObject private var songService = SongService()
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.1, green: 0.1, blue: 0.2),
                    Color(red: 0.2, green: 0.1, blue: 0.3),
                    Color(red: 0.3, green: 0.1, blue: 0.4)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header 
                VStack(spacing: 4) {
                    Text("Song of the Day")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text(Date().formatted(date: .complete, time: .omitted))
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.top, 35.0)
                
                Spacer(minLength: 5)
                
                // Album artwork placeholder
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.8, green: 0.4, blue: 0.6),
                                    Color(red: 0.6, green: 0.3, blue: 0.8)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 280, height: 280)
                        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                    
                    VStack(spacing: 8) {
                        Image(systemName: "music.note")
                            .font(.system(size: 60))
                            .foregroundColor(.white.opacity(0.9))
                        
                        Text("Album Art")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                
                // Song information
                VStack(spacing: 12) {
                    VStack(spacing: 6) {
                        Text(songService.currentSong?.title ?? "Loading...")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(minHeight: 50, maxHeight: 70, alignment: .center)
                        
                        Text(songService.currentSong?.artist ?? "")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))
                            .frame(height: 22)
                    }
                    .padding(.horizontal, 20)
                }
                .frame(height: 140) // Reduced height for song information section
                
                // Music platform buttons
                VStack(spacing: 8) {
                    Text("Listen on")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                    
                    HStack(spacing: 16) {
                        // Apple Music
                        MusicPlatformButton(
                            icon: "AppleMusic",
                            size: 55,
                            action: {
                                if let song = songService.currentSong,
                                   let url = song.generateAppleMusicURL() {
                                    UIApplication.shared.open(url)
                                }
                            }
                        )
                        .opacity(songService.currentSong != nil ? 1.0 : 0.3)
                        .disabled(songService.currentSong == nil)
                        
                        // Spotify
                        MusicPlatformButton(
                            icon: "Spotify",
                            size: 50,
                            action: {
                                if let song = songService.currentSong,
                                   let url = song.generateSpotifyURL() {
                                    UIApplication.shared.open(url)
                                }
                            }
                        )
                        .opacity(songService.currentSong != nil ? 1.0 : 0.3)
                        .disabled(songService.currentSong == nil)
                        
                        // Amazon Music
                        MusicPlatformButton(
                            icon: "AmazonMusic",
                            size: 55,
                            action: {
                                if let song = songService.currentSong,
                                   let url = song.generateAmazonMusicURL() {
                                    UIApplication.shared.open(url)
                                }
                            }
                        )
                        .opacity(songService.currentSong != nil ? 1.0 : 0.3)
                        .disabled(songService.currentSong == nil)
                        
                        // YouTube
                        MusicPlatformButton(
                            icon: "YouTube",
                            size: 50,
                            action: {
                                if let song = songService.currentSong,
                                   let url = song.generateYouTubeURL() {
                                    UIApplication.shared.open(url)
                                }
                            }
                        )
                        .opacity(songService.currentSong != nil ? 1.0 : 0.3)
                        .disabled(songService.currentSong == nil)
                    }
                    .padding(.horizontal, 20)
                }
                .frame(height: 80) // Reduced height for music platform buttons section
                
                Spacer(minLength: 10)
                
                // Action buttons
                VStack(spacing: 12) {
                    // Play button
                    Button(action: {
                        // TODO: Implement play functionality
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "play.fill")
                                .font(.system(size: 16, weight: .medium))
                            
                            Text("Play Preview")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(red: 0.8, green: 0.4, blue: 0.6))
                        )
                        .shadow(color: Color(red: 0.8, green: 0.4, blue: 0.6).opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .onAppear {
            if songService.currentSong == nil {
                Task {
                    await songService.fetchSongOfTheDay()
                }
            }
        }
    }
}

// Custom button component for music platforms
struct MusicPlatformButton: View {
    let icon: String
    let size: CGFloat
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
        }
    }
}

#Preview {
    ContentView()
}
