//
//  CategoriesView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct CategoriesView: View {
    let user: User
    @State private var searchText = ""
    @State private var selectedCategory: MealCategory? = nil
    @Environment(\.dismiss) var dismiss
    
    let categories = [
        ("quick_tasty".localized, 65, AppTheme.accentYellow),
        ("balanced_diet".localized, 71, AppTheme.primaryGreen),
        ("budget_friendly".localized, 50, AppTheme.accentOrange),
        ("chef_surprise".localized, 45, AppTheme.accentBlue),
        ("diabetes_friendly".localized, 38, Color.purple),
        ("anemia_prevention".localized, 42, Color.red),
        ("weight_loss".localized, 55, Color.blue),
        ("weight_gain".localized, 48, Color.orange),
        ("family_friendly".localized, 62, Color.pink),
        ("quick_prep".localized, 58, Color.cyan)
    ]
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Search Bar
                    SearchBar(text: $searchText)
                        .padding(.horizontal)
                        .padding(.top, 8)
                    
                    // Category Count
                    HStack {
                        Text("\(categories.count) " + "categories".localized.lowercased())
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Category Grid
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ], spacing: 16) {
                        ForEach(Array(categories.enumerated()), id: \.offset) { index, category in
                            CategoryCard(
                                title: category.0,
                                count: category.1,
                                imageName: "",
                                color: category.2,
                                isFeatured: index < 3
                            )
                            .frame(height: 140)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("categories".localized)
        .navigationBarTitleDisplayMode(.large)
    }
}



