//
//  NutriSmartApp.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

@main
struct NutriSmartApp: App {
    @StateObject private var languageManager = LanguageManager.shared
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    init() {
        // Initialize language manager
        _ = LanguageManager.shared
    }
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                MainTabView()
                    .environmentObject(languageManager)
            } else {
                OnboardingView(isPresented: $hasCompletedOnboarding)
            }
        }
    }
}

