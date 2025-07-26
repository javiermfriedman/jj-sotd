import Foundation
import Supabase

class SupabaseService {
    static let shared = SupabaseService()

    func fetchTopSong(completion: @escaping (Song?) -> Void) {
        Task {
            do {
                let result: [Song] = try await SupabaseManager.shared.client
                    .from("sotd")
                    .select("*, created_at") // <-- Ensure this field is included
                    .order("created_at", ascending: true)
                    .limit(1)
                    .execute()
                    .value

                completion(result.first)
            } catch {
                print("❌ Supabase fetch failed:", error.localizedDescription)
                completion(nil)
            }
        }
    }
}
