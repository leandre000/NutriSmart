//
//  AppTheme.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct AppTheme {
    // Primary Colors
    static let primaryGreen = Color(red: 0.2, green: 0.7, blue: 0.4)
    static let primaryGreenDark = Color(red: 0.15, green: 0.6, blue: 0.35)
    static let primaryGreenLight = Color(red: 0.3, green: 0.8, blue: 0.5)
    
    // Accent Colors
    static let accentYellow = Color(red: 1.0, green: 0.85, blue: 0.0)
    static let accentOrange = Color(red: 1.0, green: 0.6, blue: 0.2)
    static let accentBlue = Color(red: 0.2, green: 0.5, blue: 0.9)
    
    // Semantic Colors
    static let success = Color.green
    static let warning = Color.orange
    static let error = Color.red
    static let info = Color.blue
    
    // Background Colors
    static let background = Color(.systemBackground)
    static let secondaryBackground = Color(.secondarySystemBackground)
    static let cardBackground = Color.white
    
    // Text Colors
    static let primaryText = Color.primary
    static let secondaryText = Color.secondary
    static let tertiaryText = Color(.tertiaryLabel)
    
    // Gradients
    static let primaryGradient = LinearGradient(
        colors: [primaryGreen, primaryGreenDark],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let accentGradient = LinearGradient(
        colors: [accentYellow, accentOrange],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // Shadows
    static let cardShadow = Color.black.opacity(0.08)
    static let buttonShadow = Color.black.opacity(0.15)
    
    // Corner Radius
    static let cardRadius: CGFloat = 16
    static let buttonRadius: CGFloat = 12
    static let smallRadius: CGFloat = 8
}

extension View {
    func cardStyle() -> some View {
        self
            .background(AppTheme.cardBackground)
            .cornerRadius(AppTheme.cardRadius)
            .shadow(color: AppTheme.cardShadow, radius: 10, x: 0, y: 4)
    }
    
    func primaryButtonStyle() -> some View {
        self
            .foregroundColor(.white)
            .padding(.horizontal, 24)
            .padding(.vertical, 14)
            .background(AppTheme.primaryGreen)
            .cornerRadius(AppTheme.buttonRadius)
            .shadow(color: AppTheme.buttonShadow, radius: 8, x: 0, y: 4)
    }
    
    func secondaryButtonStyle() -> some View {
        self
            .foregroundColor(AppTheme.primaryGreen)
            .padding(.horizontal, 24)
            .padding(.vertical, 14)
            .background(AppTheme.primaryGreen.opacity(0.1))
            .cornerRadius(AppTheme.buttonRadius)
    }
}


