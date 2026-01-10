//
//  MealFilterView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct MealFilterView: View {
    @Binding var selectedCategory: MealCategory?
    @Binding var selectedHealthGoal: HealthGoal?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Category Filter
            VStack(alignment: .leading, spacing: 8) {
                Text("Meal Category")
                    .font(.headline)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        FilterChip(
                            title: "All",
                            isSelected: selectedCategory == nil,
                            action: { selectedCategory = nil }
                        )
                        
                        ForEach(MealCategory.allCases, id: \.self) { category in
                            FilterChip(
                                title: category.rawValue,
                                icon: category.icon,
                                isSelected: selectedCategory == category,
                                action: { selectedCategory = category }
                            )
                        }
                    }
                }
            }
            
            // Health Goal Filter
            VStack(alignment: .leading, spacing: 8) {
                Text("Health Goal")
                    .font(.headline)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        FilterChip(
                            title: "All",
                            isSelected: selectedHealthGoal == nil,
                            action: { selectedHealthGoal = nil }
                        )
                        
                        ForEach(HealthGoal.allCases, id: \.self) { goal in
                            FilterChip(
                                title: goal.rawValue,
                                icon: goal.icon,
                                isSelected: selectedHealthGoal == goal,
                                action: { selectedHealthGoal = goal }
                            )
                        }
                    }
                }
            }
        }
    }
}

struct FilterChip: View {
    let title: String
    var icon: String? = nil
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.caption)
                }
                Text(title)
                    .font(.subheadline)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? Color.blue : Color(.systemGray5))
            .foregroundColor(isSelected ? .white : .primary)
            .cornerRadius(20)
        }
    }
}

