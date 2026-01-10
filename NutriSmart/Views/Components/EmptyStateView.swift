//
//  EmptyStateView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct EmptyStateView: View {
    let title: String
    let message: String
    let systemImage: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: systemImage)
                .font(.system(size: 70))
                .foregroundColor(AppTheme.primaryGreen.opacity(0.6))
            
            VStack(spacing: 8) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            
            if let actionTitle = actionTitle, let action = action {
                Button(action: action) {
                    Text(actionTitle)
                        .primaryButtonStyle()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

