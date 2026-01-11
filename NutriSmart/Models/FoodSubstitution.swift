//
//  FoodSubstitution.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation

struct FoodSubstitution: Identifiable {
    let id: UUID
    let originalFood: String
    let substitute: String
    let reason: SubstitutionReason
    let nutritionComparison: NutritionComparison
    let costDifference: Double // positive = cheaper, negative = more expensive
    let availability: Availability
    let instructions: String
    
    enum SubstitutionReason: String, Codable {
        case unavailable = "Unavailable"
        case tooExpensive = "Too Expensive"
        case dietaryRestriction = "Dietary Restriction"
        case preference = "Preference"
        case seasonal = "Seasonal Alternative"
    }
    
    enum Availability: String, Codable {
        case always = "Always Available"
        case seasonal = "Seasonal"
        case rare = "Rare"
    }
}

struct NutritionComparison: Codable {
    let originalCalories: Double
    let substituteCalories: Double
    let originalProtein: Double
    let substituteProtein: Double
    let proteinDifference: Double // percentage
    let note: String
}

struct SubstitutionSuggestion: Identifiable {
    let id: UUID
    let ingredient: Ingredient
    let substitutions: [FoodSubstitution]
    let bestMatch: FoodSubstitution
}


