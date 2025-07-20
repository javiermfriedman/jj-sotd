import Foundation
import Supabase

class SupabaseManager {
    static let shared = SupabaseManager()
    
    let supabase: SupabaseClient
    
    private init() {
        guard let supabaseURL = URL(string: Config.supabaseURL) else {
            fatalError("Invalid Supabase URL in Config.swift")
        }
        
        supabase = SupabaseClient(
            supabaseURL: supabaseURL,
            supabaseKey: Config.supabaseAnonKey
        )
    }
} 
