//
//  SupabaseService.swift
//  jj-sotd
//
//  Created by Javier Friedman on 7/26/25.
//

import Foundation
import Supabase

class SupabaseService {
    static let shared = SupabaseService()
    
    func fetchTopSong(completion: @escaping (Song?) -> Void) {
        Task {
            do {
                let result: [Song] = try await SupabaseManager.shared.client
                    .from("sotd")
                    .select()
                    .limit(1)
                    .execute()
                    .value


                completion(result.first)
            } catch {
                print("❌ Supabase fetch failed:", error)
                completion(nil)
            }
        }
    }
}
