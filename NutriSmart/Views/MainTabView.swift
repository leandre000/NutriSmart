//
//  MainTabView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var userViewModel = UserProfileViewModel()
    @StateObject private var languageManager = LanguageManager.shared
    @State private var mealPlanViewModel: MealPlanViewModel
    
    init() {
        let userVM = UserProfileViewModel()
        _userViewModel = StateObject(wrappedValue: userVM)
        _mealPlanViewModel = State(wrappedValue: MealPlanViewModel(user: userVM.user))
    }
    
    var body: some View {
        TabView(selection: .constant(0)) {
            HomeView(userViewModel: userViewModel)
                .tabItem {
                    Label("home".localized, systemImage: "house.fill")
                }
                .tag(0)
            
            MealPlanView(
                viewModel: mealPlanViewModel,
                user: userViewModel.user
            )
            .tabItem {
                Label("meal_plan".localized, systemImage: "calendar")
            }
            .tag(1)
            
            NutritionistView()
                .tabItem {
                    Label("nutritionists".localized, systemImage: "person.2.fill")
                }
                .tag(2)
            
            CommunityView()
                .tabItem {
                    Label("community".localized, systemImage: "person.3.fill")
                }
                .tag(3)
            
            EducationView()
                .tabItem {
                    Label("learn".localized, systemImage: "book.fill")
                }
                .tag(4)
            
            FamilyNutritionView(user: userViewModel.user)
                .tabItem {
                    Label("family".localized, systemImage: "person.3.fill")
                }
                .tag(5)
            
            RemindersView()
                .tabItem {
                    Label("reminders".localized, systemImage: "bell.fill")
                }
                .tag(6)
        }
        .accentColor(AppTheme.primaryGreen)
        .onChange(of: userViewModel.user) { newUser in
            mealPlanViewModel.updateUser(newUser)
        }
    }
}

