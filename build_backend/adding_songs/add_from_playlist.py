"""
get spotify data from playlist
get other links using get music links
add to suabse backend using insert song
"""

from .adding_utils.spotify_utils import get_spotify_access_token,get_track_info, get_playlist_tracks
from .adding_utils.cross_platform_link_resolver import get_music_links
from supabase_files.supabase_utils import insert_song
from datetime import datetime, timedelta

import pandas as pd


def add_songs(playlist_id = "6H2PybSzZALVEJga7cgF8N"):
    token = get_spotify_access_token()
        # playlist_id = input("Enter the Spotify playlist ID: ").strip()

    songs = []
    try:
        print(f"🎧 Fetching tracks from playlist: {playlist_id}")
        # print(f"🎧 Using token: {token}")

        tracks = get_playlist_tracks(playlist_id, token)

        for i, track in enumerate(tracks, 1):
            info = get_track_info(track)

            sportify_link = info["audio_url_spotify"]

            other_links = get_music_links(sportify_link)

            info["audio_url_apple"] = other_links["appleMusic"]
            info["audio_url_ytube"] = other_links["youtube"]
            info["audio_url_amazon"] = other_links["amazonMusic"]


            print(f"\ninserting {info["title"]}")
            insert_song(info)

            songs.append(info)
    except Exception as e:
        print(f"❌ Error fetching tracks: {e}")
        return

    get_csv = input("would you like to save as a csv also?[y/n]")
    if get_csv == 'y':
        df = pd.DataFrame(songs)
        df.to_csv("tracks.csv", index=False)

