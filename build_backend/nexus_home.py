# nexus/nexus_home.py
from adding_songs.add_single_song import add_song
from adding_songs.add_from_playlist import add_songs
from prune_oldest import delete
from supabase_files.get_upcoming_songs import get_songs
import os

import sys

def print_welcome():
    print("\n" + "=" * 50)
    print("🎵  WELCOME TO".center(50))
    print("💿  JAVI'S SONG OF THE DAY".center(50))
    print("=" * 50)
    print("\nAvailable Actions:\n")
    print("  1️⃣  Add a new song manually")
    print("  2️⃣  Add songs from a full Spotify playlist")
    print("  3️⃣  Delete today’s song (oldest entry)")
    print("  4️⃣  View upcoming songs in the database")
    print("  5️⃣  Exit\n")

def main():
    while True:
        print_welcome()
        choice = input("Enter the number of the action you’d like to perform: ").strip()

        if choice == "1":
            add_song()
        elif choice == "2":
            id = input("give playlist id[press enter for default]: ")
            if id == "":
                add_songs()
            else:
                add_songs(input)
            print("csv is now present please run cross platform scrip")
        elif choice == "3":
            delete()
        elif choice == "4":
            get_songs()
        elif choice == "5":
            print("\nGoodbye! 👋")
            sys.exit(0)
        else:
            print("\n❌ Invalid choice. Please select a valid option.\n")

if __name__ == "__main__":
    main()
