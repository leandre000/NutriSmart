//
//  MealPlanViewModel.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation
import SwiftUI

class MealPlanViewModel: ObservableObject {
    @Published var weeklyPlan: [MealPlan] = []
    @Published var selectedDate: Date = Date()
    @Published var budgetAlerts: [BudgetAlert] = []
    @Published var isLoading: Bool = false
    
    private let dataService = DataService.shared
    private var user: User
    
    init(user: User) {
        self.user = user
        generateWeeklyPlan()
    }
    
    func updateUser(_ newUser: User) {
        self.user = newUser
        generateWeeklyPlan()
    }
    
    func generateWeeklyPlan() {
        isLoading = true
        
        var plans: [MealPlan] = []
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        for dayOffset in 0..<7 {
            guard let date = calendar.date(byAdding: .day, value: dayOffset, to: today) else { continue }
            
            let breakfast = selectMeal(for: .breakfast, date: date)
            let lunch = selectMeal(for: .lunch, date: date)
            let dinner = selectMeal(for: .dinner, date: date)
            
            let dayMeals = [breakfast, lunch, dinner].compactMap { $0 }
            
            let totalNutrition = calculateTotalNutrition(for: dayMeals)
            let totalCost = dayMeals.reduce(0) { $0 + $1.estimatedCost }
            
            let plan = MealPlan(
                id: UUID().uuidString,
                date: date,
                meals: dayMeals,
                totalNutrition: totalNutrition,
                totalCost: totalCost
            )
            
            plans.append(plan)
        }
        
        weeklyPlan = plans
        updateBudgetAlerts()
        isLoading = false
    }
    
    private func selectMeal(for category: MealCategory, date: Date) -> Meal? {
        let availableMeals = dataService.getMeals(
            for: user.country,
            category: category,
            healthGoal: user.healthGoal
        )
        
        // Filter by budget
        let budgetMeals = availableMeals.filter { $0.estimatedCost <= user.dailyBudget / 3 }
        
        // If no meals within budget, use all available
        let mealsToChooseFrom = budgetMeals.isEmpty ? availableMeals : budgetMeals
        
        // Use date as seed for consistent selection
        let seed = Int(date.timeIntervalSince1970) + category.hashValue
        var generator = SeededRandomNumberGenerator(seed: seed)
        
        return mealsToChooseFrom.randomElement(using: &generator)
    }
    
    private func calculateTotalNutrition(for meals: [Meal]) -> NutritionInfo {
        let total = meals.reduce(NutritionInfo(
            calories: 0,
            protein: 0,
            carbohydrates: 0,
            fats: 0,
            fiber: 0,
            iron: 0,
            calcium: 0,
            vitaminC: 0,
            vitaminA: 0
        )) { acc, meal in
            NutritionInfo(
                calories: acc.calories + meal.nutrition.calories,
                protein: acc.protein + meal.nutrition.protein,
                carbohydrates: acc.carbohydrates + meal.nutrition.carbohydrates,
                fats: acc.fats + meal.nutrition.fats,
                fiber: acc.fiber + meal.nutrition.fiber,
                iron: acc.iron + meal.nutrition.iron,
                calcium: acc.calcium + meal.nutrition.calcium,
                vitaminC: acc.vitaminC + meal.nutrition.vitaminC,
                vitaminA: acc.vitaminA + meal.nutrition.vitaminA
            )
        }
        return total
    }
    
    func getPlan(for date: Date) -> MealPlan? {
        let calendar = Calendar.current
        return weeklyPlan.first { calendar.isDate($0.date, inSameDayAs: date) }
    }
    
    private func updateBudgetAlerts() {
        guard let todayPlan = getPlan(for: selectedDate) else { return }
        budgetAlerts = dataService.getBudgetAlerts(for: todayPlan.meals, dailyBudget: user.dailyBudget)
    }
    
    func refreshPlan() {
        generateWeeklyPlan()
    }
}

// Seeded random number generator for consistent meal selection
struct SeededRandomNumberGenerator: RandomNumberGenerator {
    var state: UInt64
    
    init(seed: Int) {
        self.state = UInt64(seed)
    }
    
    mutating func next() -> UInt64 {
        state = state &* 1103515245 &+ 12345
        return state
    }
}

