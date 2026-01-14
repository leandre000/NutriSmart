//
//  CategoryCard.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct CategoryCard: View {
    let title: String
    let count: Int
    let imageName: String
    let color: Color
    var isFeatured: Bool = false
    
    var body: some View {
        Button(action: {}) {
            ZStack(alignment: .bottomLeading) {
                // Background image or color
                if isFeatured {
                    Color(color)
                } else {
                    Color(.systemGray6)
                }
                
                // Content
                VStack(alignment: .leading, spacing: 8) {
                    Spacer()
                    
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(isFeatured ? .white : .primary)
                    
                    Text("\(count) " + "recipes".localized)
                        .font(.subheadline)
                        .foregroundColor(isFeatured ? .white.opacity(0.9) : .secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
            }
            .frame(height: 140)
            .cornerRadius(AppTheme.cardRadius)
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.cardRadius)
                    .stroke(isFeatured ? Color.clear : Color(.systemGray4), lineWidth: 1)
            )
            .shadow(color: AppTheme.cardShadow, radius: isFeatured ? 8 : 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}



