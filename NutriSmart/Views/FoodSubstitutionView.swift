//
//  FoodSubstitutionView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct FoodSubstitutionView: View {
    @StateObject private var viewModel: FoodSubstitutionViewModel
    @State private var searchText = ""
    @State private var selectedMeal: Meal?
    let user: User
    
    init(user: User) {
        self.user = user
        _viewModel = StateObject(wrappedValue: FoodSubstitutionViewModel(user: user))
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if let meal = selectedMeal {
                    mealSubstitutionsView(meal)
                } else {
                    mealSelectionView
                }
            }
            .navigationTitle("food_substitutions".localized)
        }
    }
    
    private var mealSelectionView: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("select_meal_for_substitutions".localized)
                    .font(.headline)
                    .padding()
                
                let meals = DataService.shared.getMeals(for: user.country)
                ForEach(meals.prefix(10)) { meal in
                    Button(action: {
                        withAnimation(.spring(response: 0.3)) {
                            selectedMeal = meal
                            viewModel.findSubstitutions(for: meal)
                        }
                    }) {
                        HStack {
                            SafeImage(meal.imageName, placeholder: "fork.knife")
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(meal.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text(meal.category.rawValue)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
    }
    
    private func mealSubstitutionsView(_ meal: Meal) -> some View {
        ScrollView {
            VStack(spacing: 20) {
                // Meal Header
                VStack(spacing: 12) {
                    SafeImage(meal.imageName, placeholder: "fork.knife")
                        .frame(height: 200)
                        .cornerRadius(16)
                    
                    Text(meal.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Button(action: {
                        withAnimation {
                            selectedMeal = nil
                            viewModel.substitutions = []
                        }
                    }) {
                        Text("select_different_meal".localized)
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                
                // Substitutions
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else if viewModel.substitutions.isEmpty {
                    EmptyStateView(
                        title: "no_substitutions".localized,
                        message: "no_substitutions_desc".localized,
                        systemImage: "magnifyingglass"
                    )
                } else {
                    ForEach(viewModel.substitutions) { suggestion in
                        SubstitutionSuggestionCard(suggestion: suggestion, currencySymbol: user.country.currencySymbol)
                    }
                }
            }
            .padding()
        }
    }
}

struct SubstitutionSuggestionCard: View {
    let suggestion: SubstitutionSuggestion
    let currencySymbol: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Original Ingredient
            HStack {
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.blue)
                Text("original_ingredient".localized + ": \(suggestion.ingredient.name)")
                    .font(.headline)
            }
            
            Divider()
            
            // Best Match
            if let best = suggestion.bestMatch as FoodSubstitution? {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("best_match".localized)
                            .font(.headline)
                    }
                    
                    SubstitutionDetailCard(substitution: best, currencySymbol: currencySymbol)
                }
            }
            
            // Other Options
            if suggestion.substitutions.count > 1 {
                VStack(alignment: .leading, spacing: 12) {
                    Text("other_options".localized)
                        .font(.headline)
                        .padding(.top, 8)
                    
                    ForEach(suggestion.substitutions.filter { $0.id != suggestion.bestMatch.id }) { sub in
                        SubstitutionDetailCard(substitution: sub, currencySymbol: currencySymbol)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct SubstitutionDetailCard: View {
    let substitution: FoodSubstitution
    let currencySymbol: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(substitution.substitute)
                    .font(.headline)
                    .foregroundColor(.green)
                
                Spacer()
                
                if substitution.costDifference > 0 {
                    Label("\(currencySymbol)\(String(format: "%.0f", substitution.costDifference)) " + "cheaper".localized, systemImage: "arrow.down.circle.fill")
                        .font(.caption)
                        .foregroundColor(.green)
                } else if substitution.costDifference < 0 {
                    Label("\(currencySymbol)\(String(format: "%.0f", abs(substitution.costDifference))) " + "more_expensive".localized, systemImage: "arrow.up.circle.fill")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
            }
            
            Text(substitution.reason.rawValue)
                .font(.caption)
                .foregroundColor(.secondary)
            
            // Nutrition Comparison
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("protein".localized)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("\(String(format: "%.1f", substitution.nutritionComparison.substituteProtein))g")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("calories".localized)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("\(String(format: "%.0f", substitution.nutritionComparison.substituteCalories))")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
            
            Text(substitution.instructions)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 4)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}


