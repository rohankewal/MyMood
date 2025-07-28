//
//  DailyQuoteView.swift
//  iOS26Test
//
//  Created by Rohan Kewalramani on 7/22/25.
//

import SwiftUI

struct DailyQuoteView: View {
    let quote: Quote
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            // A nice gradient background
            LinearGradient(
                gradient: Gradient(colors: [Color.accentColor.opacity(0.6), .purple.opacity(0.6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Quote of the Day")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                VStack(alignment: .center, spacing: 20) {
                    Text("\"\(quote.content)\"")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Text("— \(quote.author)")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal)
                }
                .padding()
                .background(.regularMaterial)
                .cornerRadius(20)
                .shadow(radius: 10)
                
                Button(action: {
                    isPresented = false
                }) {
                    Text("Continue")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .foregroundColor(.accentColor)
                        .cornerRadius(15)
                }
            }
            .padding()
        }
    }
}
