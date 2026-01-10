//
//  Nutritionist.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation

struct Nutritionist: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let specialization: String
    let experience: Int // years
    let rating: Double
    let imageName: String
    let bio: String
    let languages: [String]
    let available: Bool
    let consultationFee: Double
}

struct CommunityMeal: Codable, Identifiable, Hashable {
    let id: String
    let mealName: String
    let userName: String
    let userImageName: String
    let countryId: String
    let imageName: String
    let description: String
    let likes: Int
    let datePosted: Date
    let nutrition: NutritionInfo
}

struct HealthTip: Codable, Identifiable {
    let id: String
    let title: String
    let content: String
    let category: String
    let date: Date
}

