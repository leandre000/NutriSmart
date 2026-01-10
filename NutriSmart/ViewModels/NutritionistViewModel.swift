//
//  NutritionistViewModel.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation
import SwiftUI

class NutritionistViewModel: ObservableObject {
    @Published var nutritionists: [Nutritionist] = []
    @Published var selectedNutritionist: Nutritionist?
    @Published var chatMessages: [ChatMessage] = []
    @Published var isChatActive: Bool = false
    
    private let dataService = DataService.shared
    
    init() {
        loadNutritionists()
    }
    
    private func loadNutritionists() {
        nutritionists = dataService.nutritionists
    }
    
    func requestAdvice(from nutritionist: Nutritionist) {
        selectedNutritionist = nutritionist
        isChatActive = true
        
        // Mock initial message
        let welcomeMessage = ChatMessage(
            id: UUID().uuidString,
            text: "Hello! I'm \(nutritionist.name). How can I help you with your nutrition goals today?",
            isFromUser: false,
            timestamp: Date()
        )
        chatMessages = [welcomeMessage]
    }
    
    func sendMessage(_ text: String) {
        guard !text.isEmpty else { return }
        
        let userMessage = ChatMessage(
            id: UUID().uuidString,
            text: text,
            isFromUser: true,
            timestamp: Date()
        )
        chatMessages.append(userMessage)
        
        // Mock response after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let response = self.generateMockResponse(to: text)
            let botMessage = ChatMessage(
                id: UUID().uuidString,
                text: response,
                isFromUser: false,
                timestamp: Date()
            )
            self.chatMessages.append(botMessage)
        }
    }
    
    private func generateMockResponse(to input: String) -> String {
        let lowercased = input.lowercased()
        
        if lowercased.contains("budget") || lowercased.contains("cost") || lowercased.contains("price") {
            return "I understand budget concerns. Let's focus on affordable, nutrient-dense local foods. Beans, lentils, and seasonal vegetables are excellent choices that provide great nutrition at low cost."
        } else if lowercased.contains("weight") {
            return "For healthy weight management, focus on balanced meals with adequate protein, fiber, and portion control. Regular physical activity combined with nutritious meals will help you reach your goals."
        } else if lowercased.contains("anemia") || lowercased.contains("iron") {
            return "To prevent anemia, include iron-rich foods like beans, dark leafy greens, and lean meats. Pair them with vitamin C sources like tomatoes or citrus fruits to enhance iron absorption."
        } else if lowercased.contains("diabetes") || lowercased.contains("blood sugar") {
            return "For diabetes management, choose whole grains, legumes, and non-starchy vegetables. Avoid processed foods and control portion sizes. Regular monitoring and meal timing are also important."
        } else {
            return "That's a great question! Based on your profile, I recommend focusing on balanced meals with local, seasonal ingredients. Would you like specific meal suggestions for your health goals?"
        }
    }
}

struct ChatMessage: Identifiable {
    let id: String
    let text: String
    let isFromUser: Bool
    let timestamp: Date
}

