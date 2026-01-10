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
                    .foregroundColor(.yellow)
                Text(tip.category)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                Spacer()
            }
            
            Text(tip.title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(tip.content)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

