//
//  BudgetAlert.swift
//  NutriSmart budget alert
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

