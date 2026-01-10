//
//  MainTabView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var userViewModel = UserProfileViewModel()
    
    var body: some View {
        TabView {
            HomeView(userViewModel: userViewModel)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            MealPlanView(
                viewModel: MealPlanViewModel(user: userViewModel.user),
                user: userViewModel.user
            )
            .tabItem {
                Label("Meal Plan", systemImage: "calendar")
            }
            
            NutritionistView()
                .tabItem {
                    Label("Nutritionists", systemImage: "person.2.fill")
                }
            
            CommunityView()
                .tabItem {
                    Label("Community", systemImage: "person.3.fill")
                }
        }
        .onChange(of: userViewModel.user) { _ in
            // Update meal plan when user changes
        }
    }
}

