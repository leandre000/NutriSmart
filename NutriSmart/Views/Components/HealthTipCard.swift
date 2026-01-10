//
//  HealthTipCard.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct HealthTipCard: View {
    let tip: HealthTip
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "lightbulb.fill")
                    .foregroundColor(AppTheme.accentYellow)
                    .font(.title3)
                Text(tip.category)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(AppTheme.primaryGreen)
                Spacer()
            }
            
            Text(tip.title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(tip.content)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
        }
        .padding(20)
        .background(
            LinearGradient(
                colors: [AppTheme.accentYellow.opacity(0.1), Color.clear],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cardStyle()
    }
}

