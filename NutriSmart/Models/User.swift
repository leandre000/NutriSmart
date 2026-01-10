//
//  User.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    var age: Int
    var gender: Gender
    var country: Country
    var monthlyBudget: Double
    var healthGoal: HealthGoal
    
    var weeklyBudget: Double {
        monthlyBudget / 4.33
    }
    
    var dailyBudget: Double {
        weeklyBudget / 7
    }
}

enum Gender: String, Codable, CaseIterable {
    case male = "Male"
    case female = "Female"
    case other = "Other"
    case preferNotToSay = "Prefer not to say"
}

enum HealthGoal: String, Codable, CaseIterable {
    case healthyLiving = "Healthy Living"
    case weightGain = "Weight Gain"
    case weightLoss = "Weight Loss"
    case anemiaPrevention = "Anemia Prevention"
    case diabetesFriendly = "Diabetes-Friendly"
    
    var description: String {
        switch self {
        case .healthyLiving:
            return "Maintain a balanced diet for overall wellness"
        case .weightGain:
            return "Increase calorie intake with nutrient-dense foods"
        case .weightLoss:
            return "Reduce calories while maintaining nutrition"
        case .anemiaPrevention:
            return "Focus on iron-rich foods and vitamin C"
        case .diabetesFriendly:
            return "Manage blood sugar with low-GI foods"
        }
    }
    
    var icon: String {
        switch self {
        case .healthyLiving:
            return "heart.fill"
        case .weightGain:
            return "arrow.up.circle.fill"
        case .weightLoss:
            return "arrow.down.circle.fill"
        case .anemiaPrevention:
            return "drop.fill"
        case .diabetesFriendly:
            return "cross.case.fill"
        }
    }
}

