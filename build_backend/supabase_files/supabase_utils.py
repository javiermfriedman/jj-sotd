# supabase_utils.py
import os
from supabase import create_client, Client
from dotenv import load_dotenv

load_dotenv()

SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_SERVICE_ROLE_KEY")

supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

def insert_song(song: dict):
    response = supabase.table("sotd").insert(song).execute()
    return response

def delete_first_row():
    # Select the row with the oldest timestamp
    result = supabase.table("sotd").select("*").order("created_at", desc=False).limit(1).execute()
    if result.data:
        # Use created_at as the identifier for deletion
        created_at = result.data[0]["created_at"]
        delete_resp = supabase.table("sotd").delete().eq("created_at", created_at).execute()
        return delete_resp
    return None

def get_upcoming_songs(limit: int = 7):
    try:
        # Query the `sotd` table, sorted by creation timestamp
        response = supabase.table("sotd") \
            .select("*") \
            .order("created_at", desc=False) \
            .limit(limit) \
            .execute()

        if not response.data:
            print("⚠️ No songs found in the database.")
            return []

        upcoming_songs = response.data
        print(f"✅ Fetched {len(upcoming_songs)} song(s):")
        return upcoming_songs

    except Exception as e:
        print("❌ Error retrieving upcoming songs:", e)
        return []
