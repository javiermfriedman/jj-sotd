# Song of the Day App

A beautiful, simple iOS app that displays a daily song recommendation with a modern, clean interface built using SwiftUI.

## Features

- **Beautiful UI**: Modern gradient background with clean typography
- **Song Information**: Displays title, artist, album, and release year
- **Interactive Elements**: Refresh button to get a new song and play button for preview
- **Loading States**: Smooth loading animations and feedback
- **Responsive Design**: Works on all iPhone sizes and orientations

## Screenshots

The app features:
- Dark gradient background with purple/blue tones
- Large album artwork placeholder with music icon
- Clean song information display
- Two action buttons: "New Song" and "Play Preview"
- Current date display
- Loading states with progress indicators

## Architecture

The app is built with a clean architecture using:

- **SwiftUI**: Modern declarative UI framework
- **MVVM Pattern**: Model-View-ViewModel architecture
- **ObservableObject**: For reactive state management
- **Async/Await**: For handling API calls

### File Structure

```
├── SongOfTheDayApp.swift    # Main app entry point
├── ContentView.swift        # Main UI view
├── SongModel.swift          # Data model for songs
├── SongService.swift        # API service layer
└── Info.plist              # App configuration
```

## Getting Started

1. Open the project in Xcode
2. Build and run on your iOS device or simulator
3. The app will display a sample song with the ability to refresh

## Backend Integration

The app is prepared for backend integration with:

- **SongService**: Handles API calls and data fetching
- **Song Model**: Codable struct for JSON parsing
- **Error Handling**: Proper error states and user feedback
- **Loading States**: Smooth loading animations

### API Integration Points

To connect to your backend:

1. Update the `baseURL` in `SongService.swift`
2. Uncomment the API call code in `fetchSongOfTheDay()`
3. Ensure your API returns JSON matching the `Song` model structure

### Expected API Response

```json
{
  "title": "Song Title",
  "artist": "Artist Name", 
  "album": "Album Name",
  "release_year": "2023",
  "album_art_url": "https://example.com/art.jpg",
  "preview_url": "https://example.com/preview.mp3",
  "spotify_url": "https://open.spotify.com/track/..."
}
```

## Customization

### Colors
The app uses a custom color scheme that can be easily modified in `ContentView.swift`:

- Background gradients
- Button colors
- Text colors and opacity levels

### Typography
Fonts and sizes can be adjusted in the view modifiers throughout `ContentView.swift`.

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## License

This project is open source and available under the MIT License.
