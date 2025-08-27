//
//  ContentView.swift
//  iOS26Test
//
//  Created by Rohan Kewalramani on 6/10/25.
//

import SwiftUI

struct ContentView: View {
    init() {
        NotificationManager.shared.requestAuthorization()
    }
    
    @State private var moodLogs: [MoodLog] = []
    
    // State for the daily quote feature
    @State private var dailyQuote: Quote?
    @State private var showDailyQuoteSplash = false
    
    @State private var showOnboarding = false
    
    var body: some View {
        TabView {
            NavigationView {
                MoodLoggingView(moodLogs: $moodLogs)
            }
            .tabItem {
                Label("Log Mood", systemImage: "plus.circle.fill")
            }
            
            MoodHistoryView(moodLogs: $moodLogs)
                .tabItem {
                    Label("History", systemImage: "list.bullet")
                }
            
            InsightsView(logs: moodLogs)
                .tabItem {
                    Label("Insights", systemImage: "chart.bar.xaxis")
                }
        }
        .onAppear {
            loadData()
            checkForFirstLaunchEver()
            checkForFirstDailyOpen()
        }
        .onDisappear(perform: saveData)
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingView(isPresented: $showOnboarding)
        }
        // Use a full screen cover for a more immersive splash screen effect
        .fullScreenCover(isPresented: $showDailyQuoteSplash) {
            if let quote = dailyQuote {
                DailyQuoteView(quote: quote, isPresented: $showDailyQuoteSplash)
            }
        }
    }
    
    private func checkForFirstLaunchEver() {
        let userDefaults = UserDefaults.standard
        let hasLaunchedBefore = userDefaults.bool(forKey: "hasLaunchedBefore")
        
        if !hasLaunchedBefore {
            // This is the first launch
            showOnboarding = true
            // Set the flag to true so it won't show again
            userDefaults.set(true, forKey: "hasLaunchedBefore")
        }
    }
    
    private func checkForFirstDailyOpen() {
        let userDefaults = UserDefaults.standard
        let lastOpenDate = userDefaults.object(forKey: "lastOpenDate") as? Date
        
        // Check if the app has been opened today
        if let lastOpen = lastOpenDate, Calendar.current.isDateInToday(lastOpen) {
            return // Not the first open of the day
        }
        
        // It's the first open of the day, fetch a new quote
        Task {
            // Find the last mood logged yesterday or earlier
            let lastMood = moodLogs.sorted(by: { $0.date > $1.date }).first?.mood
            self.dailyQuote = await QuoteService.fetchQuote(for: lastMood)
            self.showDailyQuoteSplash = true
        }
        
        // Update the last open date to now
        userDefaults.set(Date(), forKey: "lastOpenDate")
    }
    
    // ... existing loadData() and saveData() functions ...
    private func loadData() {
        if let data = UserDefaults.standard.data(forKey: "moodLogs") {
            if let decoded = try? JSONDecoder().decode([MoodLog].self, from: data) {
                self.moodLogs = decoded
                return
            }
        }
        self.moodLogs = []
    }
    
    private func saveData() {
        if let encoded = try? JSONEncoder().encode(moodLogs) {
            UserDefaults.standard.set(encoded, forKey: "moodLogs")
        }
    }
}
