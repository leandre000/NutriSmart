//
//  Meal.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation

struct Meal: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
    let category: MealCategory
    let countryId: String
    let imageName: String
    let ingredients: [Ingredient]
    let preparationSteps: [String]
    let nutrition: NutritionInfo
    let estimatedCost: Double
    let healthBenefits: [String]
    let suitableFor: [HealthGoal]
    let prepTime: Int // in minutes
    let servings: Int
    
    var formattedCost: String {
        String(format: "%.2f", estimatedCost)
    }
}

enum MealCategory: String, Codable, CaseIterable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snack = "Snack"
    
    var icon: String {
        switch self {
        case .breakfast:
            return "sunrise.fill"
        case .lunch:
            return "sun.max.fill"
        case .dinner:
            return "moon.stars.fill"
        case .snack:
            return "leaf.fill"
        }
    }
}

struct Ingredient: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let quantity: String
    let unit: String
}

struct NutritionInfo: Codable, Hashable {
    let calories: Double
    let protein: Double // in grams
    let carbohydrates: Double // in grams
    let fats: Double // in grams
    let fiber: Double // in grams
    let iron: Double // in mg
    let calcium: Double // in mg
    let vitaminC: Double // in mg
    let vitaminA: Double // in IU
    
    var proteinPercentage: Double {
        (protein * 4) / calories * 100
    }
    
    var carbsPercentage: Double {
        (carbohydrates * 4) / calories * 100
    }
    
    var fatsPercentage: Double {
        (fats * 9) / calories * 100
    }
}

struct MealPlan: Codable, Identifiable {
    let id: String
    let date: Date
    let meals: [Meal]
    let totalNutrition: NutritionInfo
    let totalCost: Double
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

