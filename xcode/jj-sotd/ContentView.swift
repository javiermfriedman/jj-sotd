import SwiftUI
import UIKit
import UIImageColors

struct ContentView: View {
    @State private var song: Song? = nil
    @State private var isLoading: Bool = true
    @State private var backgroundColor: Color = Color(red: 0.78, green: 0.69, blue: 0.57)
    @State private var foregroundColor: Color = .black

    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()

            if isLoading {
                ProgressView("Loading Song of the Day...")
                    .font(.custom("Georgia", size: 16))
                    .foregroundColor(foregroundColor)
            } else if let song = song {
                VStack(spacing: 28) {
                    VStack(spacing: 4) {
                        Text("Song of the Day")
                            .font(.custom("Georgia-Bold", size: 26))
                            .foregroundColor(foregroundColor)

                        Text(Date().formatted(date: .abbreviated, time: .omitted))
                            .font(.custom("Georgia", size: 14))
                            .foregroundColor(foregroundColor.opacity(0.6))
                    }
                    .padding(.top, 32)

                    albumArtView(for: song)
                        .padding(.vertical, 12)

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
            } else {
                VStack {
                    Text("Failed to load song.")
                        .font(.custom("Georgia-Bold", size: 18))
                        .foregroundColor(foregroundColor)
                    Text("Please check your connection or try again later.")
                        .font(.custom("Georgia", size: 14))
                        .foregroundColor(foregroundColor.opacity(0.6))
                        .multilineTextAlignment(.center)
                }
                .padding()
            }
        }
        .onAppear {
            SupabaseService.shared.fetchTopSong { result in
                self.song = result
                self.isLoading = false
                if let url = URL(string: result?.albumArtURL ?? "") {
                    downloadImage(from: url) { image in
                        image?.extractDominantColor { bg, fg in
                            if let bg = bg { self.backgroundColor = bg }
                            if let fg = fg { self.foregroundColor = fg }
                        }
                    }
                }
            }
        }
    }

    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }

    private func albumArtView(for song: Song) -> some View {
        Group {
            if let albumArtURL = song.albumArtURL, let url = URL(string: albumArtURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView().frame(width: 260, height: 260)
                    case .success(let image):
                        image.resizable()
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

// MARK: - Update MusicPlatformButton to accept foreground color
struct MusicPlatformButton: View {
    let icon: String
    let size: CGFloat
    let foreground: Color
    let action: () -> Void

    @GestureState private var isPressed = false

    var body: some View {
        Button(action: action) {
            Image(icon)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
                .foregroundColor(foreground)
                .padding(10)
                .background(foreground.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(foreground.opacity(0.1), lineWidth: 1)
                )
                .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .gesture(
            DragGesture(minimumDistance: 0)
                .updating($isPressed) { _, state, _ in
                    state = true
                }
        )
    }
}
