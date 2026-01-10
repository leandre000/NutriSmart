//
//  BudgetAlertView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct BudgetAlertView: View {
    let alert: BudgetAlert
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: alertIcon)
                .foregroundColor(alertColor)
                .font(.title3)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(alertTitle)
                    .font(.headline)
                    .foregroundColor(alertColor)
                
                Text(alert.message)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(alertColor.opacity(0.1))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(alertColor, lineWidth: 1)
        )
    }
    
    private var alertIcon: String {
        switch alert.type {
        case .warning:
            return "exclamationmark.triangle.fill"
        case .exceeded:
            return "xmark.circle.fill"
        case .good:
            return "checkmark.circle.fill"
        }
    }
    
    private var alertColor: Color {
        switch alert.type {
        case .warning:
            return .orange
        case .exceeded:
            return .red
        case .good:
            return .green
        }
    }
    
    private var alertTitle: String {
        switch alert.type {
        case .warning:
            return "Budget Warning"
        case .exceeded:
            return "Budget Exceeded"
        case .good:
            return "Budget On Track"
        }
    }
}

