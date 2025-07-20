# 🎵 Song of the Day Backend

This backend powers the *Song of the Day* app, fetching and managing track data from Spotify, and optionally enriching it with links from other platforms like Apple Music, YouTube, and Amazon Music using the Odesli (Song.link) API.

## 🛠️ Features
- Fetch tracks from a specified Spotify playlist
- Extract and organize detailed metadata (track name, artist, album, etc.)
- Retrieve cross-platform links (Apple Music, YouTube, Amazon Music)
- Export data to a CSV for frontend consumption or analytics

## 📁 Project Structure
build_backend/
├── main.py # Entry point for generating and saving track data
├── spotify_utils.py # Spotify API integration logic
├── cross_platform_link_resolver.py # Uses Odesli API to fetch external music links
├── tracks.csv # Output CSV file with enriched track data
├── readme.md # You're reading it!

back end readme

using songlink api : https://linktree.notion.site/API-d0ebe08a5e304a55928405eb682f6741 using spotify api