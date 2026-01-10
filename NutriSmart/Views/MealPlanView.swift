//
//  MealPlanView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct MealPlanView: View {
    @ObservedObject var viewModel: MealPlanViewModel
    let user: User
    @State private var selectedMeal: Meal?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Week Overview
                        weekOverviewSection
                            .padding(.horizontal)
                        
                        // Daily Plans
                        ForEach(Array(viewModel.weeklyPlan.enumerated()), id: \.element.id) { index, plan in
                            DailyPlanCard(plan: plan, user: user) { meal in
                                selectedMeal = meal
                            }
                            .padding(.horizontal)
                            .transition(.asymmetric(
                                insertion: .move(edge: .bottom).combined(with: .opacity),
                                removal: .move(edge: .top).combined(with: .opacity)
                            ))
                            .animation(.friendlySpring.delay(Double(index) * 0.1), value: viewModel.weeklyPlan.count)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("weekly_meal_plan".localized)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 12) {
                        NavigationLink(destination: ShoppingListView(meals: viewModel.weeklyPlan.flatMap { $0.meals }, user: user)) {
                            Image(systemName: "cart.fill")
                                .foregroundColor(AppTheme.primaryGreen)
                        }
                        
                        Button(action: {
                            withAnimation(.friendlySpring) {
                                viewModel.refreshPlan()
                            }
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(AppTheme.primaryGreen)
                        }
                    }
                }
            }
            .sheet(item: $selectedMeal) { meal in
                MealDetailView(meal: meal, user: user)
            }
        }
    }
    
    private var weekOverviewSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("week_overview".localized)
                .font(.title3)
                .fontWeight(.bold)
            
            HStack(spacing: 16) {
                StatCard(
                    title: "avg_daily_cost".localized,
                    value: "\(user.country.currencySymbol)\(String(format: "%.2f", averageDailyCost))",
                    color: AppTheme.primaryGreen
                )
                
                StatCard(
                    title: "total_calories".localized,
                    value: "\(Int(averageDailyCalories))",
                    color: AppTheme.accentOrange
                )
            }
        }
    }
    
    private var averageDailyCost: Double {
        let total = viewModel.weeklyPlan.reduce(0) { $0 + $1.totalCost }
        return total / Double(viewModel.weeklyPlan.count)
    }
    
    private var averageDailyCalories: Double {
        let total = viewModel.weeklyPlan.reduce(0) { $0 + $1.totalNutrition.calories }
        return total / Double(viewModel.weeklyPlan.count)
    }
}

struct DailyPlanCard: View {
    let plan: MealPlan
    let user: User
    let onMealTap: (Meal) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Date Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(plan.formattedDate)
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("\(plan.meals.count) " + "meals".localized)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(user.country.currencySymbol)\(String(format: "%.2f", plan.totalCost))")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(AppTheme.primaryGreen)
                    Text("total_cost".localized)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.bottom, 8)
            
            // Meals
            ForEach(plan.meals) { meal in
                EnhancedMealCard(
                    meal: meal,
                    currencySymbol: user.country.currencySymbol,
                    rating: 4.5 + Double.random(in: 0...0.5)
                ) {
                    onMealTap(meal)
                } onFavorite: {
                    // Handle favorite
                }
            }
            
            // Daily Summary
            NutritionSummaryCard(nutrition: plan.totalNutrition)
        }
        .padding(20)
        .cardStyle()
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct NutritionSummaryCard: View {
    let nutrition: NutritionInfo
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 4) {
                Text("calories".localized)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("\(Int(nutrition.calories))")
                    .font(.headline)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("protein".localized)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("\(String(format: "%.0f", nutrition.protein))g")
                    .font(.headline)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("carbs".localized)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("\(String(format: "%.0f", nutrition.carbohydrates))g")
                    .font(.headline)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("fats".localized)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("\(String(format: "%.0f", nutrition.fats))g")
                    .font(.headline)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

