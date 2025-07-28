//
//  MoodLoggingView.swift
//  iOS26Test
//
//  Created by Rohan Kewalramani on 6/21/25.
//

import SwiftUI

private func moodButton(for mood: Mood, selectedMood: Mood?, selectAction: @escaping () -> Void) -> some View {
    Button(action: selectAction) {
        Text("\(mood.rawValue) \(mood.description)")
            .font(.title2)
            .fontWeight(.medium)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                Group {
                    if selectedMood == mood {
                        Color.accentColor.opacity(0.8)
                    } else {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.thinMaterial)
                    }
                }
            )
            .foregroundColor(selectedMood == mood ? .white : .primary)
            .cornerRadius(20)
            .shadow(color: selectedMood == mood ? .accentColor.opacity(0.4) : .clear, radius: 8)
            .animation(.easeInOut, value: selectedMood)
    }
}

struct MoodLoggingView: View {
    @Binding var moodLogs: [MoodLog]
    @State private var selectedMood: Mood?
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 30) {
                    Text("How are you feeling today?")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding(.top)

                    VStack(spacing: 15) {
                        ForEach(Mood.allCases, id: \.self) { mood in
                            moodButton(for: mood, selectedMood: selectedMood) {
                                self.selectedMood = mood
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            Spacer()

            // The NavigationLink to the ReflectionView, acting as the "Next" button.
            if let selectedMood = selectedMood {
                NavigationLink(destination: ReflectionView(mood: selectedMood, moodLogs: $moodLogs)) {
                    Text("Next")
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
        }
        .navigationTitle("New Log")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // Reset mood selection when view appears
            selectedMood = nil
        }
    }
}

