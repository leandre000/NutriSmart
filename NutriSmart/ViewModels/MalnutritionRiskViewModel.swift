//
//  MalnutritionRiskViewModel.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation
import SwiftUI

class MalnutritionRiskViewModel: ObservableObject {
    @Published var currentAssessment: MalnutritionRiskAssessment?
    @Published var questions: [AssessmentQuestion] = []
    @Published var answers: [UUID: Int] = [:]
    @Published var currentQuestionIndex: Int = 0
    @Published var isAssessmentComplete: Bool = false
    
    private let user: User
    
    init(user: User) {
        self.user = user
        loadQuestions()
    }
    
    func loadQuestions() {
        questions = generateAssessmentQuestions()
    }
    
    func answerQuestion(questionId: UUID, optionScore: Int) {
        answers[questionId] = optionScore
        if currentQuestionIndex < questions.count - 1 {
            withAnimation {
                currentQuestionIndex += 1
            }
        } else {
            completeAssessment()
        }
    }
    
    func completeAssessment() {
        let score = calculateRiskScore()
        let riskLevel = determineRiskLevel(score: score)
        let factors = identifyRiskFactors(score: score)
        let recommendations = generateRecommendations(riskLevel: riskLevel, factors: factors)
        
        currentAssessment = MalnutritionRiskAssessment(
            id: UUID(),
            riskLevel: riskLevel,
            score: score,
            factors: factors,
            recommendations: recommendations,
            dateAssessed: Date()
        )
        
        isAssessmentComplete = true
    }
    
    func resetAssessment() {
        answers = [:]
        currentQuestionIndex = 0
        currentAssessment = nil
        isAssessmentComplete = false
    }
    
    private func calculateRiskScore() -> Int {
        var totalScore = 0
        var totalWeight = 0
        
        for question in questions {
            if let answerScore = answers[question.id] {
                totalScore += answerScore * question.weight
                totalWeight += question.weight
            }
        }
        
        guard totalWeight > 0 else { return 0 }
        return min(100, (totalScore * 100) / (totalWeight * 10))
    }
    
    private func determineRiskLevel(score: Int) -> MalnutritionRiskAssessment.RiskLevel {
        if score < 30 {
            return .low
        } else if score < 60 {
            return .medium
        } else {
            return .high
        }
    }
    
    private func identifyRiskFactors(score: Int) -> [RiskFactor] {
        var factors: [RiskFactor] = []
        
        // Dietary factors
        if user.monthlyBudget < 30000 {
            factors.append(RiskFactor(
                id: UUID(),
                category: .economic,
                description: "Limited food budget may restrict access to diverse foods",
                severity: 4,
                actionable: true
            ))
        }
        
        // Health goal factors
        if user.healthGoal == .anemiaPrevention {
            factors.append(RiskFactor(
                id: UUID(),
                category: .health,
                description: "Focusing on anemia prevention indicates potential risk",
                severity: 3,
                actionable: true
            ))
        }
        
        // Age factors
        if user.age < 5 || user.age > 65 {
            factors.append(RiskFactor(
                id: UUID(),
                category: .health,
                description: "Age group may have higher nutritional needs",
                severity: 2,
                actionable: true
            ))
        }
        
        return factors
    }
    
    private func generateRecommendations(riskLevel: MalnutritionRiskAssessment.RiskLevel, factors: [RiskFactor]) -> [String] {
        var recommendations: [String] = []
        
        switch riskLevel {
        case .low:
            recommendations.append("Continue maintaining a balanced diet with diverse foods")
            recommendations.append("Regular health check-ups are recommended")
        case .medium:
            recommendations.append("Increase intake of protein-rich foods like beans, lentils, and eggs")
            recommendations.append("Include more fruits and vegetables in daily meals")
            recommendations.append("Consider consulting a nutritionist for personalized advice")
        case .high:
            recommendations.append("Seek immediate consultation with a healthcare provider or nutritionist")
            recommendations.append("Focus on nutrient-dense foods within your budget")
            recommendations.append("Consider community nutrition programs if available")
            recommendations.append("Monitor weight and health indicators regularly")
        }
        
        // Add specific recommendations based on factors
        if factors.contains(where: { $0.category == .economic }) {
            recommendations.append("Look for budget-friendly protein sources like beans and local vegetables")
            recommendations.append("Plan meals around seasonal and locally available foods")
        }
        
        return recommendations
    }
    
    private func generateAssessmentQuestions() -> [AssessmentQuestion] {
        return [
            AssessmentQuestion(
                id: UUID(),
                question: "How many meals do you typically eat per day?",
                category: .dietary,
                options: [
                    AssessmentOption(id: UUID(), text: "3 or more meals", score: 0),
                    AssessmentOption(id: UUID(), text: "2 meals", score: 3),
                    AssessmentOption(id: UUID(), text: "1 meal", score: 7),
                    AssessmentOption(id: UUID(), text: "Less than 1 meal", score: 10)
                ],
                weight: 8
            ),
            AssessmentQuestion(
                id: UUID(),
                question: "Do you include protein sources (meat, fish, beans, eggs) in your meals?",
                category: .dietary,
                options: [
                    AssessmentOption(id: UUID(), text: "Daily", score: 0),
                    AssessmentOption(id: UUID(), text: "3-4 times per week", score: 2),
                    AssessmentOption(id: UUID(), text: "1-2 times per week", score: 5),
                    AssessmentOption(id: UUID(), text: "Rarely or never", score: 8)
                ],
                weight: 9
            ),
            AssessmentQuestion(
                id: UUID(),
                question: "How often do you eat fruits and vegetables?",
                category: .dietary,
                options: [
                    AssessmentOption(id: UUID(), text: "Daily", score: 0),
                    AssessmentOption(id: UUID(), text: "3-4 times per week", score: 2),
                    AssessmentOption(id: UUID(), text: "1-2 times per week", score: 5),
                    AssessmentOption(id: UUID(), text: "Rarely or never", score: 8)
                ],
                weight: 7
            ),
            AssessmentQuestion(
                id: UUID(),
                question: "Have you experienced significant weight loss recently?",
                category: .health,
                options: [
                    AssessmentOption(id: UUID(), text: "No", score: 0),
                    AssessmentOption(id: UUID(), text: "Slight weight loss", score: 3),
                    AssessmentOption(id: UUID(), text: "Moderate weight loss", score: 6),
                    AssessmentOption(id: UUID(), text: "Significant weight loss", score: 10)
                ],
                weight: 8
            ),
            AssessmentQuestion(
                id: UUID(),
                question: "Do you feel tired or weak often?",
                category: .health,
                options: [
                    AssessmentOption(id: UUID(), text: "Rarely", score: 0),
                    AssessmentOption(id: UUID(), text: "Sometimes", score: 3),
                    AssessmentOption(id: UUID(), text: "Often", score: 6),
                    AssessmentOption(id: UUID(), text: "Very often", score: 9)
                ],
                weight: 6
            )
        ]
    }
}


