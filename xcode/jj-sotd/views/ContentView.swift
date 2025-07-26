import SwiftUI

struct ContentView: View {
    let song: Song
    let backgroundColor: Color
    let foregroundColor: Color

    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()

            VStack(spacing: 28) {
                // MARK: - Header
                VStack(spacing: 4) {
                    Text("Song of the Day")
                        .font(.custom("Georgia-Bold", size: 26))
                        .foregroundColor(foregroundColor)

                    Text(Date().formatted(date: .abbreviated, time: .omitted))
                        .font(.custom("Georgia", size: 14))
                        .foregroundColor(foregroundColor.opacity(0.6))
                }
                .padding(.top, 32)

                // MARK: - Album Art
                albumArtView(for: song)
                    .padding(.vertical, 12)

                // MARK: - Song Info
                VStack(spacing: 6) {
                    Text(song.title)
                        .font(.custom("Georgia-Bold", size: 22))
                        .foregroundColor(foregroundColor)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Text(song.artist)
                        .font(.custom("Georgia", size: 16))
                        .foregroundColor(foregroundColor.opacity(0.75))
                        .multilineTextAlignment(.center)
                }

                // MARK: - Platform Buttons
                VStack(spacing: 6) {
                    Text("Listen on")
                        .font(.custom("Georgia-Italic", size: 13))
                        .foregroundColor(foregroundColor.opacity(0.6))

                    HStack(spacing: 16) {
                        MusicPlatformButton(icon: "icons8-apple-music-50", size: 36, foreground: foregroundColor) {
                            if let url = song.generateAppleMusicURL() {
                                UIApplication.shared.open(url)
                            }
                        }

                        MusicPlatformButton(icon: "icons8-spotify-50", size: 36, foreground: foregroundColor) {
                            if let url = song.generateSpotifyURL() {
                                UIApplication.shared.open(url)
                            }
                        }

                        MusicPlatformButton(icon: "icons8-amazon-music-50", size: 36, foreground: foregroundColor) {
                            if let url = song.generateAmazonMusicURL() {
                                UIApplication.shared.open(url)
                            }
                        }

                        MusicPlatformButton(icon: "icons8-youtube-50", size: 36, foreground: foregroundColor) {
                            if let url = song.generateYouTubeURL() {
                                UIApplication.shared.open(url)
                            }
                        }
                    }
                }
                .padding(.bottom, 28)
            }
            .padding(.horizontal, 18)
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
                            .overlay(RoundedRectangle(cornerRadius: 18).stroke(foregroundColor.opacity(0.1), lineWidth: 1))
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
    ContentView(
        song: Song.sampleSongs[0],
        backgroundColor: Color(red: 0.78, green: 0.69, blue: 0.57),
        foregroundColor: .black
    )
}
