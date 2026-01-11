//
//  FoodSubstitutionViewModel.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation
import SwiftUI

class FoodSubstitutionViewModel: ObservableObject {
    @Published var substitutions: [SubstitutionSuggestion] = []
    @Published var isLoading: Bool = false
    
    private let dataService = DataService.shared
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func findSubstitutions(for ingredient: Ingredient) {
        isLoading = true
        
        let suggestions = generateSubstitutions(for: ingredient)
        substitutions = suggestions
        isLoading = false
    }
    
    func findSubstitutions(for meal: Meal) {
        isLoading = true
        
        var suggestions: [SubstitutionSuggestion] = []
        
        for ingredient in meal.ingredients {
            let subs = generateSubstitutions(for: ingredient)
            suggestions.append(contentsOf: subs)
        }
        
        substitutions = suggestions
        isLoading = false
    }
    
    private func generateSubstitutions(for ingredient: Ingredient) -> [SubstitutionSuggestion] {
        let substitutionDatabase: [String: [FoodSubstitution]] = [
            "chicken": [
                FoodSubstitution(
                    id: UUID(),
                    originalFood: "Chicken",
                    substitute: "Beans",
                    reason: .tooExpensive,
                    nutritionComparison: NutritionComparison(
                        originalCalories: 165,
                        substituteCalories: 347,
                        originalProtein: 31,
                        substituteProtein: 21,
                        proteinDifference: -32,
                        note: "Beans provide more calories and fiber, slightly less protein but much more affordable"
                    ),
                    costDifference: 1500,
                    availability: .always,
                    instructions: "Use 1.5 cups of cooked beans to replace 100g of chicken. Add spices for flavor."
                ),
                FoodSubstitution(
                    id: UUID(),
                    originalFood: "Chicken",
                    substitute: "Fish",
                    reason: .unavailable,
                    nutritionComparison: NutritionComparison(
                        originalCalories: 165,
                        substituteCalories: 206,
                        originalProtein: 31,
                        substituteProtein: 22,
                        proteinDifference: -29,
                        note: "Fish provides similar protein with omega-3 benefits"
                    ),
                    costDifference: -500,
                    availability: .seasonal,
                    instructions: "Use same quantity of fish. Adjust cooking time as needed."
                )
            ],
            "rice": [
                FoodSubstitution(
                    id: UUID(),
                    originalFood: "Rice",
                    substitute: "Sweet Potatoes",
                    reason: .tooExpensive,
                    nutritionComparison: NutritionComparison(
                        originalCalories: 130,
                        substituteCalories: 86,
                        originalProtein: 2.7,
                        substituteProtein: 1.6,
                        proteinDifference: -41,
                        note: "Sweet potatoes are richer in vitamin A and fiber"
                    ),
                    costDifference: 400,
                    availability: .seasonal,
                    instructions: "Use 1.5x the amount of sweet potatoes. Boil or roast until tender."
                ),
                FoodSubstitution(
                    id: UUID(),
                    originalFood: "Rice",
                    substitute: "Maize",
                    reason: .unavailable,
                    nutritionComparison: NutritionComparison(
                        originalCalories: 130,
                        substituteCalories: 96,
                        originalProtein: 2.7,
                        substituteProtein: 3.4,
                        proteinDifference: 26,
                        note: "Maize provides more protein and is often more affordable"
                    ),
                    costDifference: 200,
                    availability: .always,
                    instructions: "Use same quantity. Prepare as porridge or ugali."
                )
            ],
            "milk": [
                FoodSubstitution(
                    id: UUID(),
                    originalFood: "Milk",
                    substitute: "Yogurt",
                    reason: .preference,
                    nutritionComparison: NutritionComparison(
                        originalCalories: 61,
                        substituteCalories: 59,
                        originalProtein: 3.2,
                        substituteProtein: 10,
                        proteinDifference: 213,
                        note: "Yogurt provides more protein and probiotics"
                    ),
                    costDifference: 0,
                    availability: .always,
                    instructions: "Use same quantity. May need to thin with water for some recipes."
                )
            ]
        ]
        
        let lowerName = ingredient.name.lowercased()
        var foundSubs: [FoodSubstitution] = []
        
        for (key, subs) in substitutionDatabase {
            if lowerName.contains(key) {
                foundSubs = subs
                break
            }
        }
        
        // If no specific substitution found, create generic ones
        if foundSubs.isEmpty {
            foundSubs = createGenericSubstitutions(for: ingredient)
        }
        
        let bestMatch = foundSubs.min { abs($0.costDifference) < abs($1.costDifference) } ?? foundSubs.first!
        
        return [
            SubstitutionSuggestion(
                id: UUID(),
                ingredient: ingredient,
                substitutions: foundSubs,
                bestMatch: bestMatch
            )
        ]
    }
    
    private func createGenericSubstitutions(for ingredient: Ingredient) -> [FoodSubstitution] {
        return [
            FoodSubstitution(
                id: UUID(),
                originalFood: ingredient.name,
                substitute: "Local alternative",
                reason: .unavailable,
                nutritionComparison: NutritionComparison(
                    originalCalories: 100,
                    substituteCalories: 100,
                    originalProtein: 5,
                    substituteProtein: 5,
                    proteinDifference: 0,
                    note: "Look for locally available alternatives with similar nutrition"
                ),
                costDifference: 0,
                availability: .always,
                instructions: "Ask local vendors for similar ingredients available in your area"
            )
        ]
    }
}


