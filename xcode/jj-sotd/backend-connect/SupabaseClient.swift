//
//  SupabaseClient.swift
//  jj-sotd
//
//  Created by Javier Friedman on 7/26/25.
//

import Foundation
import Supabase

class SupabaseManager {
    static let shared = SupabaseManager()

    let client: SupabaseClient

    private init() {
        self.client = SupabaseClient(
            supabaseURL: URL(string: "https://hvedfnwndphpbzjudekv.supabase.co")!,
            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh2ZWRmbnduZHBocGJ6anVkZWt2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMwMzMxOTgsImV4cCI6MjA2ODYwOTE5OH0.2CrkINZpxuWedybp4tMap3yS2tdUpWVW-rEJsKv-SUk"
        )
    }
}
