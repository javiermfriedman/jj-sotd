# prune_oldest.py
from .supabase_utils import delete_first_row

def delete():
    try:
        response = delete_first_row()
        song = response.data[0]["title"]
        print("🧹 Deleted oldest song:", song)
    except Exception:
        print("No songs in playlist.")

if __name__ == "__main__":
    delete()
