//
//  MealDetailViewModel.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation
import SwiftUI

class MealDetailViewModel: ObservableObject {
    @Published var meal: Meal
    @Published var isFavorite: Bool = false
    @Published var similarMeals: [Meal] = []
    
    private let dataService = DataService.shared
    private let user: User
    
    init(meal: Meal, user: User) {
        self.meal = meal
        self.user = user
        loadSimilarMeals()
    }
    
    private func loadSimilarMeals() {
        let allMeals = dataService.getMeals(for: user.country, category: meal.category)
        similarMeals = Array(allMeals.filter { $0.id != meal.id }.prefix(3))
    }
    
    func toggleFavorite() {
        isFavorite.toggle()
        // In a real app, this would save to UserDefaults or a database
    }
    
    func getNutritionPercentage(for macro: MacroType) -> Double {
        switch macro {
        case .protein:
            return meal.nutrition.proteinPercentage
        case .carbs:
            return meal.nutrition.carbsPercentage
        case .fats:
            return meal.nutrition.fatsPercentage
        }
    }
}

enum MacroType {
    case protein
    case carbs
    case fats
}

