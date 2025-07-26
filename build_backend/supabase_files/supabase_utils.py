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
    # Select the row with the smallest ID or oldest timestamp
    result = supabase.table("sotd").select("*").order("id", desc=False).limit(1).execute()
    if result.data:
        row_id = result.data[0]["id"]
        delete_resp = supabase.table("sotd").delete().eq("id", row_id).execute()
        return delete_resp
    return None
