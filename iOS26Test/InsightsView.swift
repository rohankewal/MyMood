//
//  InsightsView.swift
//  iOS26Test
//
//  Created by Rohan Kewalramani on 7/28/25.
//

import SwiftUI
import Charts

// A helper struct to hold aggregated chart data
struct MoodCount: Identifiable {
    var id: String { mood.rawValue }
    let mood: Mood
    let count: Int
}

struct InsightsView: View {
    let logs: [MoodLog]

    // Processed data for the charts
    private var moodCounts: [MoodCount] {
        // Using a dictionary to count occurrences of each mood
        let counts = logs.reduce(into: [:]) { acc, log in
            acc[log.mood, default: 0] += 1
        }
        // Map the dictionary to an array of MoodCount for the chart
        return counts.map { MoodCount(mood: $0.key, count: $0.value) }
            .sorted { $0.count > $1.count }
    }

    var body: some View {
        NavigationView {
            if logs.isEmpty {
                VStack {
                    Image(systemName: "chart.bar.xaxis.ascending")
                        .font(.system(size: 60))
                        .foregroundColor(.secondary)
                    Text("Not Enough Data")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Log your moods for a few days to see your insights here.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .navigationTitle("Insights")
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 30) {
                        // 1. AI-Powered Patterns Section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Your Patterns")
                                .font(.title2).bold()
                            
                            if let frequentMood = PatternService.findMostFrequentMood(from: logs),
                               let attrString = try? AttributedString(markdown: frequentMood) {
                                InsightCardView(text: attrString, iconName: "brain.head.profile", color: .purple)
                            }
                            if let busiestDay = PatternService.findBusiestDay(from: logs),
                               let attrString = try? AttributedString(markdown: busiestDay) {
                                InsightCardView(text: attrString, iconName: "calendar", color: .blue)
                            }
                        }
                        
                        // 2. Data Visualization Section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("All-Time Mood Frequency")
                                .font(.title2).bold()

                            Chart(moodCounts) { moodCount in
                                BarMark(
                                    x: .value("Count", moodCount.count),
                                    y: .value("Mood", "\(moodCount.mood.rawValue) \(moodCount.mood.description)")
                                )
                                .foregroundStyle(by: .value("Mood", moodCount.mood.description))
                                .annotation(position: .trailing) {
                                    Text("\(moodCount.count)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .chartLegend(.hidden)
                            .chartYAxis {
                                AxisMarks(position: .leading)
                            }
                            .frame(height: 250)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Insights")
            }
        }
    }
}

// A helper view for styling the insight cards
struct InsightCardView: View {
    let text: AttributedString
    let iconName: String
    let color: Color

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .font(.title)
                .foregroundColor(color)
                .padding()
                .background(color.opacity(0.1))
                .clipShape(Circle())
            
            Text(text)
                .font(.headline)
            
            Spacer()
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(15)
    }
}
