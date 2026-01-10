//
//  FamilyNutrition.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation

enum FamilyMode: String, Codable, CaseIterable {
    case individual = "Individual"
    case child = "Child"
    case pregnancy = "Pregnancy"
    case breastfeeding = "Breastfeeding"
    case family = "Family"
    
    var icon: String {
        switch self {
        case .individual: return "person.fill"
        case .child: return "figure.child"
        case .pregnancy: return "heart.fill"
        case .breastfeeding: return "heart.circle.fill"
        case .family: return "person.3.fill"
        }
    }
    
    var description: String {
        switch self {
        case .individual: return "Personal meal planning"
        case .child: return "Child-friendly nutritious meals"
        case .pregnancy: return "Pregnancy nutrition support"
        case .breastfeeding: return "Breastfeeding nutrition needs"
        case .family: return "Family meal planning for all ages"
        }
    }
}

struct ChildProfile: Identifiable, Codable {
    let id: UUID
    var name: String
    var age: Int // in months for infants, years for children
    var gender: Gender
    var specialNeeds: [String]
    var favoriteFoods: [String]
    var allergies: [String]
}

struct PregnancyProfile: Codable {
    var trimester: Int // 1, 2, or 3
    var weeksPregnant: Int
    var hasGestationalDiabetes: Bool
    var hasAnemia: Bool
    var specialRequirements: [String]
}

struct FamilyMealPlan: Identifiable {
    let id: UUID
    let date: Date
    let meals: [FamilyMeal]
    let totalCost: Double
    let servesCount: Int
}

struct FamilyMeal: Identifiable {
    let id: UUID
    let baseMeal: Meal
    let servings: Int
    let childFriendly: Bool
    let pregnancySafe: Bool
    let modifications: [String]
}

