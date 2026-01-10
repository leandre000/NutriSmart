//
//  CommunityViewModel.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation
import SwiftUI

class CommunityViewModel: ObservableObject {
    @Published var communityMeals: [CommunityMeal] = []
    @Published var isLoading: Bool = false
    
    private let dataService = DataService.shared
    
    init() {
        loadCommunityMeals()
    }
    
    func loadCommunityMeals() {
        isLoading = true
        communityMeals = dataService.communityMeals.sorted { $0.datePosted > $1.datePosted }
        isLoading = false
    }
    
    func likeMeal(_ meal: CommunityMeal) {
        // In a real app, this would update the backend
        if let index = communityMeals.firstIndex(where: { $0.id == meal.id }) {
            var updatedMeal = meal
            // Note: This won't work with let properties, but demonstrates the concept
            // In production, use a mutable model or update through a service
        }
    }
}

