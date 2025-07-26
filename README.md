# 🎶 Song of the Day (SOTD)

A minimalist iOS app that displays a new song every day, beautifully styled to match the album art. Powered by Supabase, Spotify API, and a SwiftUI frontend with dynamic color analysis and psychedelic splash animations.

---

### 🌟 Features

- 🔥 **Daily Song Display:** Automatically fetches the latest song from Supabase.
- 🎨 **Dynamic Theming:** Background and text colors adapt to the dominant color of the album cover.
- 🌀 **Animated Splash Screen:** Trippy psychedelic animation shown while loading data.
- 🔗 **Cross-Platform Links:** Users can stream the song on Spotify, Apple Music, Amazon Music, or YouTube.
- 🤖 **Backend Automation:** GitHub Actions delete expired songs daily from Supabase.
- 🎛 **Local Admin Tool:** Easily add new songs or import entire playlists via CLI.

---

### 🧱 Tech Stack

#### Frontend
- `SwiftUI`
- `AsyncImage`, `UIViewRepresentable`, `CoreGraphics` for image/color analysis

#### Backend
- `Supabase` (PostgreSQL, Edge Functions)
- `Spotify Web API`
- `Python` scripts for track ingestion and pruning

#### Automation
- `GitHub Actions` — Cron job deletes yesterday’s song daily at midnight.

---

### 📦 Directory Structure

```bash
.
├── iOS/
│   ├── SplashView.swift           # Animated loading screen
│   ├── ContentView.swift          # Displays song info & links
│   ├── MusicPlatformButton.swift  # Reusable button component
│   ├── ColorAnalyzer.swift        # Dominant color extractor
│   ├── UIImage+DominantColor.swift
│   ├── UIColor+Brightness.swift
│   └── SongModel.swift            # Swift model matching Supabase schema
├── backend/
│   ├── supabase_utils.py          # Read/write/delete Supabase rows
│   ├── spotify_utils.py           # Pull track/playlist metadata
│   ├── add_song.py                # Add individual song
│   ├── get_track.py               # Pull single track metadata
│   ├── prune_oldest.py            # Remove oldest song in Supabase
│   └── nexus.py                   # CLI for managing song database
├── .github/
│   └── workflows/
│       └── daily_cleanup.yml      # GitHub Action to delete daily song
├── requirements.txt
└── README.md
