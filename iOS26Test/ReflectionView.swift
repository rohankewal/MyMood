//
//  ReflectionView.swift
//  iOS26Test
//
//  Created by Rohan Kewalramani on 7/1/25.
//


import SwiftUI

struct ReflectionView: View {
    let mood: Mood
    @Binding var moodLogs: [MoodLog]
    
    @State private var notes: String = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        // ... The body of this view remains unchanged ...
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(mood.rawValue)
                            .font(.system(size: 60))
                        Text("Add a Reflection")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    VStack(alignment: .leading) {
                        Text(mood.reflectionPrompt)
                            .font(.headline)
                            .foregroundColor(.secondary)
                        TextEditor(text: $notes)
                            .frame(height: 150)
                            .padding(10)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(15)
                    }
                }
                .padding()
            }
            Spacer()
            Button(action: saveLog) {
                Text("Save Log")
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .padding()
        }
        .navigationTitle("Your \(mood.description) Mood")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func saveLog() {
        let newLog = MoodLog(mood: mood, notes: notes)
        moodLogs.append(newLog)
        
        // Schedule the notification for tomorrow morning based on today's mood
        NotificationManager.shared.scheduleDailyQuoteNotification(basedOn: mood)
        
        dismiss()
    }
}
