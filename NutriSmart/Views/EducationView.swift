//
//  EducationView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct EducationView: View {
    @StateObject private var dataService = DataService.shared
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Malnutrition Prevention Section
                    malnutritionPreventionSection
                    
                    // Balanced Diet Section
                    balancedDietSection
                    
                    // Daily Tips
                    dailyTipsSection
                }
                .padding()
            }
            .navigationTitle("Nutrition Education")
        }
    }
    
    private var malnutritionPreventionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Preventing Malnutrition")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 12) {
                EducationCard(
                    icon: "exclamationmark.triangle.fill",
                    title: "Recognize the Signs",
                    content: "Early signs include fatigue, weakness, frequent infections, and slow wound healing. Children may show stunted growth or delayed development."
                )
                
                EducationCard(
                    icon: "leaf.fill",
                    title: "Eat Diverse Foods",
                    content: "Include foods from all groups: proteins (beans, fish, eggs), carbohydrates (rice, maize, potatoes), vegetables, fruits, and healthy fats."
                )
                
                EducationCard(
                    icon: "heart.fill",
                    title: "Focus on Nutrient Density",
                    content: "Choose foods rich in vitamins and minerals. Dark leafy greens, beans, and whole grains provide essential nutrients without high costs."
                )
            }
        }
    }
    
    private var balancedDietSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Understanding Balanced Diets")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 12) {
                EducationCard(
                    icon: "chart.pie.fill",
                    title: "Macronutrients",
                    content: "Your body needs proteins (for muscle), carbohydrates (for energy), and fats (for brain health). Aim for balanced portions of each."
                )
                
                EducationCard(
                    icon: "sparkles",
                    title: "Micronutrients",
                    content: "Vitamins and minerals are essential in small amounts. Iron prevents anemia, calcium builds bones, and vitamin C boosts immunity."
                )
                
                EducationCard(
                    icon: "clock.fill",
                    title: "Meal Timing",
                    content: "Eat regular meals throughout the day. Don't skip breakfast - it kickstarts your metabolism and provides energy for the day."
                )
            }
        }
    }
    
    private var dailyTipsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Daily Health Tips")
                .font(.title2)
                .fontWeight(.bold)
            
            ForEach(dataService.healthTips.prefix(5)) { tip in
                HealthTipCard(tip: tip)
            }
        }
    }
}

struct EducationCard: View {
    let icon: String
    let title: String
    let content: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                
                Text(content)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

