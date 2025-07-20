# Supabase Setup for iOS App

## Prerequisites
1. A Supabase project with a `tracks` table
2. The tracks table should have the following columns:
   - `id` (text) - Date in YYYY-MM-DD format
   - `title` (text) - Song title
   - `artist` (text) - Artist name
   - `album_art_url` (text) - URL to album artwork
   - `audio_url_spotify` (text) - Spotify track URL
   - `audio_url_apple` (text) - Apple Music track URL
   - `audio_url_amazon` (text) - Amazon Music track URL
   - `audio_url_ytube` (text) - YouTube video URL

## Setup Steps

### 1. Install Supabase Swift SDK
1. In Xcode, go to **File > Add Packages**
2. Enter the repository URL: `https://github.com/supabase/supabase-swift`
3. Choose the latest version and add it to your app target

### 2. Configure Supabase Credentials
1. Open `Config.swift` in your Xcode project
2. Replace the placeholder values with your actual Supabase credentials:
   ```swift
   static let supabaseURL = "https://your-actual-project-id.supabase.co"
   static let supabaseAnonKey = "your-actual-anon-key"
   ```

### 3. Get Your Supabase Credentials
1. Go to your Supabase project dashboard
2. Navigate to **Settings > API**
3. Copy the **Project URL** and **anon public** key
4. Paste them into `Config.swift`

### 4. Create the Tracks Table
Run this SQL in your Supabase SQL editor:

```sql
CREATE TABLE tracks (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    artist TEXT NOT NULL,
    album_art_url TEXT,
    audio_url_spotify TEXT,
    audio_url_apple TEXT,
    audio_url_amazon TEXT,
    audio_url_ytube TEXT
);

-- Insert sample data
INSERT INTO tracks (id, title, artist, album_art_url, audio_url_spotify, audio_url_apple, audio_url_amazon, audio_url_ytube) VALUES
('2025-07-20', 'Slicedat_', 'Knxwledge', 'https://i.scdn.co/image/ab67616d0000b27320f5dac1b5c6ddfe2f11c07d', 'https://open.spotify.com/track/6NYjwsMjq0ZTZ0j27tLjz6', 'https://geo.music.apple.com/us/album/_/1500350655?i=1500350659&mt=1&app=music&ls=1&at=1000lHKX&ct=api_http&itscg=30200&itsct=odsl_m', 'https://music.amazon.com/albums/B08546N5BY?trackAsin=B0854BBGRH', 'https://www.youtube.com/watch?v=GUrxmy52TkM');
```

### 5. Set Row Level Security (RLS)
Enable RLS and create a policy to allow public read access:

```sql
-- Enable RLS
ALTER TABLE tracks ENABLE ROW LEVEL SECURITY;

-- Create policy for public read access
CREATE POLICY "Allow public read access" ON tracks
    FOR SELECT USING (true);
```

## Testing the Integration
1. Build and run your iOS app
2. The app should fetch the song for today's date from Supabase
3. If no song is found for today, it will fall back to sample data
4. Check the console for any error messages

## Troubleshooting
- **Build errors**: Make sure the Supabase Swift SDK is properly added to your target
- **Network errors**: Verify your Supabase URL and anon key are correct
- **No data**: Check that your tracks table exists and has data for today's date
- **Permission errors**: Ensure RLS policies allow public read access

## Security Notes
- Never use the service role key in client apps
- Only use the anon key for client-side operations
- The anon key is safe to include in your app as it has limited permissions 