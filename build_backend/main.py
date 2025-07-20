from spotify_utils import get_spotify_access_token
from spotify_utils import get_playlist_tracks
from spotify_utils import get_track_info
from datetime import datetime
from datetime import timedelta

import pandas as pd


def main():
    date = datetime.now()
    token = get_spotify_access_token()
    playlist_id =  "6H2PybSzZALVEJga7cgF8N"
        # playlist_id = input("Enter the Spotify playlist ID: ").strip()

    try:
        print(f"🎧 Fetching tracks from playlist: {playlist_id}")
        print(f"🎧 Using token: {token}")

        tracks = get_playlist_tracks(playlist_id, token)

        for i, track in enumerate(tracks, 1):
            info = get_track_info(track)
            info["id"] = date.strftime("%Y-%m-%d")
            print(f"\n🔹 Track {i}:")
            print(info)
            date += timedelta(days=1) # increment date by 1 day
    except Exception as e:
        print(f"❌ Error fetching tracks: {e}")
        return

    df = pd.DataFrame(tracks)
    df.to_csv("tracks.csv", index=False)
    





if __name__ == "__main__":
    main()
