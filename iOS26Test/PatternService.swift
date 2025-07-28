//
//  PatternService.swift
//  iOS26Test
//
//  Created by Rohan Kewalramani on 7/28/25.
//

import Foundation

struct PatternService {
    // Finds the mood that has been logged most frequently.
    static func findMostFrequentMood(from logs: [MoodLog]) -> String? {
        guard !logs.isEmpty else { return nil }
        
        let moodCounts = logs.reduce(into: [:]) { counts, log in
            counts[log.mood, default: 0] += 1
        }
        
        if let mostFrequent = moodCounts.max(by: { $0.value < $1.value }) {
            return "Your most frequently logged mood is **\(mostFrequent.key.description)** \(mostFrequent.key.rawValue)."
        }
        return nil
    }

    // Finds which day of the week the user logs moods most often.
    static func findBusiestDay(from logs: [MoodLog]) -> String? {
        guard logs.count > 5 else { return nil } // Only provide this insight with enough data.

        let calendar = Calendar.current
        let dayCounts = logs.reduce(into: [Int: Int]()) { counts, log in
            let dayOfWeek = calendar.component(.weekday, from: log.date)
            counts[dayOfWeek, default: 0] += 1
        }

        if let busiestDay = dayCounts.max(by: { $0.value < $1.value }) {
            let dayString = calendar.weekdaySymbols[busiestDay.key - 1]
            return "You log your mood most often on **\(dayString)s**."
        }
        return nil
    }
}
