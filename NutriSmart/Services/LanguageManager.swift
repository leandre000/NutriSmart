//
//  LanguageManager.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation
import SwiftUI

enum AppLanguage: String, CaseIterable, Identifiable {
    case english = "en"
    case kinyarwanda = "rw"
    case french = "fr"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .english: return "English"
        case .kinyarwanda: return "Ikinyarwanda"
        case .french: return "Français"
        }
    }
    
    var nativeName: String {
        switch self {
        case .english: return "English"
        case .kinyarwanda: return "Ikinyarwanda"
        case .french: return "Français"
        }
    }
}

class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    
    @Published var currentLanguage: AppLanguage {
        didSet {
            UserDefaults.standard.set(currentLanguage.rawValue, forKey: "app_language")
        }
    }
    
    private init() {
        if let savedLanguage = UserDefaults.standard.string(forKey: "app_language"),
           let language = AppLanguage(rawValue: savedLanguage) {
            self.currentLanguage = language
        } else {
            // Detect system language
            let systemLanguage = Locale.current.languageCode ?? "en"
            self.currentLanguage = AppLanguage(rawValue: systemLanguage) ?? .english
        }
    }
    
    func localized(_ key: String) -> String {
        return LocalizedStrings.shared.getString(for: key, language: currentLanguage)
    }
}

class LocalizedStrings {
    static let shared = LocalizedStrings()
    
    private init() {}
    
