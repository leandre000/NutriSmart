//
//  UserProfileView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct UserProfileView: View {
    @ObservedObject var viewModel: UserProfileViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showingSettings = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                Form {
                    Section(header: Text("personal_information".localized)) {
                    // Age
                    HStack {
                        Text("age".localized)
                        Spacer()
                        if viewModel.isEditing {
                            Stepper("\(viewModel.user.age)", value: Binding(
                                get: { viewModel.user.age },
                                set: { viewModel.updateAge($0) }
                            ), in: 1...120)
                        } else {
                            Text("\(viewModel.user.age)")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // Gender
                    if viewModel.isEditing {
                        Picker("gender".localized, selection: $viewModel.user.gender) {
                            ForEach(Gender.allCases, id: \.self) { gender in
                                Text(gender.rawValue).tag(gender)
                            }
                        }
                    } else {
                        HStack {
                            Text("gender".localized)
                            Spacer()
                            Text(viewModel.user.gender.rawValue)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section(header: Text("location_preferences".localized)) {
                    // Country
                    if viewModel.isEditing {
                        Picker("country".localized, selection: $viewModel.selectedCountry) {
                            ForEach(Country.allCountries, id: \.self) { country in
                                Text(country.name).tag(country)
                            }
                        }
                    } else {
                        HStack {
                            Text("country".localized)
                            Spacer()
                            Text(viewModel.user.country.name)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // Health Goal
                    if viewModel.isEditing {
                        Picker("health_goal".localized, selection: $viewModel.selectedHealthGoal) {
                            ForEach(HealthGoal.allCases, id: \.self) { goal in
                                HStack {
                                    Image(systemName: goal.icon)
                                    Text(goal.rawValue)
                                }
                                .tag(goal)
                            }
                        }
                    } else {
                        HStack {
                            Text("health_goal".localized)
                            Spacer()
                            HStack(spacing: 4) {
                                Image(systemName: viewModel.user.healthGoal.icon)
                                Text(viewModel.user.healthGoal.rawValue)
                            }
                            .foregroundColor(.secondary)
                        }
                    }
                    
                    if !viewModel.isEditing {
                        Text(viewModel.user.healthGoal.description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Section(header: Text("budget".localized)) {
                    if viewModel.isEditing {
                        TextField("monthly_budget".localized, text: $viewModel.monthlyBudgetText)
                            .keyboardType(.decimalPad)
                    } else {
                        HStack {
                            Text("monthly_budget".localized)
                            Spacer()
                            Text("\(viewModel.user.country.currencySymbol)\(String(format: "%.2f", viewModel.user.monthlyBudget))")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    if !viewModel.isEditing {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("weekly_budget".localized + ":")
                                Spacer()
                                Text("\(viewModel.user.country.currencySymbol)\(String(format: "%.2f", viewModel.user.weeklyBudget))")
                                    .foregroundColor(.secondary)
                            }
                            
                            HStack {
                                Text("daily_budget".localized + ":")
                                Spacer()
                                Text("\(viewModel.user.country.currencySymbol)\(String(format: "%.2f", viewModel.user.dailyBudget))")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .font(.caption)
                    }
                }
                }
            }
            .navigationTitle("profile".localized)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(viewModel.isEditing ? "save".localized : "edit".localized) {
                        if viewModel.isEditing {
                            viewModel.saveProfile()
                        } else {
                            viewModel.isEditing = true
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("done".localized) {
                        if viewModel.isEditing {
                            viewModel.saveProfile()
                        }
                        dismiss()
                    }
                }
            }
        }
    }
}

