//
//  Validators.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation

struct Validators {
    static func isValidAge(_ age: Int) -> Bool {
        return age >= 1 && age <= 120
    }
    
    static func isValidBudget(_ budget: Double) -> Bool {
        return budget > 0 && budget <= 10000000
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    static func formatBudgetInput(_ input: String) -> String {
        let cleaned = input.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)
        return cleaned
    }
}

