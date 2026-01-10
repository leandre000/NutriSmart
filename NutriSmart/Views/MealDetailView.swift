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
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Hero Image
                        ZStack(alignment: .topTrailing) {
                            SafeImage(meal.imageName, placeholder: "fork.knife")
                                .frame(height: 350)
                                .clipped()
                            
                            // Gradient overlay
                            LinearGradient(
                                colors: [Color.clear, Color.black.opacity(0.4)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .frame(height: 350)
                            
                            // Favorite button
                            Button(action: {
                                withAnimation(.friendlySpring) {
                                    viewModel.toggleFavorite()
                                }
                            }) {
                                Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                                    .font(.title2)
                                    .foregroundColor(viewModel.isFavorite ? .red : .white)
                                    .padding(12)
                                    .background(Color.black.opacity(0.3))
                                    .clipShape(Circle())
                            }
                            .padding(20)
                        }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        // Header
                        VStack(alignment: .leading, spacing: 12) {
                            Text(meal.name)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                            
                            HStack(spacing: 16) {
                                Label("\(meal.prepTime) \("min".localized)", systemImage: "clock.fill")
                                Label("\(meal.servings) \("servings".localized)", systemImage: "person.2.fill")
                                Label("\(user.country.currencySymbol)\(meal.formattedCost)", systemImage: "creditcard.fill")
                            }
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                        }
                        .padding(.horizontal)
                        .padding(.top, -60)
                        
                        // Description Card
                        VStack(alignment: .leading, spacing: 8) {
                            Text(meal.description)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .cardStyle()
                        .padding(.horizontal)
                        
                        // Nutrition Card
                        NutritionCard(nutrition: meal.nutrition)
                            .padding(.horizontal)
                        
                        // Ingredients
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Image(systemName: "list.bullet")
                                    .foregroundColor(AppTheme.primaryGreen)
                                Text("ingredients".localized)
                                    .font(.title3)
                                    .fontWeight(.bold)
                            }
                            
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
                        .cardStyle()
                        .padding(.horizontal)
                        
                        // Preparation Steps
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Image(systemName: "list.number")
                                    .foregroundColor(AppTheme.primaryGreen)
                                Text("preparation_steps".localized)
                                    .font(.title3)
                                    .fontWeight(.bold)
                            }
                            
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
                        .cardStyle()
                        .padding(.horizontal)
                        
                        // Health Benefits
                        if !meal.healthBenefits.isEmpty {
                            VStack(alignment: .leading, spacing: 16) {
                                HStack {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                    Text("health_benefits".localized)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                }
                                
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
                            .cardStyle()
                            .padding(.horizontal)
                        }
                        
                        // Action Buttons
                        HStack(spacing: 12) {
                            NavigationLink(destination: FoodSubstitutionView(user: user)) {
                                HStack {
                                    Image(systemName: "arrow.triangle.2.circlepath")
                                    Text("find_substitutions".localized)
                                        .fontWeight(.semibold)
                                }
                                .primaryButtonStyle()
                            }
                            
                            NavigationLink(destination: ShoppingListView(meals: [meal], user: user)) {
                                HStack {
                                    Image(systemName: "cart.fill")
                                    Text("shopping_list".localized)
                                        .fontWeight(.semibold)
                                }
                                .primaryButtonStyle()
                            }
                        }
                        .padding(.horizontal)
                        
                        // Similar Meals
                        if !viewModel.similarMeals.isEmpty {
                            VStack(alignment: .leading, spacing: 16) {
                                HStack {
                                    Text("similar_meals".localized)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(viewModel.similarMeals) { similarMeal in
                                            NavigationLink(destination: MealDetailView(meal: similarMeal, user: user)) {
                                                VStack(alignment: .leading, spacing: 8) {
                                                    SafeImage(similarMeal.imageName, placeholder: "fork.knife")
                                                        .frame(width: 160, height: 120)
                                                        .clipped()
                                                        .cornerRadius(AppTheme.smallRadius)
                                                    
                                                    Text(similarMeal.name)
                                                        .font(.subheadline)
                                                        .fontWeight(.semibold)
                                                        .lineLimit(2)
                                                        .foregroundColor(.primary)
                                                }
                                                .frame(width: 160)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                }
                            }
                            .padding()
                            .cardStyle()
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("done".localized) {
                        dismiss()
                    }
                    .foregroundColor(AppTheme.primaryGreen)
                }
            }
        }
    }
}

