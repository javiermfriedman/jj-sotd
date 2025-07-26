# prune_oldest.py
from supabase_files.supabase_utils import delete_first_row

def delete():
    response = delete_first_row()
    print("🧹 Deleted oldest song:", response)
