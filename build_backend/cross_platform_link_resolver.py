"""
get music links from songlink api and update csv
"""

import requests
import urllib.parse
import os
import pandas as pd


def get_music_links(spotify_url):
    encoded_url = urllib.parse.quote(spotify_url)
    api_url = f"https://api.song.link/v1-alpha.1/links?url={encoded_url}&userCountry=US&songIfSingle=true"
    response = requests.get(api_url)

    if response.status_code == 200:
        data = response.json()
        platforms = data.get("linksByPlatform", {})
        return {
            "appleMusic": platforms.get("appleMusic", {}).get("url"),
            "youtube": platforms.get("youtube", {}).get("url"),
            "amazonMusic": platforms.get("amazonMusic", {}).get("url")
        }
    else:
        return {"error": f"API call failed: {response.status_code}"}


if __name__ == "__main__":
    # read csv
    path = os.path.dirname(os.path.abspath(__file__))
    df = pd.read_csv(os.path.join(path, "tracks.csv"))

    
    #iterate over df and get music links
    keep_going = True
    for index, row in df.iterrows():
        if not keep_going:
            print("Stopping iteration")
            break
        # try to get music links

        track_url = row["audio_url_spotify"]
        print(f"Getting music links for {track_url}")
        try:
            links = get_music_links(track_url)
            print(f"Links: {links}")
        except Exception as e:
            print(f"Error getting music links for {track_url}: {e}")
            keep_going = False

        print(f"Updating row {index}")
        df.at[index, "audio_url_apple"] = links["appleMusic"]
        df.at[index, "audio_url_ytube"] = links["youtube"]
        df.at[index, "audio_url_amazon"] = links["amazonMusic"]

        print(df.loc[index])

    print("Saving updated CSV")
    df.to_csv("tracks.csv", index=False)

