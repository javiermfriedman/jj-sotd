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
            
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 8) {
                    Text("Song of the Day")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text(Date().formatted(date: .complete, time: .omitted))
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.top, 20)
                
                Spacer()
                
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
                VStack(spacing: 16) {
                    VStack(spacing: 8) {
                        Text(songService.currentSong?.title ?? "Loading...")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        Text(songService.currentSong?.artist ?? "")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))
                        
                        Text(songService.currentSong?.album ?? "")
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .foregroundColor(.white.opacity(0.7))
                        
                        Text(songService.currentSong?.releaseYear ?? "")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.6))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.white.opacity(0.2))
                            )
                    }
                    .padding(.horizontal, 20)
                }
                
                // Music platform buttons
                if let song = songService.currentSong {
                    VStack(spacing: 12) {
                        Text("Listen on")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.7))
                        
                        HStack(spacing: 16) {
                            // Apple Music
                            MusicPlatformButton(
                                icon: "AppleMusic",
                                color: Color(red: 0.9, green: 0.3, blue: 0.3),
                                action: {
                                    if let url = song.generateAppleMusicURL() {
                                        UIApplication.shared.open(url)
                                    }
                                }
                            )
                            
                            // Spotify
                            MusicPlatformButton(
                                icon: "Spotify",
                                color: Color(red: 0.2, green: 0.8, blue: 0.4),
                                action: {
                                    if let url = song.generateSpotifyURL() {
                                        UIApplication.shared.open(url)
                                    }
                                }
                            )
                            
                            // Amazon Music
                            MusicPlatformButton(
                                icon: "AmazonMusic",
                                color: Color(red: 0.9, green: 0.7, blue: 0.2),
                                action: {
                                    if let url = song.generateAmazonMusicURL() {
                                        UIApplication.shared.open(url)
                                    }
                                }
                            )
                            
                            // YouTube
                            MusicPlatformButton(
                                icon: "YouTube",
                                color: Color(red: 0.9, green: 0.2, blue: 0.2),
                                action: {
                                    if let url = song.generateYouTubeURL() {
                                        UIApplication.shared.open(url)
                                    }
                                }
                            )
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                Spacer()
                
                // Action buttons
                VStack(spacing: 16) {
                    // Refresh button
                    Button(action: {
                        songService.refreshSong()
                    }) {
                        HStack(spacing: 8) {
                            if songService.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            } else {
                                Image(systemName: "arrow.clockwise")
                                    .font(.system(size: 16, weight: .medium))
                            }
                            
                            Text(songService.isLoading ? "Loading..." : "New Song")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white.opacity(0.2))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                    }
                    .disabled(songService.isLoading)
                    
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
                .padding(.bottom, 40)
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
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(color)
                )
                .shadow(color: color.opacity(0.3), radius: 8, x: 0, y: 4)
        }
    }
}

#Preview {
    ContentView()
}