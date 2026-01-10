//
//  Formatters.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation

struct Formatters {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    static let date: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    static let time: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    static func formatCurrency(_ amount: Double, symbol: String) -> String {
        return "\(symbol)\(String(format: "%.2f", amount))"
    }
    
    static func formatNutritionValue(_ value: Double, unit: String) -> String {
        return "\(String(format: "%.1f", value)) \(unit)"
    }
}

