//
//  NotificationManager.swift
//  iOS26Test
//
//  Created by Rohan Kewalramani on 7/18/25.
//

import UserNotifications

class NotificationManager {
    static let shared = NotificationManager() // Singleton for easy access
    
    // Request permission from the user to send notifications
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    // Schedules the quote notification for the next morning
    func scheduleDailyQuoteNotification(basedOn lastMood: Mood?) {
        // First, fetch a quote tailored to the user's last mood
        Task {
            guard let quote = await QuoteService.fetchQuote(for: lastMood) else { return }
            
            let content = UNMutableNotificationContent()
            content.title = "Your Daily Dose of Positivity ✨"
            content.body = "\"\(quote.content)\" — \(quote.author)"
            content.sound = .default
            
            // Configure the trigger for 8:00 AM daily
            var dateComponents = DateComponents()
            dateComponents.hour = 8
            dateComponents.minute = 0
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            // Create and add the request
            let request = UNNotificationRequest(identifier: "dailyQuoteNotification", content: content, trigger: trigger)
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests() // Remove old one
            do {
                try await UNUserNotificationCenter.current().add(request) // Add the new one
                print("Scheduled daily notification with quote: \(quote.content)")
            } catch {
                print("Failed to schedule notification: \(error)")
            }
        }
    }
}

