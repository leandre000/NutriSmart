//
//  BudgetCard.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct BudgetCard: View {
    let dailyBudget: Double
    let spent: Double
    let currencySymbol: String
    
    var remaining: Double {
        max(0, dailyBudget - spent)
    }
    
    var percentage: Double {
        min(100, (spent / dailyBudget) * 100)
    }
    
    var statusColor: Color {
        if percentage >= 100 {
            return .red
        } else if percentage >= 80 {
            return .orange
        } else {
            return .green
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "creditcard.fill")
                    .foregroundColor(.blue)
                Text("Daily Budget")
                    .font(.headline)
                Spacer()
                Text("\(currencySymbol)\(String(format: "%.2f", spent)) / \(currencySymbol)\(String(format: "%.2f", dailyBudget))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 8)
                        .cornerRadius(4)
                    
                    Rectangle()
                        .fill(statusColor)
                        .frame(width: geometry.size.width * CGFloat(percentage / 100), height: 8)
                        .cornerRadius(4)
                }
            }
            .frame(height: 8)
            
            HStack {
                Text("Remaining: \(currencySymbol)\(String(format: "%.2f", remaining))")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                if percentage >= 100 {
                    Text("Budget Exceeded")
                        .font(.caption)
                        .foregroundColor(.red)
                        .fontWeight(.semibold)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

