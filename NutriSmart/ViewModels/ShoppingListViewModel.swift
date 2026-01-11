//
//  ShoppingListViewModel.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation
import SwiftUI

class ShoppingListViewModel: ObservableObject {
    @Published var shoppingList: ShoppingList?
    @Published var budgetTips: [BudgetSavingTip] = []
    @Published var isLoading: Bool = false
    
    private let dataService = DataService.shared
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func generateShoppingList(from meals: [Meal], period: ShoppingList.ShoppingPeriod) {
        isLoading = true
        
        var items: [ShoppingItem] = []
        var itemMap: [String: ShoppingItem] = [:]
        
        // Aggregate ingredients from all meals
        for meal in meals {
            for ingredient in meal.ingredients {
                let key = ingredient.name.lowercased()
                
                if let existing = itemMap[key] {
                    // Update quantity
                    var updated = existing
                    updated.quantity += parseQuantity(ingredient.quantity)
                    itemMap[key] = updated
                } else {
                    // Create new item
                    let cost = estimateIngredientCost(ingredient.name, quantity: parseQuantity(ingredient.quantity))
                    let item = ShoppingItem(
                        id: UUID(),
                        name: ingredient.name,
                        category: categorizeIngredient(ingredient.name),
                        quantity: parseQuantity(ingredient.quantity),
                        unit: ingredient.unit,
                        estimatedCost: cost,
                        isChecked: false,
                        priority: determinePriority(ingredient.name),
                        alternatives: findAlternatives(ingredient.name)
                    )
                    itemMap[key] = item
                }
            }
        }
        
        items = Array(itemMap.values).sorted { $0.priority.rawValue < $1.priority.rawValue }
        let totalCost = items.reduce(0) { $0 + $1.estimatedCost }
        
        shoppingList = ShoppingList(
            id: UUID(),
            dateCreated: Date(),
            items: items,
            estimatedTotalCost: totalCost,
            currencySymbol: user.country.currencySymbol,
            period: period
        )
        
        generateBudgetTips()
        isLoading = false
    }
    
    func toggleItem(_ item: ShoppingItem) {
        guard var list = shoppingList else { return }
        if let index = list.items.firstIndex(where: { $0.id == item.id }) {
            list.items[index].isChecked.toggle()
            shoppingList = list
        }
    }
    
    private func parseQuantity(_ quantity: String) -> Double {
        return Double(quantity) ?? 0.0
    }
    
    private func estimateIngredientCost(_ name: String, quantity: Double) -> Double {
        // Simple estimation based on ingredient type
        let baseCosts: [String: Double] = [
            "beans": 500,
            "rice": 800,
            "maize": 600,
            "chicken": 2000,
            "fish": 1500,
            "vegetables": 300,
            "tomatoes": 400,
            "onions": 300
        ]
        
        let lowerName = name.lowercased()
        for (key, cost) in baseCosts {
            if lowerName.contains(key) {
                return cost * (quantity / 100) // per 100g
            }
        }
        
        return 500 * (quantity / 100) // default estimate
    }
    
    private func categorizeIngredient(_ name: String) -> ShoppingItem.ItemCategory {
        let lower = name.lowercased()
        if lower.contains("vegetable") || lower.contains("cabbage") || lower.contains("spinach") {
            return .vegetables
        } else if lower.contains("fruit") || lower.contains("banana") || lower.contains("berry") {
            return .fruits
        } else if lower.contains("chicken") || lower.contains("fish") || lower.contains("meat") || lower.contains("bean") || lower.contains("egg") {
            return .proteins
        } else if lower.contains("rice") || lower.contains("maize") || lower.contains("wheat") || lower.contains("flour") {
            return .grains
        } else if lower.contains("milk") || lower.contains("yogurt") || lower.contains("cheese") {
            return .dairy
        } else if lower.contains("spice") || lower.contains("pepper") || lower.contains("salt") {
            return .spices
        }
        return .other
    }
    
    private func determinePriority(_ name: String) -> ShoppingItem.Priority {
        let lower = name.lowercased()
        if lower.contains("bean") || lower.contains("rice") || lower.contains("maize") {
            return .essential
        } else if lower.contains("vegetable") || lower.contains("tomato") || lower.contains("onion") {
            return .important
        }
        return .optional
    }
    
    private func findAlternatives(_ name: String) -> [String] {
        let alternatives: [String: [String]] = [
            "chicken": ["beans", "fish", "eggs"],
            "fish": ["chicken", "beans", "eggs"],
            "rice": ["maize", "sweet potato", "cassava"],
            "tomatoes": ["local vegetables", "onions"],
            "milk": ["yogurt", "local alternatives"]
        ]
        
        let lower = name.lowercased()
        for (key, alts) in alternatives {
            if lower.contains(key) {
                return alts
            }
        }
        return []
    }
    
    private func generateBudgetTips() {
        guard let list = shoppingList else { return }
        
        var tips: [BudgetSavingTip] = []
        
        // Check for expensive items
        let expensiveItems = list.items.filter { $0.estimatedCost > 1000 }
        if !expensiveItems.isEmpty {
            let item = expensiveItems.first!
            if !item.alternatives.isEmpty {
                tips.append(BudgetSavingTip(
                    id: UUID(),
                    title: "Save on \(item.name)",
                    description: "Consider \(item.alternatives.joined(separator: " or ")) as a budget-friendly alternative",
                    potentialSavings: item.estimatedCost * 0.3,
                    action: "Switch to alternative"
                ))
            }
        }
        
        // Seasonal buying tip
        tips.append(BudgetSavingTip(
            id: UUID(),
            title: "Buy Seasonal Produce",
            description: "Purchase fruits and vegetables that are in season for better prices",
            potentialSavings: list.estimatedTotalCost * 0.15,
            action: "Check seasonal availability"
        ))
        
        budgetTips = tips
    }
}


