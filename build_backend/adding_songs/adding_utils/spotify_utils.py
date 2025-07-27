import base64
import requests
import os
import re
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

def get_track_info(track): # from playlist
    """
    Extracts and returns a dictionary of info matching Supabase song schema.
    """
    return {
        "title": track["name"],
        "artist": ", ".join(artist["name"] for artist in track["artists"]),
        "album_art_url": track["album"]["images"][0]["url"] if track["album"]["images"] else "",
        "audio_url_spotify": track["external_urls"]["spotify"],
    }

import requests

def get_track(track_id: str, token: str) -> dict:
    """
    Fetch metadata for a single Spotify track by track ID.

    Parameters:
        track_id (str): The Spotify Track ID
        token (str): Valid OAuth token with 'user-read-private' or appropriate scope

    Returns:
        dict: Track information (title, artist, album_art_url, spotify_url)
    """
    url = f"https://api.spotify.com/v1/tracks/{track_id}"
    headers = {
        "Authorization": f"Bearer {token}"
    }

    response = requests.get(url, headers=headers)

    if response.status_code != 200:
        raise Exception(f"Spotify API error {response.status_code}: {response.text}")

    track = response.json()

    return {
        "title": track["name"],
        "artist": track["artists"][0]["name"],
        "album_art_url": track["album"]["images"][0]["url"] if track["album"]["images"] else None,
        "audio_url_spotify": track["external_urls"]["spotify"]
    }


def extract_track_id(spotify_url: str) -> str | None:
    """
    Extracts the Spotify track ID from a Spotify track URL.
    
    Example:
        https://open.spotify.com/track/0dSIrRkA4PadGll16TgbnV?si=2e01b3e92a094b73
        → "0dSIrRkA4PadGll16TgbnV"

    Returns None if no match is found.
    """
    match = re.search(r"spotify\.com/track/([a-zA-Z0-9]+)", spotify_url)
    return match.group(1) if match else None


def extract_playlist_id(spotify_url: str) -> str | None:
    """
    Extracts the Spotify playlist ID from a Spotify playlist URL.
    
    Example:
        https://open.spotify.com/playlist/6H2PybSzZALVEJga7cgF8N?si=xxxx
        → "6H2PybSzZALVEJga7cgF8N"

    Returns None if no match is found.
    """
    match = re.search(r"spotify\.com/playlist/([a-zA-Z0-9]+)", spotify_url)
    return match.group(1) if match else None
