//
//  AICard.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct AICard: View {
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            onTap?()
        }) {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("ask_ai".localized)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("what_cook_today".localized)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                    
                    HStack(spacing: 8) {
                        Image(systemName: "sparkles")
                            .font(.caption)
                        Text("ai_powered".localized)
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.top, 4)
                }
                
                Spacer()
                
                // Ingredients illustration
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 80, height: 80)
                    
                    VStack(spacing: -8) {
                        HStack(spacing: -8) {
                            Image(systemName: "carrot.fill")
                                .font(.title3)
                                .foregroundColor(.white)
                            Image(systemName: "leaf.fill")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                        HStack(spacing: -8) {
                            Image(systemName: "applelogo")
                                .font(.title3)
                                .foregroundColor(.white)
                            Image(systemName: "drop.fill")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                    }
                }
                
                Image(systemName: "arrow.right")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding(20)
            .background(AppTheme.primaryGradient)
            .cornerRadius(AppTheme.cardRadius)
            .shadow(color: AppTheme.buttonShadow, radius: 12, x: 0, y: 6)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