    func getString(for key: String, language: AppLanguage) -> String {
        let strings: [String: [String: String]] = [
            "app_name": [
                "en": "NutriSmart",
                "rw": "NutriSmart",
                "fr": "NutriSmart"
            ],
            "welcome_back": [
                "en": "Welcome back!",
                "rw": "Murakaza neza!",
                "fr": "Bon retour !"
            ],
            "personalized_meal_plan": [
                "en": "Here's your personalized meal plan for",
                "rw": "Dore gahunda yanyu y'ibiribwa byihariye kuri",
                "fr": "Voici votre plan de repas personnalisé pour"
            ],
            "todays_meals": [
                "en": "Today's Meals",
                "rw": "Ibiribwa by'uyu munsi",
                "fr": "Repas d'aujourd'hui"
            ],
            "daily_budget": [
                "en": "Daily Budget",
                "rw": "Budegeti y'umunsi",
                "fr": "Budget quotidien"
            ],
            "remaining": [
                "en": "Remaining",
                "rw": "Bisigaye",
                "fr": "Restant"
            ],
            "budget_exceeded": [
                "en": "Budget Exceeded",
                "rw": "Budegeti yarenze",
                "fr": "Budget dépassé"
            ],
            "calories": [
                "en": "Calories",
                "rw": "Kalori",
                "fr": "Calories"
            ],
            "protein": [
                "en": "Protein",
                "rw": "Proteine",
                "fr": "Protéines"
            ],
            "carbohydrates": [
                "en": "Carbohydrates",
                "rw": "Karbohydrate",
                "fr": "Glucides"
            ],
            "fats": [
                "en": "Fats",
                "rw": "Mafuta",
                "fr": "Lipides"
            ],
            "ingredients": [
                "en": "Ingredients",
                "rw": "Ibiribwa",
                "fr": "Ingrédients"
            ],
            "preparation_steps": [
                "en": "Preparation Steps",
                "rw": "Inzira zo gutegura",
                "fr": "Étapes de préparation"
            ],
            "health_benefits": [
                "en": "Health Benefits",
                "rw": "Incamake z'ubuzima",
                "fr": "Bienfaits pour la santé"
            ],
            "nutrition_information": [
                "en": "Nutrition Information",
                "rw": "Amakuru y'ibiribwa",
                "fr": "Informations nutritionnelles"
            ],
            "key_nutrients": [
                "en": "Key Nutrients",
                "rw": "Ibiribwa by'ingenzi",
                "fr": "Nutriments clés"
            ],
            "profile": [
                "en": "Profile",
                "rw": "Profayili",
                "fr": "Profil"
            ],
            "edit": [
                "en": "Edit",
                "rw": "Guhindura",
                "fr": "Modifier"
            ],
            "save": [
                "en": "Save",
                "rw": "Bika",
                "fr": "Enregistrer"
            ],
            "done": [
                "en": "Done",
                "rw": "Byarangiye",
                "fr": "Terminé"
            ],
            "age": [
                "en": "Age",
                "rw": "Imyaka",
                "fr": "Âge"
            ],
            "gender": [
                "en": "Gender",
                "rw": "Ubwoko",
                "fr": "Genre"
            ],
            "country": [
                "en": "Country",
                "rw": "Igihugu",
                "fr": "Pays"
            ],
            "health_goal": [
                "en": "Health Goal",
                "rw": "Intego y'ubuzima",
                "fr": "Objectif de santé"
            ],
            "monthly_budget": [
                "en": "Monthly Budget",
                "rw": "Budegeti y'ukwezi",
                "fr": "Budget mensuel"
            ],
            "weekly_budget": [
                "en": "Weekly Budget",
                "rw": "Budegeti y'icyumweru",
                "fr": "Budget hebdomadaire"
            ],
            "language": [
                "en": "Language",
                "rw": "Ururimi",
                "fr": "Langue"
            ],
            "select_language": [
                "en": "Select Language",
                "rw": "Hitamo ururimi",
                "fr": "Sélectionner la langue"
            ],
            "home": [
                "en": "Home",
                "rw": "Ahabanza",
                "fr": "Accueil"
            ],
            "meal_plan": [
                "en": "Meal Plan",
                "rw": "Gahunda y'ibiribwa",
                "fr": "Plan de repas"
            ],
            "nutritionists": [
                "en": "Nutritionists",
                "rw": "Abahanga mu biribwa",
                "fr": "Nutritionnistes"
            ],
            "community": [
                "en": "Community",
                "rw": "Abantu",
                "fr": "Communauté"
            ],
            "learn": [
                "en": "Learn",
                "rw": "Wiga",
                "fr": "Apprendre"
            ],
            "similar_meals": [
                "en": "Similar Meals",
                "rw": "Ibiribwa bifitanye isano",
                "fr": "Repas similaires"
            ],
            "servings": [
                "en": "servings",
                "rw": "imirimo",
                "fr": "portions"
            ],
            "min": [
                "en": "min",
                "rw": "min",
                "fr": "min"
            ],
            "loading": [
                "en": "Loading...",
                "rw": "Birakura...",
                "fr": "Chargement..."
            ],
            "request_advice": [
                "en": "Request Advice",
                "rw": "Saba inama",
                "fr": "Demander conseil"
            ],
            "type_message": [
                "en": "Type your message...",
                "rw": "Andika ubutumwa bwawe...",
                "fr": "Tapez votre message..."
            ],
            "weekly_meal_plan": [
                "en": "Weekly Meal Plan",
                "rw": "Gahunda y'ibiribwa y'icyumweru",
                "fr": "Plan de repas hebdomadaire"
            ],
            "avg_daily_cost": [
                "en": "Avg. Daily Cost",
                "rw": "Agaciro gacyiciro cy'umunsi",
                "fr": "Coût quotidien moyen"
            ],
            "total_calories": [
                "en": "Total Calories",
                "rw": "Kalori zose",
                "fr": "Calories totales"
            ],
            "nutrition_education": [
                "en": "Nutrition Education",
                "rw": "Kwiga ibiribwa",
                "fr": "Éducation nutritionnelle"
            ],
            "preventing_malnutrition": [
                "en": "Preventing Malnutrition",
                "rw": "Kurwanya indwara ziterwa n'ibiribwa",
                "fr": "Prévenir la malnutrition"
            ],
            "understanding_balanced_diets": [
                "en": "Understanding Balanced Diets",
                "rw": "Gusobanukirwa ibiribwa byuzuye",
                "fr": "Comprendre les régimes équilibrés"
            ],
            "daily_health_tips": [
                "en": "Daily Health Tips",
                "rw": "Inama z'ubuzima z'umunsi",
                "fr": "Conseils de santé quotidiens"
            ],
            "settings": [
                "en": "Settings",
                "rw": "Igenamiterere",
                "fr": "Paramètres"
            ],
            "about": [
                "en": "About",
                "rw": "Ibyerekeye",
                "fr": "À propos"
            ],
            "version": [
                "en": "Version",
                "rw": "Verisiyo",
                "fr": "Version"
            ],
            "build": [
                "en": "Build",
                "rw": "Gubaka",
                "fr": "Version"
            ],
            "personal_information": [
                "en": "Personal Information",
                "rw": "Amakuru y'umuntu",
                "fr": "Informations personnelles"
            ],
            "location_preferences": [
                "en": "Location & Preferences",
                "rw": "Aho utuye n'ibyifuzo",
                "fr": "Localisation et préférences"
            ],
            "budget": [
                "en": "Budget",
                "rw": "Budegeti",
                "fr": "Budget"
            ],
            "daily_budget": [
                "en": "Daily Budget",
                "rw": "Budegeti y'umunsi",
                "fr": "Budget quotidien"
            ],
            "retry": [
                "en": "Retry",
                "rw": "Ongera ugerageze",
                "fr": "Réessayer"
            ],
            "week_overview": [
                "en": "Week Overview",
                "rw": "Incamake y'icyumweru",
                "fr": "Aperçu de la semaine"
            ],
            "carbs": [
                "en": "Carbs",
                "rw": "Karbohydrate",
                "fr": "Glucides"
            ],
            "onboarding_title_1": [
                "en": "Plan Healthy Meals",
                "rw": "Tegura ibiribwa byiza",
                "fr": "Planifiez des repas sains"
            ],
            "onboarding_desc_1": [
                "en": "Get personalized meal plans based on your health goals, budget, and local foods available in your country.",
                "rw": "Habwa gahunda y'ibiribwa byihariye ku bijyanye n'intego z'ubuzima, budegeti, n'ibiribwa byo mu gihugu cyawe.",
                "fr": "Obtenez des plans de repas personnalisés basés sur vos objectifs de santé, votre budget et les aliments locaux disponibles dans votre pays."
            ],
            "onboarding_title_2": [
                "en": "Stay Within Budget",
                "rw": "Komeza mu budegeti",
                "fr": "Rester dans le budget"
            ],
            "onboarding_desc_2": [
                "en": "Track your daily food spending and get alerts when you're approaching your budget limit. Find affordable healthy alternatives.",
                "rw": "Kurikirana amafaranga wakoresha mu biribwa by'umunsi kandi uhabwe amakuru igihe wagerageje budegeti. Shakisha ibindi biribwa byiza kandi bifite agaciro gato.",
                "fr": "Suivez vos dépenses alimentaires quotidiennes et recevez des alertes lorsque vous approchez de votre limite budgétaire. Trouvez des alternatives saines et abordables."
            ],
            "onboarding_title_3": [
                "en": "Local & Cultural Foods",
                "rw": "Ibiribwa byo mu gihugu",
                "fr": "Aliments locaux et culturels"
            ],
            "onboarding_desc_3": [
                "en": "Meals adapt to your country with culturally appropriate and locally available ingredients. Support local farmers and your health!",
                "rw": "Ibiribwa bihaguruka ku gihugu cyawe bikoresheje ibiribwa byo mu gihugu. Gufasha aborozi bo mu gihugu n'ubuzima bwawe!",
                "fr": "Les repas s'adaptent à votre pays avec des ingrédients culturellement appropriés et disponibles localement. Soutenez les agriculteurs locaux et votre santé !"
            ],
            "next": [
                "en": "Next",
                "rw": "Ibikurikira",
                "fr": "Suivant"
            ],
            "get_started": [
                "en": "Get Started",
                "rw": "Tangira",
                "fr": "Commencer"
            ]
        ]
        
        return strings[key]?[language.rawValue] ?? key
    }
}

// Extension for easy access
extension String {
    var localized: String {
        LanguageManager.shared.localized(self)
    }
}

