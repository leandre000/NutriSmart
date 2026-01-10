//
//  FamilyNutritionViewModel.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation
import SwiftUI

class FamilyNutritionViewModel: ObservableObject {
    @Published var familyMode: FamilyMode = .individual
    @Published var children: [ChildProfile] = []
    @Published var pregnancyProfile: PregnancyProfile?
    @Published var familyMealPlans: [FamilyMealPlan] = []
    @Published var isLoading: Bool = false
    
    private let dataService = DataService.shared
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func addChild(_ child: ChildProfile) {
        children.append(child)
    }
    
    func removeChild(_ child: ChildProfile) {
        children.removeAll { $0.id == child.id }
    }
    
    func setPregnancyProfile(_ profile: PregnancyProfile) {
        pregnancyProfile = profile
        familyMode = .pregnancy
    }
    
    func generateFamilyMealPlan(for date: Date) {
        isLoading = true
        
        let baseMeals = dataService.getMeals(for: user.country)
        var familyMeals: [FamilyMeal] = []
        
        for baseMeal in baseMeals.prefix(3) { // Breakfast, Lunch, Dinner
            let modifications = getModifications(for: baseMeal)
            let familyMeal = FamilyMeal(
                id: UUID(),
                baseMeal: baseMeal,
                servings: calculateServings(),
                childFriendly: isChildFriendly(baseMeal),
                pregnancySafe: isPregnancySafe(baseMeal),
                modifications: modifications
            )
            familyMeals.append(familyMeal)
        }
        
        let totalCost = familyMeals.reduce(0) { $0 + ($1.baseMeal.estimatedCost * Double($1.servings)) }
        
        let plan = FamilyMealPlan(
            id: UUID(),
            date: date,
            meals: familyMeals,
            totalCost: totalCost,
            servesCount: calculateServings()
        )
        
        familyMealPlans.append(plan)
        isLoading = false
    }
    
    private func calculateServings() -> Int {
        var count = 1 // Base user
        count += children.count
        if pregnancyProfile != nil {
            count += 1
        }
        return max(count, 2) // Minimum 2 servings
    }
    
    private func isChildFriendly(_ meal: Meal) -> Bool {
        // Check if meal is suitable for children
        let childUnfriendly = ["spicy", "hot", "alcohol"]
        let mealText = (meal.name + meal.description).lowercased()
        return !childUnfriendly.contains { mealText.contains($0) }
    }
    
    private func isPregnancySafe(_ meal: Meal) -> Bool {
        // Check if meal is safe during pregnancy
        let unsafe = ["raw", "undercooked", "alcohol", "high mercury"]
        let mealText = (meal.name + meal.description).lowercased()
        return !unsafe.contains { mealText.contains($0) }
    }
    
    private func getModifications(for meal: Meal) -> [String] {
        var modifications: [String] = []
        
        if familyMode == .child {
            modifications.append("Reduce spices for children")
            modifications.append("Cut into smaller pieces")
        }
        
        if let pregnancy = pregnancyProfile {
            if pregnancy.hasGestationalDiabetes {
                modifications.append("Reduce carbohydrates")
            }
            if pregnancy.hasAnemia {
                modifications.append("Add iron-rich ingredients")
            }
        }
        
        if children.contains(where: { !$0.allergies.isEmpty }) {
            modifications.append("Check for allergens")
        }
        
        return modifications
    }
}

