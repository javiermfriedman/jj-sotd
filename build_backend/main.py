"""
get spotify data and save to csv
"""

from spotify_utils import get_spotify_access_token,get_track_info, get_playlist_tracks
from datetime import datetime, timedelta

import pandas as pd


def main():
    date = datetime.now()
    token = get_spotify_access_token()
    playlist_id =  "6H2PybSzZALVEJga7cgF8N"
        # playlist_id = input("Enter the Spotify playlist ID: ").strip()

    songs = []
    try:
        print(f"🎧 Fetching tracks from playlist: {playlist_id}")
        print(f"🎧 Using token: {token}")

        tracks = get_playlist_tracks(playlist_id, token)

        for i, track in enumerate(tracks, 1):
            info = get_track_info(track)
            info["id"] = date.strftime("%Y-%m-%d")
            info["audio_url_apple"] = ""
            info["audio_url_ytube"] = ""
            info["audio_url_amazon"] = ""


            print(f"\n🔹 Track {i}:")
            print(info)



            songs.append(info)
            date += timedelta(days=1) # increment date by 1 day

    except Exception as e:
        print(f"❌ Error fetching tracks: {e}")
        return

    df = pd.DataFrame(songs)
    df.to_csv("tracks.csv", index=False)
    





if __name__ == "__main__":
    main()
