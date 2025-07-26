from .supabase_utils import get_upcoming_songs

def get_songs():
    songs = get_upcoming_songs()
    if songs:
        for i, song in enumerate(songs, 1):
            print(f"{i}. {song.get('title')} – {song.get('artist')}")
