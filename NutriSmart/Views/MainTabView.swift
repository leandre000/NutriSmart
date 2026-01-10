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
        TabView {
            HomeView(userViewModel: userViewModel)
                .tabItem {
                    Label("home".localized, systemImage: "house.fill")
                }
            
            MealPlanView(
                viewModel: mealPlanViewModel,
                user: userViewModel.user
            )
            .tabItem {
                Label("meal_plan".localized, systemImage: "calendar")
            }
            
            NutritionistView()
                .tabItem {
                    Label("nutritionists".localized, systemImage: "person.2.fill")
                }
            
            CommunityView()
                .tabItem {
                    Label("community".localized, systemImage: "person.3.fill")
                }
            
            EducationView()
                .tabItem {
                    Label("learn".localized, systemImage: "book.fill")
                }
        }
        .onChange(of: userViewModel.user) { newUser in
            mealPlanViewModel.updateUser(newUser)
        }
    }
}

