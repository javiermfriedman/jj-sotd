# prune_oldest.py
from .supabase_utils import delete_first_row

def delete():
    response = delete_first_row()
    print("🧹 Deleted oldest song:", response)

if __name__ == "__main__":
    delete()
