//
//  NutritionCard.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct NutritionCard: View {
    let nutrition: NutritionInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("nutrition_information".localized)
                .font(.headline)
                .padding(.bottom, 4)
            
            // Macros
            VStack(alignment: .leading, spacing: 12) {
                NutritionRow(
                    label: "calories".localized,
                    value: "\(Int(nutrition.calories))",
                    unit: "kcal",
                    color: .orange
                )
                
                Divider()
                
                NutritionRow(
                    label: "protein".localized,
                    value: "\(String(format: "%.1f", nutrition.protein))",
                    unit: "g",
                    color: .blue,
                    percentage: nutrition.proteinPercentage
                )
                
                NutritionRow(
                    label: "carbohydrates".localized,
                    value: "\(String(format: "%.1f", nutrition.carbohydrates))",
                    unit: "g",
                    color: .green,
                    percentage: nutrition.carbsPercentage
                )
                
                NutritionRow(
                    label: "fats".localized,
                    value: "\(String(format: "%.1f", nutrition.fats))",
                    unit: "g",
                    color: .purple,
                    percentage: nutrition.fatsPercentage
                )
            }
            
            Divider()
            
            // Micronutrients
            VStack(alignment: .leading, spacing: 8) {
                Text("key_nutrients".localized)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 20) {
                    MicronutrientBadge(name: "Iron", value: "\(String(format: "%.1f", nutrition.iron)) mg", color: .red)
                    MicronutrientBadge(name: "Calcium", value: "\(String(format: "%.0f", nutrition.calcium)) mg", color: .blue)
                    MicronutrientBadge(name: "Vitamin C", value: "\(String(format: "%.0f", nutrition.vitaminC)) mg", color: .orange)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct NutritionRow: View {
    let label: String
    let value: String
    let unit: String
    let color: Color
    var percentage: Double? = nil
    
    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
            
            Text(label)
                .font(.subheadline)
            
            Spacer()
            
            HStack(spacing: 4) {
                Text(value)
                    .fontWeight(.semibold)
                Text(unit)
                    .foregroundColor(.secondary)
                
                if let percentage = percentage {
                    Text("(\(String(format: "%.0f", percentage))%)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct MicronutrientBadge: View {
    let name: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(name)
                .font(.caption2)
                .foregroundColor(.secondary)
            Text(value)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(color)
        }
    }
}

