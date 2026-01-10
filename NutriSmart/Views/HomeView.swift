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
            ScrollView {
                VStack(spacing: 20) {
                    // Welcome Section
                    welcomeSection
                    
                    // Budget Card
                    if let todayPlan = mealPlanViewModel.getPlan(for: selectedDate) {
                        BudgetCard(
                            dailyBudget: userViewModel.user.dailyBudget,
                            spent: todayPlan.totalCost,
                            currencySymbol: userViewModel.user.country.currencySymbol
                        )
                        .padding(.horizontal)
                    }
                    
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
            .navigationTitle("NutriSmart")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: UserProfileView(viewModel: userViewModel)) {
                        Image(systemName: "person.circle.fill")
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
            Text("Welcome back!")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Here's your personalized meal plan for \(formattedDate)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
    private var dailyMealPlanSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Today's Meals")
                    .font(.headline)
                    .padding(.horizontal)
                
                Spacer()
                
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .labelsHidden()
                    .padding(.horizontal)
            }
            
            if let plan = mealPlanViewModel.getPlan(for: selectedDate) {
                ForEach(plan.meals) { meal in
                    MealCard(
                        meal: meal,
                        currencySymbol: userViewModel.user.country.currencySymbol
                    ) {
                        selectedMeal = meal
                    }
                    .padding(.horizontal)
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

