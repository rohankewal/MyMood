//
//  OnboardingView.swift
//  iOS26Test
//
//  Created by Rohan Kewalramani on 8/27/25.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            // A welcoming gradient background
            LinearGradient(
                gradient: Gradient(colors: [.purple.opacity(0.6), .accentColor.opacity(0.8)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                Spacer()
                
                // App Icon/Logo
                Image(systemName: "sparkles")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                
                // Welcome Text
                Text("Welcome to Aura")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Your personal space for reflection and growth.")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                
                Spacer()

                // Feature Highlights
                VStack(alignment: .leading, spacing: 25) {
                    FeatureRow(icon: "pencil.and.scribble", title: "Log Your Mood", description: "Quickly capture your feelings and reflect on your day.")
                    FeatureRow(icon: "chart.pie", title: "Discover Patterns", description: "Visualize your emotional trends and gain powerful insights.")
                    FeatureRow(icon: "quote.bubble", title: "Stay Inspired", description: "Start each day with a personalized, positive quote.")
                }
                
                Spacer()
                
                // Continue Button
                Button(action: {
                    isPresented = false
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .foregroundColor(.accentColor)
                        .cornerRadius(15)
                }
            }
            .padding(30)
        }
    }
}

// A helper view for styling feature rows
struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 50)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(description)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
    }
}
