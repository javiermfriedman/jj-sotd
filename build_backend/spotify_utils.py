import base64
import requests
import os
from dotenv import load_dotenv

load_dotenv()

def get_spotify_access_token():
    client_id = os.getenv("SPOTIFY_CLIENT_ID")
    client_secret = os.getenv("SPOTIFY_CLIENT_SECRET")

    if not client_id or not client_secret:
        print("Missing Spotify credentials. Set SPOTIFY_CLIENT_ID and SPOTIFY_CLIENT_SECRET in .env.")
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
        token = response.json()["access_token"]
        print("Spotify Access Token:")
        print(token)
        return token
    else:
        print("❌ Failed to retrieve token:")
        print(response.text)
        return None
