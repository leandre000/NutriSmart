//
//  BudgetAlert.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation

struct BudgetAlert: Identifiable {
    let id: UUID
    let type: AlertType
    let message: String
    let suggestedAlternatives: [Meal]
    
    enum AlertType {
        case warning
        case exceeded
        case good
    }
}

