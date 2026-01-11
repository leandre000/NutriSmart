//
//  ShoppingList.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation

struct ShoppingList: Identifiable {
    let id: UUID
    let dateCreated: Date
    let items: [ShoppingItem]
    let estimatedTotalCost: Double
    let currencySymbol: String
    let period: ShoppingPeriod
    
    enum ShoppingPeriod: String {
        case daily = "Daily"
        case weekly = "Weekly"
        case monthly = "Monthly"
    }
}

struct ShoppingItem: Identifiable, Hashable {
    let id: UUID
    let name: String
    let category: ItemCategory
    var quantity: Double
    let unit: String
    var estimatedCost: Double
    var isChecked: Bool
    var priority: Priority
    var alternatives: [String] // Budget-saving alternatives
    
    enum ItemCategory: String, Codable {
        case vegetables = "Vegetables"
        case fruits = "Fruits"
        case proteins = "Proteins"
        case grains = "Grains"
        case dairy = "Dairy"
        case spices = "Spices"
        case other = "Other"
        
        var icon: String {
            switch self {
            case .vegetables: return "leaf.fill"
            case .fruits: return "applelogo"
            case .proteins: return "fish.fill"
            case .grains: return "wheat"
            case .dairy: return "drop.fill"
            case .spices: return "flame.fill"
            case .other: return "cart.fill"
            }
        }
    }
    
    enum Priority: String, Codable {
        case essential = "Essential"
        case important = "Important"
        case optional = "Optional"
    }
}

struct BudgetSavingTip: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let potentialSavings: Double
    let action: String
}


