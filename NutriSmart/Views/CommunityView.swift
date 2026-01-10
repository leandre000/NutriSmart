//
//  CommunityView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct CommunityView: View {
    @StateObject private var viewModel = CommunityViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.communityMeals) { meal in
                        CommunityMealCard(meal: meal)
                    }
                }
                .padding()
            }
            .navigationTitle("Community")
            .refreshable {
                viewModel.loadCommunityMeals()
            }
        }
    }
}

struct CommunityMealCard: View {
    let meal: CommunityMeal
    @State private var isLiked = false
    @State private var likeCount: Int
    
    init(meal: CommunityMeal) {
        self.meal = meal
        _likeCount = State(initialValue: meal.likes)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack(spacing: 12) {
                SafeImage(meal.userImageName, placeholder: "person.circle.fill", contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(meal.userName)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text(meal.datePosted, style: .relative)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            
            // Meal Image
            SafeImage(meal.imageName, placeholder: "fork.knife")
                .frame(height: 200)
                .clipped()
                .cornerRadius(12)
            
            // Meal Info
            VStack(alignment: .leading, spacing: 8) {
                Text(meal.mealName)
                    .font(.headline)
                
                Text(meal.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                
                // Nutrition Summary
                HStack(spacing: 16) {
                    Label("\(Int(meal.nutrition.calories))", systemImage: "flame.fill")
                        .font(.caption)
                        .foregroundColor(.orange)
                    
                    Label("\(String(format: "%.0f", meal.nutrition.protein))g", systemImage: "leaf.fill")
                        .font(.caption)
                        .foregroundColor(.blue)
                    
                    Spacer()
                }
            }
            
            // Actions
            HStack {
                Button(action: {
                    isLiked.toggle()
                    likeCount += isLiked ? 1 : -1
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .foregroundColor(isLiked ? .red : .gray)
                        Text("\(likeCount)")
                            .font(.caption)
                    }
                }
                
                Spacer()
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

