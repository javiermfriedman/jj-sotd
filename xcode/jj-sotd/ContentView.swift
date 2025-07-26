import SwiftUI

struct ContentView: View {
    @State private var song: Song? = nil
    @State private var isLoading: Bool = true

    var body: some View {
        ZStack {
            // Light brown background
            Color(red: 0.78, green: 0.69, blue: 0.57) // ≈ #C7B199
                .ignoresSafeArea()

            if isLoading {
                ProgressView("Loading Song of the Day...")
                    .font(.custom("Georgia", size: 16))
                    .foregroundColor(.black)
            } else if let song = song {
                VStack(spacing: 28) {
                    // MARK: - Header
                    VStack(spacing: 4) {
                        Text("Song of the Day")
                            .font(.custom("Georgia-Bold", size: 26))
                            .foregroundColor(.black)

                        Text(Date().formatted(date: .abbreviated, time: .omitted))
                            .font(.custom("Georgia", size: 14))
                            .foregroundColor(.black.opacity(0.6))
                    }
                    .padding(.top, 32)

                    // MARK: - Album Art
                    albumArtView(for: song)
                        .padding(.vertical, 12)

                    // MARK: - Song Info
                    VStack(spacing: 6) {
                        Text(song.title)
                            .font(.custom("Georgia-Bold", size: 22))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        Text(song.artist)
                            .font(.custom("Georgia", size: 16))
                            .foregroundColor(.black.opacity(0.75))
                            .multilineTextAlignment(.center)
                    }

                    // MARK: - Platform Buttons
                    VStack(spacing: 6) {
                        Text("Listen on")
                            .font(.custom("Georgia-Italic", size: 13))
                            .foregroundColor(.black.opacity(0.6))

                        HStack(spacing: 16) {
                            MusicPlatformButton(icon: "icons8-apple-music-50", size: 36) {
                                if let url = song.generateAppleMusicURL() {
                                    UIApplication.shared.open(url)
                                }
                            }

                            MusicPlatformButton(icon: "icons8-spotify-50", size: 36) {
                                if let url = song.generateSpotifyURL() {
                                    UIApplication.shared.open(url)
                                }
                            }

                            MusicPlatformButton(icon: "icons8-amazon-music-50", size: 36) {
                                if let url = song.generateAmazonMusicURL() {
                                    UIApplication.shared.open(url)
                                }
                            }

                            MusicPlatformButton(icon: "icons8-youtube-50", size: 36) {
                                if let url = song.generateYouTubeURL() {
                                    UIApplication.shared.open(url)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 28)
                }
                .padding(.horizontal, 18)
            } else {
                VStack {
                    Text("Failed to load song.")
                        .font(.custom("Georgia-Bold", size: 18))
                        .foregroundColor(.black)
                    Text("Please check your connection or try again later.")
                        .font(.custom("Georgia", size: 14))
                        .foregroundColor(.black.opacity(0.6))
                        .multilineTextAlignment(.center)
                }
                .padding()
            }
        }
        .onAppear {
            SupabaseService.shared.fetchTopSong { result in
                self.song = result
                self.isLoading = false
            }
        }
    }

    // MARK: - Album Art View
    private func albumArtView(for song: Song) -> some View {
        Group {
            if let albumArtURL = song.albumArtURL, let url = URL(string: albumArtURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 260, height: 260)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 260, height: 260)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                            .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.black.opacity(0.1), lineWidth: 1))
                    case .failure:
                        placeholderArtwork
                    @unknown default:
                        placeholderArtwork
                    }
                }
            } else {
                placeholderArtwork
            }
        }
    }

    // MARK: - Placeholder Art
    private var placeholderArtwork: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.gray.opacity(0.15))
                .frame(width: 260, height: 260)

            VStack(spacing: 6) {
                Image(systemName: "music.note")
                    .font(.system(size: 48))
                    .foregroundColor(.gray)

                Text("Album Art")
                    .font(.custom("Georgia", size: 12))
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    ContentView()
}
