//  SplashView.swift
//  jj-sotd

import SwiftUI
import Supabase

struct SplashView: View {
    @State private var isReady: Bool = false
    @State private var isLoading: Bool = true
    @State private var showError: Bool = false
    @State private var song: Song? = nil
    @State private var backgroundColor: Color = Color(red: 0.78, green: 0.69, blue: 0.57)
    @State private var foregroundColor: Color = .black

    let minDuration: TimeInterval = 1.5

    var body: some View {
        ZStack {
            // Trippy animated background
            Image("psychedelic_background")
                .resizable()
                .scaledToFill()
                .blur(radius: 10)
                .hueRotation(.degrees(isLoading ? 0 : 360))
                .scaleEffect(isLoading ? 1.1 : 1.0)
                .opacity(isReady ? 0 : 1)
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isLoading)

            if showError {
                VStack(spacing: 12) {
                    Image(systemName: "wifi.slash")
                        .font(.system(size: 28))
                        .foregroundColor(.white.opacity(0.8))
                    Text("Failed to connect")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
            }

            if isReady, let song = song {
                ContentView(song: song,
                            backgroundColor: backgroundColor,
                            foregroundColor: foregroundColor)
                    .transition(.opacity)
            }
        }
        .onAppear {
            withAnimation {
                isLoading = true
            }

            let start = Date()

            SupabaseService.shared.fetchTopSong { result in
                DispatchQueue.main.async {
                    self.song = result

                    if let albumURL = result?.albumArtURL {
                        ColorAnalyzer.computeColors(from: albumURL) { bg, fg in
                            self.backgroundColor = bg
                            self.foregroundColor = fg
                            proceedIfReady(start: start)
                        }
                    } else {
                        proceedIfReady(start: start)
                    }

                    if result == nil {
                        showError = true
                    }
                }
            }
        }
    }

    private func proceedIfReady(start: Date) {
        let delay = max(0, minDuration - Date().timeIntervalSince(start))
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation {
                self.isReady = true
            }
        }
    }
}
