# add_song.py

from supabase_files.supabase_utils import insert_song
from .adding_utils.spotify_utils import get_track, get_spotify_access_token, extract_track_id
from .adding_utils.cross_platform_link_resolver import get_music_links

def add_song():
    track_id = input("please give track id: ")
    track_id = extract_track_id(track_id)
    print(f"🔧 Extracted track_id: {track_id}")
    token = get_spotify_access_token()
    
    try:
        # print(f"🎧 Using token: {token}")
        print("🎵 Fetching track info from Spotify...")
        track = get_track(track_id, token)
        
        sportify_link = track["audio_url_spotify"]
        other_links = get_music_links(sportify_link)
        
        track["audio_url_apple"] = other_links["appleMusic"]
        track["audio_url_ytube"] = other_links["youtube"]
        track["audio_url_amazon"] = other_links["amazonMusic"]

        response = insert_song(track)
        song = response.data[0]["title"]
        print("✅ Inserted song:", song)

     
    except Exception as e:
        print(f"❌ Error fetching tracks: {e}")
        print(f"🔍 Error type: {type(e).__name__}")
        import traceback
        print(f"📋 Full traceback: {traceback.format_exc()}")
        return
