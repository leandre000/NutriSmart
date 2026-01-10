//
//  DataService.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation

class DataService: ObservableObject {
    static let shared = DataService()
    
    @Published var meals: [Meal] = []
    @Published var nutritionists: [Nutritionist] = []
    @Published var communityMeals: [CommunityMeal] = []
    @Published var healthTips: [HealthTip] = []
    
    private init() {
        loadData()
    }
    
    func loadData() {
        meals = loadMeals()
        nutritionists = loadNutritionists()
        communityMeals = loadCommunityMeals()
        healthTips = loadHealthTips()
    }
    
    func getMeals(for country: Country, category: MealCategory? = nil, healthGoal: HealthGoal? = nil) -> [Meal] {
        var filtered = meals.filter { $0.countryId == country.id }
        
        if let category = category {
            filtered = filtered.filter { $0.category == category }
        }
        
        if let healthGoal = healthGoal {
            filtered = filtered.filter { $0.suitableFor.contains(healthGoal) }
        }
        
        return filtered
    }
    
    func getMealsWithinBudget(_ budget: Double, for country: Country, category: MealCategory? = nil) -> [Meal] {
        let available = getMeals(for: country, category: category)
        return available.filter { $0.estimatedCost <= budget }
    }
    
    func getBudgetAlerts(for meals: [Meal], dailyBudget: Double) -> [BudgetAlert] {
        let totalCost = meals.reduce(0) { $0 + $1.estimatedCost }
        var alerts: [BudgetAlert] = []
        
        if totalCost > dailyBudget * 1.1 {
            alerts.append(BudgetAlert(
                id: UUID(),
                type: .exceeded,
                message: "Daily meal cost exceeds budget by \(String(format: "%.2f", totalCost - dailyBudget))",
                suggestedAlternatives: []
            ))
        } else if totalCost > dailyBudget {
            alerts.append(BudgetAlert(
                id: UUID(),
                type: .warning,
                message: "Daily meal cost is close to budget limit",
                suggestedAlternatives: []
            ))
        }
        
        return alerts
    }
    
    private func loadMeals() -> [Meal] {
        guard let url = Bundle.main.url(forResource: "meals", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let meals = try? JSONDecoder().decode([Meal].self, from: data) else {
            return []
        }
        return meals
    }
    
    private func loadNutritionists() -> [Nutritionist] {
        guard let url = Bundle.main.url(forResource: "nutritionists", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let nutritionists = try? JSONDecoder().decode([Nutritionist].self, from: data) else {
            return []
        }
        return nutritionists
    }
    
    private func loadCommunityMeals() -> [CommunityMeal] {
        guard let url = Bundle.main.url(forResource: "community_meals", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let meals = try? JSONDecoder().decode([CommunityMeal].self, from: data) else {
            return []
        }
        return meals
    }
    
    private func loadHealthTips() -> [HealthTip] {
        guard let url = Bundle.main.url(forResource: "health_tips", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let tips = try? JSONDecoder().decode([HealthTip].self, from: data) else {
            return []
        }
        return tips
    }
}

