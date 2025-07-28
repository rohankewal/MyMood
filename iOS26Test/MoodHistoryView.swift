//
//  MoodHistoryView.swift
//  iOS26Test
//
//  Created by Rohan Kewalramani on 6/21/25.
//

import SwiftUI

struct MoodHistoryView: View {
    @Binding var moodLogs: [MoodLog]

    var body: some View {
        NavigationView {
            List {
                ForEach(moodLogs) { log in
                    NavigationLink(destination: MoodDetailView(log: log)) {
                        HStack {
                            Text(log.mood.rawValue)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(log.mood.description)
                                    .font(.headline)
                                Text(log.date, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Mood History")
        }
    }

    private func delete(at offsets: IndexSet) {
        moodLogs.remove(atOffsets: offsets)
    }
}
