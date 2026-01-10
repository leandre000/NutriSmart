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
            ScrollView {
                VStack(spacing: 20) {
                    // Week Overview
                    weekOverviewSection
                    
                    // Daily Plans
                    ForEach(viewModel.weeklyPlan) { plan in
                        DailyPlanCard(plan: plan, user: user) { meal in
                            selectedMeal = meal
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("weekly_meal_plan".localized)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 12) {
                        NavigationLink(destination: ShoppingListView(meals: viewModel.weeklyPlan.flatMap { $0.meals }, user: user)) {
                            Image(systemName: "cart.fill")
                        }
                        
                        Button(action: {
                            viewModel.refreshPlan()
                        }) {
                            Image(systemName: "arrow.clockwise")
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
        VStack(alignment: .leading, spacing: 12) {
            Text("week_overview".localized)
                .font(.headline)
            
            HStack(spacing: 12) {
                StatCard(
                    title: "avg_daily_cost".localized,
                    value: "\(user.country.currencySymbol)\(String(format: "%.2f", averageDailyCost))",
                    color: .blue
                )
                
                StatCard(
                    title: "total_calories".localized,
                    value: "\(Int(averageDailyCalories))",
                    color: .orange
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
        VStack(alignment: .leading, spacing: 16) {
            // Date Header
            HStack {
                Text(plan.formattedDate)
                    .font(.headline)
                
                Spacer()
                
                Text("\(user.country.currencySymbol)\(String(format: "%.2f", plan.totalCost))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Meals
            ForEach(plan.meals) { meal in
                MealCard(
                    meal: meal,
                    currencySymbol: user.country.currencySymbol
                ) {
                    onMealTap(meal)
                }
            }
            
            // Daily Summary
            HStack {
                NutritionSummaryCard(nutrition: plan.totalNutrition)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
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

