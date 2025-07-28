//
//  MoodDetailView.swift
//  iOS26Test
//
//  Created by Rohan Kewalramani on 6/21/25.
//

import SwiftUI

struct MoodDetailView: View {
    let log: MoodLog

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                // Header
                HStack(spacing: 15) {
                    Text(log.mood.rawValue)
                        .font(.system(size: 80))
                    VStack(alignment: .leading) {
                        Text(log.mood.description)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text(log.date, formatter: itemFormatter)
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                }
                
                // Display Notes if they exist
                if !log.notes.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Your Reflection:")
                            .font(.headline)
                        Text(log.notes)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.thinMaterial)
                            .cornerRadius(15)
                    }
                } else {
                    // Show a message if no notes were added
                    VStack {
                        Spacer(minLength: 20)
                        Text("No reflection was added for this entry.")
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Log Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var itemFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }
}
