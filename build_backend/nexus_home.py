# nexus/nexus_home.py
from adding_songs.add_single_song import add_song
from adding_songs.add_from_playlist import add_songs
from supabase_files.prune_oldest import delete
from supabase_files.get_upcoming_songs import get_songs
import os

import sys
from colorama import init, Fore, Style

def print_welcome():
    print("\n" + Fore.MAGENTA + Style.BRIGHT + "=" * 50 + Style.RESET_ALL)
    print(Fore.CYAN + Style.BRIGHT + "🎵  THIS IS".center(50) + Style.RESET_ALL)
    print(Fore.YELLOW + Style.BRIGHT + "💿  JAVI'S SONG OF THE DAY".center(50) + Style.RESET_ALL)
    print(Fore.MAGENTA + Style.BRIGHT + "=" * 50 + Style.RESET_ALL)
    print(Fore.GREEN + r"""
__        __   _                            
\ \      / /__| | ___ ___  _ __ ___   ___  
 \ \ /\ / / _ \ |/ __/ _ \| '_ ` _ \ / _ \ 
  \ V  V /  __/ | (_| (_) | | | | | |  __/ 
   \_/\_/ \___|_|\___\___/|_| |_| |_|\___| 
""" + Style.RESET_ALL)
    print("\nAvailable Actions:\n")
    print(Style.BRIGHT + Fore.WHITE + "  1. " + Fore.BLUE + "ADD A NEW SONG MANUALLY" + Style.RESET_ALL)
    print(Style.BRIGHT + Fore.WHITE + "  2. " + Fore.CYAN + "ADD SONGS FROM A FULL SPOTIFY PLAYLIST" + Style.RESET_ALL)
    print(Style.BRIGHT + Fore.WHITE + "  3. " + Fore.RED + "DELETE TODAY’S SONG (OLDEST ENTRY)" + Style.RESET_ALL)
    print(Style.BRIGHT + Fore.WHITE + "  4. " + Fore.YELLOW + "VIEW UPCOMING SONGS IN THE DATABASE" + Style.RESET_ALL)
    print(Style.BRIGHT + Fore.WHITE + "  5. " + Fore.MAGENTA + "EXIT\n" + Style.RESET_ALL)

def main():
    init(autoreset=True)
    while True:
        print_welcome()
        choice = input(Fore.GREEN + Style.BRIGHT + "Enter the number of the action you’d like to perform: " + Style.RESET_ALL).strip()

        if choice == "1":
            add_song()
        elif choice == "2":
            add_songs()
            print(Fore.GREEN + "csv is now present please run cross platform scrip" + Style.RESET_ALL)
        elif choice == "3":
            delete()
        elif choice == "4":
            get_songs()
        elif choice == "5":
            print("\n" + Fore.MAGENTA + "Goodbye! 👋" + Style.RESET_ALL)
            sys.exit(0)
        else:
            print("\n" + Fore.RED + "❌ Invalid choice. Please select a valid option.\n" + Style.RESET_ALL)
            continue

        again = input(Fore.CYAN + Style.BRIGHT + "\nWould you like to perform another action? (y/n): " + Style.RESET_ALL).strip().lower()
        if again not in ("y", "yes"):  # Exit if not yes
            print("\n" + Fore.MAGENTA + "Goodbye! 👋" + Style.RESET_ALL)
            break

if __name__ == "__main__":
    main()
