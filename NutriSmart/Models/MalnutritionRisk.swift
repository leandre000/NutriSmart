//
//  MalnutritionRisk.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation

struct MalnutritionRiskAssessment: Identifiable, Codable {
    let id: UUID
    let riskLevel: RiskLevel
    let score: Int // 0-100
    let factors: [RiskFactor]
    let recommendations: [String]
    let dateAssessed: Date
    
    enum RiskLevel: String, Codable {
        case low = "Low"
        case medium = "Medium"
        case high = "High"
        
        var color: String {
            switch self {
            case .low: return "green"
            case .medium: return "orange"
            case .high: return "red"
            }
        }
        
        var icon: String {
            switch self {
            case .low: return "checkmark.circle.fill"
            case .medium: return "exclamationmark.triangle.fill"
            case .high: return "exclamationmark.octagon.fill"
            }
        }
    }
}

struct RiskFactor: Identifiable, Codable {
    let id: UUID
    let category: FactorCategory
    let description: String
    let severity: Int // 1-5
    let actionable: Bool
    
    enum FactorCategory: String, Codable {
        case dietary = "Dietary Intake"
        case economic = "Economic Access"
        case health = "Health Status"
        case knowledge = "Nutrition Knowledge"
        case social = "Social Support"
    }
}

struct AssessmentQuestion: Identifiable {
    let id: UUID
    let question: String
    let category: RiskFactor.FactorCategory
    let options: [AssessmentOption]
    let weight: Int // 1-10, importance weight
}

struct AssessmentOption: Identifiable {
    let id: UUID
    let text: String
    let score: Int // 0-10, higher = more risk
}



