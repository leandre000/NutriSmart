//
//  UserProfileViewModel.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation
import SwiftUI

class UserProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var isEditing: Bool = false
    @Published var selectedCountry: Country
    @Published var selectedHealthGoal: HealthGoal
    @Published var monthlyBudgetText: String
    
    private let userDefaults = UserDefaults.standard
    private let userKey = "savedUser"
    
    init() {
        if let savedData = userDefaults.data(forKey: userKey),
           let savedUser = try? JSONDecoder().decode(User.self, from: savedData) {
            self.user = savedUser
            self.selectedCountry = savedUser.country
            self.selectedHealthGoal = savedUser.healthGoal
            self.monthlyBudgetText = String(format: "%.2f", savedUser.monthlyBudget)
        } else {
            // Default user
            self.user = User(
                id: UUID(),
                age: 30,
                gender: .male,
                country: .rwanda,
                monthlyBudget: 50000,
                healthGoal: .healthyLiving
            )
            self.selectedCountry = .rwanda
            self.selectedHealthGoal = .healthyLiving
            self.monthlyBudgetText = "50000"
        }
    }
    
    func saveProfile() {
        user.country = selectedCountry
        user.healthGoal = selectedHealthGoal
        
        if let budget = Double(monthlyBudgetText) {
            user.monthlyBudget = budget
        }
        
        if let encoded = try? JSONEncoder().encode(user) {
            userDefaults.set(encoded, forKey: userKey)
        }
        
        isEditing = false
    }
    
    func updateAge(_ age: Int) {
        user.age = age
        saveProfile()
    }
    
    func updateGender(_ gender: Gender) {
        user.gender = gender
        saveProfile()
    }
}

