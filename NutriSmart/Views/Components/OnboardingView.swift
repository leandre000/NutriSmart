//
//  OnboardingView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isPresented: Bool
    @State private var currentPage = 0
    
    var body: some View {
        TabView(selection: $currentPage) {
            OnboardingPage(
                title: "onboarding_title_1".localized,
                description: "onboarding_desc_1".localized,
                imageName: "heart.fill",
                color: .red
            )
            .tag(0)
            
            OnboardingPage(
                title: "onboarding_title_2".localized,
                description: "onboarding_desc_2".localized,
                imageName: "dollarsign.circle.fill",
                color: .green
            )
            .tag(1)
            
            OnboardingPage(
                title: "onboarding_title_3".localized,
                description: "onboarding_desc_3".localized,
                imageName: "globe.americas.fill",
                color: .blue
            )
            .tag(2)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .overlay(
            VStack {
                Spacer()
                Button(action: {
                    if currentPage < 2 {
                        withAnimation {
                            currentPage += 1
                        }
                    } else {
                        isPresented = false
                    }
                }) {
                    Text(currentPage < 2 ? "next".localized : "get_started".localized)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding()
            }
        )
    }
}

struct OnboardingPage: View {
    let title: String
    let description: String
    let imageName: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(systemName: imageName)
                .font(.system(size: 80))
                .foregroundColor(color)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}



