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
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "creditcard.fill")
                        .foregroundColor(AppTheme.primaryGreen)
                        .font(.title3)
                    Text("daily_budget".localized)
                        .font(.headline)
                        .fontWeight(.bold)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text("\(currencySymbol)\(String(format: "%.2f", spent))")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(AppTheme.primaryGreen)
                    Text("/ \(currencySymbol)\(String(format: "%.2f", dailyBudget))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color(.systemGray5))
                        .frame(height: 12)
                    
                    RoundedRectangle(cornerRadius: 6)
                        .fill(
                            LinearGradient(
                                colors: [statusColor, statusColor.opacity(0.8)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * CGFloat(min(percentage / 100, 1.0)), height: 12)
                        .animation(.spring(response: 0.6), value: percentage)
                }
            }
            .frame(height: 12)
            
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: percentage >= 100 ? "exclamationmark.triangle.fill" : "checkmark.circle.fill")
                        .foregroundColor(statusColor)
                        .font(.caption)
                    Text("\("remaining".localized): \(currencySymbol)\(String(format: "%.2f", remaining))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                if percentage >= 100 {
                    Text("budget_exceeded".localized)
                        .font(.caption)
                        .foregroundColor(.red)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(8)
                }
            }
        }
        .padding(20)
        .cardStyle()
        .fadeInScale()
    }
}

