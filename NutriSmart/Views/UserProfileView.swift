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
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    // Age
                    HStack {
                        Text("Age")
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
                        Picker("Gender", selection: $viewModel.user.gender) {
                            ForEach(Gender.allCases, id: \.self) { gender in
                                Text(gender.rawValue).tag(gender)
                            }
                        }
                    } else {
                        HStack {
                            Text("Gender")
                            Spacer()
                            Text(viewModel.user.gender.rawValue)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section(header: Text("Location & Preferences")) {
                    // Country
                    if viewModel.isEditing {
                        Picker("Country", selection: $viewModel.selectedCountry) {
                            ForEach(Country.allCountries, id: \.self) { country in
                                Text(country.name).tag(country)
                            }
                        }
                    } else {
                        HStack {
                            Text("Country")
                            Spacer()
                            Text(viewModel.user.country.name)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // Health Goal
                    if viewModel.isEditing {
                        Picker("Health Goal", selection: $viewModel.selectedHealthGoal) {
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
                            Text("Health Goal")
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
                
                Section(header: Text("Budget")) {
                    if viewModel.isEditing {
                        TextField("Monthly Budget", text: $viewModel.monthlyBudgetText)
                            .keyboardType(.decimalPad)
                    } else {
                        HStack {
                            Text("Monthly Budget")
                            Spacer()
                            Text("\(viewModel.user.country.currencySymbol)\(String(format: "%.2f", viewModel.user.monthlyBudget))")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    if !viewModel.isEditing {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("Weekly Budget:")
                                Spacer()
                                Text("\(viewModel.user.country.currencySymbol)\(String(format: "%.2f", viewModel.user.weeklyBudget))")
                                    .foregroundColor(.secondary)
                            }
                            
                            HStack {
                                Text("Daily Budget:")
                                Spacer()
                                Text("\(viewModel.user.country.currencySymbol)\(String(format: "%.2f", viewModel.user.dailyBudget))")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .font(.caption)
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(viewModel.isEditing ? "Save" : "Edit") {
                        if viewModel.isEditing {
                            viewModel.saveProfile()
                        } else {
                            viewModel.isEditing = true
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
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

