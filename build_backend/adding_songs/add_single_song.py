# add_song.py
import sys
from supabase_files.supabase_utils import insert_song

def add_song():

    sample_song = {
        "title": "New Track",
        "artist": "Artist Name",
        "album_art_url": "https://example.com/art.jpg",
        "audio_url_spotify": "https://spotify.com/example",
        "audio_url_apple": "https://music.apple.com/example",
        "audio_url_amazon": "https://music.amazon.com/example",
        "audio_url_ytube": "https://youtube.com/example"
    }

    response = insert_song(sample_song)
    print("✅ Inserted song:", response)
