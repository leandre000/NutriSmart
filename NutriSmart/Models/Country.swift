//
//  Country.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation

struct Country: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let code: String
    let currency: String
    let currencySymbol: String
    let commonFoods: [String]
    let dietaryPreferences: [String]
    
    static let rwanda = Country(
        id: "rw",
        name: "Rwanda",
        code: "RW",
        currency: "RWF",
        currencySymbol: "RF",
        commonFoods: ["Beans", "Maize", "Sweet Potatoes", "Bananas", "Cassava", "Rice", "Vegetables"],
        dietaryPreferences: ["Plant-based", "High fiber", "Traditional"]
    )
    
    static let kenya = Country(
        id: "ke",
        name: "Kenya",
        code: "KE",
        currency: "KES",
        currencySymbol: "KSh",
        commonFoods: ["Ugali", "Sukuma Wiki", "Chapati", "Beans", "Rice", "Fish", "Vegetables"],
        dietaryPreferences: ["Traditional", "Balanced", "Spicy"]
    )
    
    static let nigeria = Country(
        id: "ng",
        name: "Nigeria",
        code: "NG",
        currency: "NGN",
        currencySymbol: "₦",
        commonFoods: ["Rice", "Beans", "Yam", "Plantain", "Fish", "Chicken", "Vegetables"],
        dietaryPreferences: ["High protein", "Traditional", "Spicy"]
    )
    
    static let india = Country(
        id: "in",
        name: "India",
        code: "IN",
        currency: "INR",
        currencySymbol: "₹",
        commonFoods: ["Rice", "Lentils", "Wheat", "Vegetables", "Spices", "Yogurt", "Fruits"],
        dietaryPreferences: ["Vegetarian-friendly", "Spicy", "Diverse"]
    )
    
    static let usa = Country(
        id: "us",
        name: "United States",
        code: "US",
        currency: "USD",
        currencySymbol: "$",
        commonFoods: ["Chicken", "Rice", "Pasta", "Vegetables", "Fruits", "Bread", "Dairy"],
        dietaryPreferences: ["Flexible", "High protein", "Diverse"]
    )
    
    static let allCountries: [Country] = [rwanda, kenya, nigeria, india, usa]
}

