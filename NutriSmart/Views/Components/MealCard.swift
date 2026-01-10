//
//  MealCard.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct MealCard: View {
    let meal: Meal
    let currencySymbol: String
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            onTap?()
        }) {
            VStack(alignment: .leading, spacing: 0) {
                // Image
                ZStack(alignment: .topTrailing) {
                    Image(meal.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 180)
                        .clipped()
                    
                    // Category badge
                    HStack(spacing: 4) {
                        Image(systemName: meal.category.icon)
                            .font(.caption2)
                        Text(meal.category.rawValue)
                            .font(.caption2)
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(8)
                }
                
                // Content
                VStack(alignment: .leading, spacing: 8) {
                    Text(meal.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    Text(meal.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                    
                    HStack {
                        // Nutrition info
                        HStack(spacing: 12) {
                            Label("\(Int(meal.nutrition.calories))", systemImage: "flame.fill")
                                .font(.caption)
                                .foregroundColor(.orange)
                            
                            Label("\(String(format: "%.0f", meal.nutrition.protein))g", systemImage: "leaf.fill")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                        
                        Spacer()
                        
                        // Cost
                        Text("\(currencySymbol)\(meal.formattedCost)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                    }
                    
                    // Prep time
                    HStack(spacing: 4) {
                        Image(systemName: "clock.fill")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text("\(meal.prepTime) min")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
            }
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

