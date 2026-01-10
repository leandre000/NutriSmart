//
//  Reminder.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation

struct Reminder: Identifiable, Codable {
    let id: UUID
    var title: String
    var message: String
    var type: ReminderType
    var isEnabled: Bool
    var time: Date
    var repeatDays: [Int] // 1-7, Sunday = 1
    var lastTriggered: Date?
    
    enum ReminderType: String, Codable {
        case meal = "Meal"
        case water = "Water"
        case nutritionTip = "Nutrition Tip"
        case medication = "Medication"
        case exercise = "Exercise"
        
        var icon: String {
            switch self {
            case .meal: return "fork.knife"
            case .water: return "drop.fill"
            case .nutritionTip: return "lightbulb.fill"
            case .medication: return "pills.fill"
            case .exercise: return "figure.walk"
            }
        }
        
        var color: String {
            switch self {
            case .meal: return "orange"
            case .water: return "blue"
            case .nutritionTip: return "yellow"
            case .medication: return "red"
            case .exercise: return "green"
            }
        }
    }
}

struct Habit: Identifiable, Codable {
    let id: UUID
    var name: String
    var description: String
    var streak: Int
    var targetDays: Int
    var currentWeekProgress: [Bool] // 7 days
    var icon: String
    var color: String
}

struct DailyTip: Identifiable {
    let id: UUID
    let title: String
    let content: String
    let category: String
    let date: Date
    let isRead: Bool
}

