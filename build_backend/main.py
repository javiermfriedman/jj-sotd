from spotify_utils import get_spotify_access_token

def main():
    while True:
        print("\n🎵 What do you want to do?")
        print("1) Generate Spotify Token")
        print("2) Exit")

        choice = input("Enter your choice (1/2): ").strip()

        if choice == "1":
            get_spotify_access_token()
        elif choice == "2":
            print("👋 Goodbye!")
            break
        else:
            print("⚠️ Invalid choice. Try again.")

if __name__ == "__main__":
    main()
