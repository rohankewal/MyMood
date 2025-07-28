//
//  MoodLog.swift
//  iOS26Test
//
//  Created by Rohan Kewalramani on 6/21/25.
//

import Foundation

struct MoodLog: Identifiable, Codable {
    let id: UUID
    let mood: Mood
    let date: Date
    var notes: String

    init(id: UUID = UUID(), mood: Mood, date: Date = Date(), notes: String = "") {
        self.id = id
        self.mood = mood
        self.date = date
        self.notes = notes
    }
}

enum Mood: String, CaseIterable, Codable {
    case happy = "😊"
    case calm = "😌"
    case neutral = "😐"
    case sad = "😢"
    case anxious = "😟"
    case angry = "😠"

    var description: String {
        switch self {
        case .happy: return "Happy"
        case .calm: return "Calm"
        case .neutral: return "Neutral"
        case .sad: return "Sad"
        case .anxious: return "Anxious"
        case .angry: return "Angry"
        }
    }

    // Dynamic prompts for the reflection view
    var reflectionPrompt: String {
        switch self {
        case .happy: return "What was the best part of your day?"
        case .calm: return "What helped you feel at peace today?"
        case .neutral: return "Describe your day in a few words."
        case .sad: return "What's on your mind? It's okay to let it out."
        case .anxious: return "What's causing you to feel anxious?"
        case .angry: return "What triggered this feeling of anger?"
        }
    }
}
