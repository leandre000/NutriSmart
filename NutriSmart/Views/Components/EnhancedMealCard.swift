//
//  EnhancedMealCard.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct EnhancedMealCard: View {
    let meal: Meal
    let currencySymbol: String
    var isFavorite: Bool = false
    var rating: Double? = nil
    var onTap: (() -> Void)? = nil
    var onFavorite: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            withAnimation(.friendlySpring) {
                onTap?()
            }
        }) {
            VStack(alignment: .leading, spacing: 0) {
                // Image with overlay
                ZStack(alignment: .topTrailing) {
                    SafeImage(meal.imageName, placeholder: "fork.knife")
                        .frame(height: 200)
                        .clipped()
                    
                    // Gradient overlay
                    LinearGradient(
                        colors: [Color.clear, Color.black.opacity(0.3)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 200)
                    
                    // Top badges
                    HStack {
                        // Category badge
                        HStack(spacing: 4) {
                            Image(systemName: meal.category.icon)
                                .font(.caption2)
                            Text(meal.category.rawValue)
                                .font(.caption2)
                                .fontWeight(.semibold)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.white.opacity(0.9))
                        .foregroundColor(AppTheme.primaryGreen)
                        .cornerRadius(20)
                        
                        Spacer()
                        
                        // Favorite button
                        if let onFavorite = onFavorite {
                            Button(action: {
                                withAnimation(.friendlySpring) {
                                    onFavorite()
                                }
                            }) {
                                Image(systemName: isFavorite ? "heart.fill" : "heart")
                                    .font(.title3)
                                    .foregroundColor(isFavorite ? .red : .white)
                                    .padding(8)
                                    .background(Color.black.opacity(0.3))
                                    .clipShape(Circle())
                            }
                        }
                        
                        // Rating if available
                        if let rating = rating {
                            HStack(spacing: 2) {
                                Image(systemName: "star.fill")
                                    .font(.caption2)
                                Text(String(format: "%.1f", rating))
                                    .font(.caption)
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.white.opacity(0.9))
                            .foregroundColor(AppTheme.accentYellow)
                            .cornerRadius(12)
                        }
                    }
                    .padding(12)
                }
                
                // Content
                VStack(alignment: .leading, spacing: 12) {
                    Text(meal.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    Text(meal.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                    
                    // Quick info row
                    HStack(spacing: 16) {
                        Label("\(meal.prepTime) " + "min".localized, systemImage: "clock.fill")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Label("\(Int(meal.nutrition.calories)) " + "calories".localized, systemImage: "flame.fill")
                            .font(.caption)
                            .foregroundColor(.orange)
                        
                        Label("\(String(format: "%.0f", meal.nutrition.protein))g", systemImage: "leaf.fill")
                            .font(.caption)
                            .foregroundColor(AppTheme.primaryGreen)
                    }
                    
                    // Cost and action
                    HStack {
                        Text("\(currencySymbol)\(meal.formattedCost)")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(AppTheme.primaryGreen)
                        
                        Spacer()
                        
                        HStack(spacing: 4) {
                            Text("view".localized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                                .font(.caption)
                        }
                        .foregroundColor(AppTheme.primaryGreen)
                    }
                }
                .padding(16)
            }
            .background(Color(.systemBackground))
            .cornerRadius(AppTheme.cardRadius)
            .shadow(color: AppTheme.cardShadow, radius: 12, x: 0, y: 6)
        }
        .buttonStyle(PlainButtonStyle())
    }
}


