import base64
import requests
import os
from dotenv import load_dotenv

load_dotenv()

def get_spotify_access_token():
    client_id = os.getenv("SPOTIFY_CLIENT_ID")
    client_secret = os.getenv("SPOTIFY_CLIENT_SECRET")

    if not client_id or not client_secret:
        print("❌ Missing credentials.")
        return None

    auth_string = f"{client_id}:{client_secret}"
    b64_auth = base64.b64encode(auth_string.encode()).decode()

    headers = {
        "Authorization": f"Basic {b64_auth}",
        "Content-Type": "application/x-www-form-urlencoded"
    }

    data = {"grant_type": "client_credentials"}

    response = requests.post("https://accounts.spotify.com/api/token", headers=headers, data=data)

    if response.status_code == 200:
        return response.json()["access_token"]
    else:
        print("❌ Failed to retrieve token:")
        print(response.text)
        return None


def get_playlist_tracks(playlist_id, token):
    """
    Returns a list of track objects from the Spotify playlist.
    """
    headers = {
        "Authorization": f"Bearer {token}"
    }

    tracks = []
    url = f"https://api.spotify.com/v1/playlists/{playlist_id}/tracks"
    
    while url:
        response = requests.get(url, headers=headers)
        if response.status_code != 200:
            print("❌ Failed to fetch playlist tracks:", response.text)
            return []

        data = response.json()
        tracks.extend(item["track"] for item in data["items"] if item["track"] is not None)
        url = data.get("next")  # handle pagination

    print(f"✅ Retrieved {len(tracks)} tracks from playlist.")
    return tracks


def get_track_info(track):
    """
    Extracts and returns a dictionary of info matching Supabase song schema.
    """
    return {
        "title": track["name"],
        "artist": ", ".join(artist["name"] for artist in track["artists"]),
        "album_art_url": track["album"]["images"][0]["url"] if track["album"]["images"] else "",
        "audio_url_spotify": track["external_urls"]["spotify"],
    }
