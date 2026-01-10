//
//  FamilyNutritionView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct FamilyNutritionView: View {
    @StateObject private var viewModel: FamilyNutritionViewModel
    @State private var showingAddChild = false
    @State private var showingPregnancySetup = false
    let user: User
    
    init(user: User) {
        self.user = user
        _viewModel = StateObject(wrappedValue: FamilyNutritionViewModel(user: user))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Mode Selector
                    modeSelector
                    
                    // Family Members
                    if viewModel.familyMode != .individual {
                        familyMembersSection
                    }
                    
                    // Meal Plans
                    if !viewModel.familyMealPlans.isEmpty {
                        mealPlansSection
                    }
                    
                    // Generate Plan Button
                    generatePlanButton
                }
                .padding()
            }
            .navigationTitle("family_nutrition".localized)
            .sheet(isPresented: $showingAddChild) {
                AddChildView(viewModel: viewModel)
            }
            .sheet(isPresented: $showingPregnancySetup) {
                PregnancySetupView(viewModel: viewModel)
            }
        }
    }
    
    private var modeSelector: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("select_mode".localized)
                .font(.headline)
            
            ForEach(FamilyMode.allCases, id: \.self) { mode in
                Button(action: {
                    withAnimation(.spring(response: 0.3)) {
                        viewModel.familyMode = mode
                    }
                }) {
                    HStack {
                        Image(systemName: mode.icon)
                            .foregroundColor(viewModel.familyMode == mode ? .white : .blue)
                            .frame(width: 30)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(mode.rawValue)
                                .font(.headline)
                                .foregroundColor(viewModel.familyMode == mode ? .white : .primary)
                            
                            Text(mode.description)
                                .font(.caption)
                                .foregroundColor(viewModel.familyMode == mode ? .white.opacity(0.9) : .secondary)
                        }
                        
                        Spacer()
                        
                        if viewModel.familyMode == mode {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(viewModel.familyMode == mode ? Color.blue : Color(.systemGray6))
                    .cornerRadius(12)
                }
            }
        }
    }
    
    private var familyMembersSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("family_members".localized)
                    .font(.headline)
                
                Spacer()
                
                if viewModel.familyMode == .child || viewModel.familyMode == .family {
                    Button(action: {
                        showingAddChild = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title3)
                    }
                }
            }
            
            if viewModel.familyMode == .pregnancy, let profile = viewModel.pregnancyProfile {
                PregnancyProfileCard(profile: profile)
            }
            
            ForEach(viewModel.children) { child in
                ChildProfileCard(child: child) {
                    viewModel.removeChild(child)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    private var mealPlansSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("family_meal_plans".localized)
                .font(.headline)
            
            ForEach(viewModel.familyMealPlans) { plan in
                FamilyMealPlanCard(plan: plan, user: user)
            }
        }
    }
    
    private var generatePlanButton: some View {
        Button(action: {
            withAnimation {
                viewModel.generateFamilyMealPlan(for: Date())
            }
        }) {
            HStack {
                Image(systemName: "calendar.badge.plus")
                Text("generate_family_plan".localized)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .cornerRadius(12)
        }
    }
}

struct ChildProfileCard: View {
    let child: ChildProfile
    let onRemove: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "figure.child")
                .font(.title2)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(child.name)
                    .font(.headline)
                Text("\(child.age) " + (child.age < 12 ? "months" : "years"))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: onRemove) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

struct PregnancyProfileCard: View {
    let profile: PregnancyProfile
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(.pink)
                Text("pregnancy".localized)
                    .font(.headline)
            }
            
            Text("trimester".localized + " \(profile.trimester), " + "week".localized + " \(profile.weeksPregnant)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if profile.hasGestationalDiabetes || profile.hasAnemia {
                HStack {
                    if profile.hasGestationalDiabetes {
                        Label("gestational_diabetes".localized, systemImage: "cross.case.fill")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }
                    if profile.hasAnemia {
                        Label("anemia".localized, systemImage: "drop.fill")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

struct FamilyMealPlanCard: View {
    let plan: FamilyMealPlan
    let user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(plan.date, style: .date)
                    .font(.headline)
                Spacer()
                Text("\(user.country.currencySymbol)\(String(format: "%.2f", plan.totalCost))")
                    .font(.subheadline)
                    .foregroundColor(.green)
            }
            
            Text("serves".localized + " \(plan.servesCount) " + "people".localized)
                .font(.caption)
                .foregroundColor(.secondary)
            
            ForEach(plan.meals) { meal in
                HStack {
                    Image(systemName: meal.childFriendly ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(meal.childFriendly ? .green : .gray)
                    Text(meal.baseMeal.name)
                        .font(.subheadline)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct AddChildView: View {
    @ObservedObject var viewModel: FamilyNutritionViewModel
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var age = 2
    @State private var gender: Gender = .male
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("child_info".localized)) {
                    TextField("name".localized, text: $name)
                    Stepper("age".localized + ": \(age)", value: $age, in: 0...18)
                    Picker("gender".localized, selection: $gender) {
                        ForEach(Gender.allCases, id: \.self) { g in
                            Text(g.rawValue).tag(g)
                        }
                    }
                }
            }
            .navigationTitle("add_child".localized)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("add".localized) {
                        let child = ChildProfile(
                            id: UUID(),
                            name: name,
                            age: age,
                            gender: gender,
                            specialNeeds: [],
                            favoriteFoods: [],
                            allergies: []
                        )
                        viewModel.addChild(child)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}

struct PregnancySetupView: View {
    @ObservedObject var viewModel: FamilyNutritionViewModel
    @Environment(\.dismiss) var dismiss
    @State private var trimester = 1
    @State private var weeks = 12
    @State private var hasDiabetes = false
    @State private var hasAnemia = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("pregnancy_info".localized)) {
                    Picker("trimester".localized, selection: $trimester) {
                        Text("1").tag(1)
                        Text("2").tag(2)
                        Text("3").tag(3)
                    }
                    Stepper("weeks".localized + ": \(weeks)", value: $weeks, in: 1...40)
                    Toggle("gestational_diabetes".localized, isOn: $hasDiabetes)
                    Toggle("anemia".localized, isOn: $hasAnemia)
                }
            }
            .navigationTitle("pregnancy_setup".localized)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("save".localized) {
                        let profile = PregnancyProfile(
                            trimester: trimester,
                            weeksPregnant: weeks,
                            hasGestationalDiabetes: hasDiabetes,
                            hasAnemia: hasAnemia,
                            specialRequirements: []
                        )
                        viewModel.setPregnancyProfile(profile)
                        dismiss()
                    }
                }
            }
        }
    }
}

