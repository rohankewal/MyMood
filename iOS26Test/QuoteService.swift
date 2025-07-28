//
//  QuoteService.swift
//  iOS26Test
//
//  Created by Rohan Kewalramani on 7/18/25.
//

import Foundation

// Decodable struct to match the JSON response from the API
struct Quote: Codable, Identifiable {
    var id: String { _id }
    let _id: String
    let content: String
    let author: String
}

class QuoteService {
    // Fetches a quote, tailoring the theme to the provided mood
    static func fetchQuote(for mood: Mood?) async -> Quote? {
        let tag = tag(for: mood)
        let urlString = "https://api.quotable.io/quotes/random?limit=1&tags=\(tag)"
        
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            // The API returns an array, so we decode as [Quote] and take the first one
            let quotes = try JSONDecoder().decode([Quote].self, from: data)
            return quotes.first
        } catch {
            print("Failed to fetch or decode quote: \(error)")
            // Fallback to a default quote if the API fails
            return Quote(_id: "fallback", content: "The best way to get started is to quit talking and begin doing.", author: "Walt Disney")
        }
    }
    
    // Determines the best quote theme based on mood
    private static func tag(for mood: Mood?) -> String {
        guard let mood = mood else { return "inspirational" }
        
        switch mood {
        case .happy, .calm:
            return "happiness|success|wisdom"
        case .sad, .anxious:
            return "hope|courage|change"
        case .angry:
            return "patience|perseverance"
        case .neutral:
            return "life|motivation"
        }
    }
}
