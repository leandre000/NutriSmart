//
//  ShoppingListView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct ShoppingListView: View {
    @StateObject private var viewModel: ShoppingListViewModel
    @State private var selectedPeriod: ShoppingList.ShoppingPeriod = .weekly
    let meals: [Meal]
    let user: User
    
    init(meals: [Meal], user: User) {
        self.meals = meals
        self.user = user
        _viewModel = StateObject(wrappedValue: ShoppingListViewModel(user: user))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Period Selector
                    periodSelector
                    
                    // Generate Button
                    if viewModel.shoppingList == nil {
                        generateButton
                    }
                    
                    // Shopping List
                    if let list = viewModel.shoppingList {
                        shoppingListContent(list)
                    }
                    
                    // Budget Tips
                    if !viewModel.budgetTips.isEmpty {
                        budgetTipsSection
                    }
                }
                .padding()
            }
            .navigationTitle("shopping_list".localized)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if viewModel.shoppingList != nil {
                        Button(action: {
                            viewModel.generateShoppingList(from: meals, period: selectedPeriod)
                        }) {
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                }
            }
        }
    }
    
    private var periodSelector: some View {
        Picker("Period", selection: $selectedPeriod) {
            Text("daily".localized).tag(ShoppingList.ShoppingPeriod.daily)
            Text("weekly".localized).tag(ShoppingList.ShoppingPeriod.weekly)
            Text("monthly".localized).tag(ShoppingList.ShoppingPeriod.monthly)
        }
        .pickerStyle(.segmented)
    }
    
    private var generateButton: some View {
        Button(action: {
            withAnimation(.spring(response: 0.4)) {
                viewModel.generateShoppingList(from: meals, period: selectedPeriod)
            }
        }) {
            HStack {
                Image(systemName: "cart.fill")
                Text("generate_shopping_list".localized)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(12)
        }
    }
    
    private func shoppingListContent(_ list: ShoppingList) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            // Summary Card
            HStack {
                VStack(alignment: .leading) {
                    Text("total_cost".localized)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(list.currencySymbol)\(String(format: "%.2f", list.estimatedTotalCost))")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("items".localized)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(list.items.count)")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            // Items by Category
            ForEach(ShoppingItem.ItemCategory.allCases, id: \.self) { category in
                let categoryItems = list.items.filter { $0.category == category }
                if !categoryItems.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: category.icon)
                                .foregroundColor(.blue)
                            Text(category.rawValue)
                                .font(.headline)
                        }
                        
                        ForEach(categoryItems) { item in
                            ShoppingItemRow(item: item) {
                                viewModel.toggleItem(item)
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                }
            }
        }
    }
    
    private var budgetTipsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("budget_tips".localized)
                .font(.headline)
                .padding(.horizontal, 4)
            
            ForEach(viewModel.budgetTips) { tip in
                BudgetTipCard(tip: tip, currencySymbol: user.country.currencySymbol)
            }
        }
    }
}

struct ShoppingItemRow: View {
    let item: ShoppingItem
    let onToggle: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: onToggle) {
                Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(item.isChecked ? .green : .gray)
                    .font(.title3)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.body)
                    .strikethrough(item.isChecked)
                
                HStack {
                    Text("\(String(format: "%.1f", item.quantity)) \(item.unit)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if item.priority == .essential {
                        Text("•")
                            .foregroundColor(.red)
                        Text("essential".localized)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
            }
            
            Spacer()
            
            Text("\(item.estimatedCost, specifier: "%.0f")")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.green)
        }
        .padding(.vertical, 8)
    }
}

struct BudgetTipCard: View {
    let tip: BudgetSavingTip
    let currencySymbol: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "lightbulb.fill")
                    .foregroundColor(.yellow)
                Text(tip.title)
                    .font(.headline)
            }
            
            Text(tip.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Text("potential_savings".localized + ": \(currencySymbol)\(String(format: "%.0f", tip.potentialSavings))")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
                
                Spacer()
            }
        }
        .padding()
        .background(Color.yellow.opacity(0.1))
        .cornerRadius(12)
    }
}

extension ShoppingItem.ItemCategory: CaseIterable {
    static var allCases: [ShoppingItem.ItemCategory] {
        [.vegetables, .fruits, .proteins, .grains, .dairy, .spices, .other]
    }
}



