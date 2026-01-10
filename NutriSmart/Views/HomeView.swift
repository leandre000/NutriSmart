//
//  HomeView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var userViewModel: UserProfileViewModel
    @StateObject private var mealPlanViewModel: MealPlanViewModel
    @StateObject private var dataService = DataService.shared
    @State private var selectedDate = Date()
    @State private var showingMealDetail = false
    @State private var selectedMeal: Meal?
    
    init(userViewModel: UserProfileViewModel) {
        self.userViewModel = userViewModel
        _mealPlanViewModel = StateObject(wrappedValue: MealPlanViewModel(user: userViewModel.user))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Search Bar
                        SearchBar(text: .constant(""))
                            .padding(.horizontal)
                            .padding(.top, 8)
                        
                        // AI Card
                        AICard {
                            // Navigate to AI meal planning
                        }
                        .padding(.horizontal)
                        
                        // Welcome Section
                        welcomeSection
                            .padding(.horizontal)
                        
                        // Budget Card
                        if let todayPlan = mealPlanViewModel.getPlan(for: selectedDate) {
                            BudgetCard(
                                dailyBudget: userViewModel.user.dailyBudget,
                                spent: todayPlan.totalCost,
                                currencySymbol: userViewModel.user.country.currencySymbol
                            )
                            .padding(.horizontal)
                        }
                        
                        // Categories Section
                        categoriesSection
                        
                        // Daily Meal Plan
                        dailyMealPlanSection
                        
                        // Health Tip
                        if let tip = dataService.healthTips.first {
                            HealthTipCard(tip: tip)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("app_name".localized)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(AppTheme.primaryGreen)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 12) {
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(AppTheme.primaryGreen)
                        }
                        
                        NavigationLink(destination: UserProfileView(viewModel: userViewModel)) {
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(AppTheme.primaryGreen)
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: MalnutritionRiskView(user: userViewModel.user)) {
                        Image(systemName: "heart.text.square.fill")
                            .foregroundColor(.red)
                    }
                }
            }
            .sheet(item: $selectedMeal) { meal in
                MealDetailView(meal: meal, user: userViewModel.user)
            }
            .onChange(of: userViewModel.user) { newUser in
                mealPlanViewModel.updateUser(newUser)
            }
        }
    }
    
    private var welcomeSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("welcome_back".localized)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("\("personalized_meal_plan".localized) \(formattedDate)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("categories".localized)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Spacer()
                
                NavigationLink(destination: CategoriesView(user: userViewModel.user)) {
                    HStack(spacing: 4) {
                        Text("all".localized)
                        Image(systemName: "chevron.right")
                            .font(.caption)
                    }
                    .font(.subheadline)
                    .foregroundColor(AppTheme.primaryGreen)
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    // Quick and Tasty
                    CategoryCard(
                        title: "quick_tasty".localized,
                        count: 65,
                        imageName: "breakfast",
                        color: AppTheme.accentYellow,
                        isFeatured: true
                    )
                    .frame(width: 180)
                    
                    // Balanced Diet
                    CategoryCard(
                        title: "balanced_diet".localized,
                        count: 71,
                        imageName: "balanced",
                        color: AppTheme.primaryGreen,
                        isFeatured: true
                    )
                    .frame(width: 180)
                    
                    // Budget Friendly
                    CategoryCard(
                        title: "budget_friendly".localized,
                        count: 50,
                        imageName: "budget",
                        color: AppTheme.accentOrange,
                        isFeatured: true
                    )
                    .frame(width: 180)
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var dailyMealPlanSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("todays_meals".localized)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Spacer()
                
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .labelsHidden()
            }
            .padding(.horizontal)
            
            if let plan = mealPlanViewModel.getPlan(for: selectedDate) {
                ForEach(Array(plan.meals.enumerated()), id: \.element.id) { index, meal in
                    EnhancedMealCard(
                        meal: meal,
                        currencySymbol: userViewModel.user.country.currencySymbol,
                        rating: 4.5 + Double.random(in: 0...0.5)
                    ) {
                        selectedMeal = meal
                    } onFavorite: {
                        // Handle favorite
                    }
                    .padding(.horizontal)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
                    .animation(.friendlySpring.delay(Double(index) * 0.1), value: plan.meals.count)
                }
                
                // Daily Nutrition Summary
                NutritionCard(nutrition: plan.totalNutrition)
                    .padding(.horizontal)
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedDate)
    }
}

