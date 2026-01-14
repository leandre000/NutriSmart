//
//  ReminderViewModel.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation
import SwiftUI
import UserNotifications

class ReminderViewModel: ObservableObject {
    @Published var reminders: [Reminder] = []
    @Published var habits: [Habit] = []
    @Published var dailyTips: [DailyTip] = []
    
    private let userDefaults = UserDefaults.standard
    private let remindersKey = "savedReminders"
    private let habitsKey = "savedHabits"
    
    init() {
        loadReminders()
        loadHabits()
        loadDailyTips()
        requestNotificationPermission()
    }
    
    func addReminder(_ reminder: Reminder) {
        reminders.append(reminder)
        saveReminders()
        scheduleNotification(for: reminder)
    }
    
    func removeReminder(_ reminder: Reminder) {
        reminders.removeAll { $0.id == reminder.id }
        saveReminders()
        cancelNotification(for: reminder)
    }
    
    func toggleReminder(_ reminder: Reminder) {
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[index].isEnabled.toggle()
            saveReminders()
            if reminders[index].isEnabled {
                scheduleNotification(for: reminders[index])
            } else {
                cancelNotification(for: reminders[index])
            }
        }
    }
    
    func updateHabit(_ habit: Habit, dayIndex: Int, completed: Bool) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            var updated = habit
            if dayIndex < updated.currentWeekProgress.count {
                updated.currentWeekProgress[dayIndex] = completed
                if completed {
                    updated.streak += 1
                }
            }
            habits[index] = updated
            saveHabits()
        }
    }
    
    private func loadReminders() {
        if let data = userDefaults.data(forKey: remindersKey),
           let decoded = try? JSONDecoder().decode([Reminder].self, from: data) {
            reminders = decoded
        } else {
            createDefaultReminders()
        }
    }
    
    private func saveReminders() {
        if let encoded = try? JSONEncoder().encode(reminders) {
            userDefaults.set(encoded, forKey: remindersKey)
        }
    }
    
    private func loadHabits() {
        if let data = userDefaults.data(forKey: habitsKey),
           let decoded = try? JSONDecoder().decode([Habit].self, from: data) {
            habits = decoded
        } else {
            createDefaultHabits()
        }
    }
    
    private func saveHabits() {
        if let encoded = try? JSONEncoder().encode(habits) {
            userDefaults.set(encoded, forKey: habitsKey)
        }
    }
    
    private func createDefaultReminders() {
        let calendar = Calendar.current
        let now = Date()
        
        reminders = [
            Reminder(
                id: UUID(),
                title: "Breakfast Time",
                message: "Don't forget to have a nutritious breakfast!",
                type: .meal,
                isEnabled: true,
                time: calendar.date(bySettingHour: 8, minute: 0, second: 0, of: now) ?? now,
                repeatDays: [1, 2, 3, 4, 5, 6, 7],
                lastTriggered: nil
            ),
            Reminder(
                id: UUID(),
                title: "Drink Water",
                message: "Stay hydrated! Drink a glass of water.",
                type: .water,
                isEnabled: true,
                time: calendar.date(bySettingHour: 10, minute: 0, second: 0, of: now) ?? now,
                repeatDays: [1, 2, 3, 4, 5, 6, 7],
                lastTriggered: nil
            ),
            Reminder(
                id: UUID(),
                title: "Nutrition Tip",
                message: "Today's tip: Include protein in every meal for sustained energy.",
                type: .nutritionTip,
                isEnabled: true,
                time: calendar.date(bySettingHour: 14, minute: 0, second: 0, of: now) ?? now,
                repeatDays: [1, 2, 3, 4, 5, 6, 7],
                lastTriggered: nil
            )
        ]
        saveReminders()
    }
    
    private func createDefaultHabits() {
        habits = [
            Habit(
                id: UUID(),
                name: "Eat Breakfast",
                description: "Start your day with a nutritious meal",
                streak: 0,
                targetDays: 7,
                currentWeekProgress: Array(repeating: false, count: 7),
                icon: "sunrise.fill",
                color: "orange"
            ),
            Habit(
                id: UUID(),
                name: "Drink Water",
                description: "Stay hydrated throughout the day",
                streak: 0,
                targetDays: 7,
                currentWeekProgress: Array(repeating: false, count: 7),
                icon: "drop.fill",
                color: "blue"
            ),
            Habit(
                id: UUID(),
                name: "Eat Vegetables",
                description: "Include vegetables in your meals",
                streak: 0,
                targetDays: 5,
                currentWeekProgress: Array(repeating: false, count: 7),
                icon: "leaf.fill",
                color: "green"
            )
        ]
        saveHabits()
    }
    
    private func loadDailyTips() {
        let dataService = DataService.shared
        dailyTips = dataService.healthTips.map { tip in
            DailyTip(
                id: UUID(),
                title: tip.title,
                content: tip.content,
                category: tip.category,
                date: tip.date,
                isRead: false
            )
        }
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            if granted {
                print("Notification permission granted")
            }
        }
    }
    
    private func scheduleNotification(for reminder: Reminder) {
        guard reminder.isEnabled else { return }
        
        let content = UNMutableNotificationContent()
        content.title = reminder.title
        content.body = reminder.message
        content.sound = .default
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: reminder.time)
        
        var dateComponents = DateComponents()
        dateComponents.hour = components.hour
        dateComponents.minute = components.minute
        
        for day in reminder.repeatDays {
            dateComponents.weekday = day
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(
                identifier: "\(reminder.id.uuidString)-\(day)",
                content: content,
                trigger: trigger
            )
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    private func cancelNotification(for reminder: Reminder) {
        for day in reminder.repeatDays {
            UNUserNotificationCenter.current().removePendingNotificationRequests(
                withIdentifiers: ["\(reminder.id.uuidString)-\(day)"]
            )
        }
    }
}



