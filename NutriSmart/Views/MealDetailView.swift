//
//  MealDetailView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct MealDetailView: View {
    let meal: Meal
    let user: User
    @StateObject private var viewModel: MealDetailViewModel
    @Environment(\.dismiss) var dismiss
    
    init(meal: Meal, user: User) {
        self.meal = meal
        self.user = user
        _viewModel = StateObject(wrappedValue: MealDetailViewModel(meal: meal, user: user))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Hero Image
                    SafeImage(meal.imageName, placeholder: "fork.knife")
                        .frame(height: 300)
                        .clipped()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        // Header
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(meal.name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                Button(action: {
                                    viewModel.toggleFavorite()
                                }) {
                                    Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                                        .foregroundColor(viewModel.isFavorite ? .red : .gray)
                                        .font(.title2)
                                }
                            }
                            
                            HStack(spacing: 16) {
                                Label("\(meal.prepTime) \("min".localized)", systemImage: "clock.fill")
                                Label("\(meal.servings) \("servings".localized)", systemImage: "person.2.fill")
                                Label("\(user.country.currencySymbol)\(meal.formattedCost)", systemImage: "creditcard.fill")
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            
                            Text(meal.description)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        
                        // Nutrition Card
                        NutritionCard(nutrition: meal.nutrition)
                        
                        // Ingredients
                        VStack(alignment: .leading, spacing: 12) {
                            Text("ingredients".localized)
                                .font(.headline)
                            
                            ForEach(meal.ingredients) { ingredient in
                                HStack {
                                    Circle()
                                        .fill(Color.blue.opacity(0.2))
                                        .frame(width: 6, height: 6)
                                    
                                    Text(ingredient.name)
                                        .font(.subheadline)
                                    
                                    Spacer()
                                    
                                    Text("\(ingredient.quantity) \(ingredient.unit)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        
                        // Preparation Steps
                        VStack(alignment: .leading, spacing: 12) {
                            Text("preparation_steps".localized)
                                .font(.headline)
                            
                            ForEach(Array(meal.preparationSteps.enumerated()), id: \.offset) { index, step in
                                HStack(alignment: .top, spacing: 12) {
                                    Text("\(index + 1)")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(width: 28, height: 28)
                                        .background(Color.blue)
                                        .clipShape(Circle())
                                    
                                    Text(step)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        
                        // Health Benefits
                        if !meal.healthBenefits.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("health_benefits".localized)
                                    .font(.headline)
                                
                                ForEach(meal.healthBenefits, id: \.self) { benefit in
                                    HStack(alignment: .top, spacing: 8) {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                        Text(benefit)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                        
                        // Similar Meals
                        if !viewModel.similarMeals.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("similar_meals".localized)
                                    .font(.headline)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 12) {
                                        ForEach(viewModel.similarMeals) { similarMeal in
                                            NavigationLink(destination: MealDetailView(meal: similarMeal, user: user)) {
                                                VStack(alignment: .leading, spacing: 8) {
                                                    SafeImage(similarMeal.imageName, placeholder: "fork.knife")
                                                        .frame(width: 150, height: 100)
                                                        .clipped()
                                                        .cornerRadius(8)
                                                    
                                                    Text(similarMeal.name)
                                                        .font(.caption)
                                                        .fontWeight(.semibold)
                                                        .lineLimit(2)
                                                }
                                                .frame(width: 150)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("done".localized) {
                        dismiss()
                    }
                }
            }
        }
    }
}

