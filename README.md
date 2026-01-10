# NutriSmart

A production-ready iOS application built with SwiftUI that helps people plan healthy, affordable meals using local foods based on their country, budget, and health goals. NutriSmart addresses global malnutrition and unhealthy eating patterns by providing personalized, culturally-relevant meal planning solutions.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Data Management](#data-management)
- [Supported Countries](#supported-countries)
- [Health Goals](#health-goals)
- [Multi-Language Support](#multi-language-support)
- [Technical Details](#technical-details)
- [Contributing](#contributing)
- [License](#license)

## Overview

NutriSmart is an award-winning nutrition application designed for real-world deployment. The app helps individuals and families plan nutritious meals that are affordable, culturally appropriate, and aligned with their health goals. With support for multiple countries, languages, and comprehensive nutrition education, NutriSmart makes healthy eating accessible to everyone.

## Features

### Core Functionality

#### User Profile Management
- Complete user profile with age, gender, and location
- Country selection for culturally-appropriate meal suggestions
- Flexible budget configuration (weekly or monthly)
- Health goal selection with personalized recommendations
- Persistent data storage using UserDefaults
- Profile editing and updates

#### Country-Based Meal Planning
- Meals automatically adapt to selected country
- Support for Rwanda, Kenya, Nigeria, India, and USA
- Culturally appropriate and locally available ingredients
- Traditional recipes with modern nutrition insights
- Breakfast, Lunch, and Dinner categories
- Budget-aware meal suggestions

#### Comprehensive Meal Details
- High-quality food images with placeholder support
- Complete ingredient lists with precise quantities
- Step-by-step preparation instructions in simple language
- Detailed nutrition breakdown:
  - Calories and macronutrients (protein, carbohydrates, fats)
  - Micronutrients (iron, calcium, vitamin C, vitamin A)
  - Fiber content
- Health benefits and nutritional advice
- Estimated preparation time and serving sizes
- Cost information with currency localization

#### Budget Management
- Daily, weekly, and monthly budget tracking
- Real-time cost monitoring for meal plans
- Visual budget progress indicators
- Budget alerts and warnings when limits are approached
- Affordable alternative meal suggestions
- Budget-saving tips and recommendations

#### Nutrition Education
- Daily health tips with actionable advice
- Malnutrition prevention information
- Balanced diet explanations for non-technical users
- Educational content on macronutrients and micronutrients
- Health benefits of different food groups
- Simple, accessible language throughout

### Advanced Features

#### Malnutrition Risk Assessment
- Simple rule-based assessment (non-diagnostic)
- Friendly risk level indicators (Low, Medium, High)
- Preventive nutrition advice based on assessment
- Personalized recommendations for improvement
- Accessible from home screen for quick checks
- Regular assessment tracking

#### Child & Family Nutrition Mode
- Child-friendly meal suggestions
- Pregnancy nutrition support with trimester-specific guidance
- Family-focused meal planning
- Multiple family member profiles
- Special dietary needs tracking (allergies, intolerances)
- Age-appropriate nutrition recommendations
- Gestational diabetes and anemia support

#### Smart Shopping List
- Auto-generated shopping lists from meal plans
- Daily, weekly, and monthly list options
- Estimated total cost calculations
- Budget-saving suggestions
- Categorized by food type (vegetables, fruits, proteins, etc.)
- Check-off functionality for tracking purchases
- Priority indicators for essential items

#### Food Substitution Engine
- Nutritionally equivalent food suggestions
- Handles unavailable or expensive ingredients
- Cost comparison between original and substitute
- Nutrition comparison for informed decisions
- Step-by-step substitution instructions
- Multiple substitution options per ingredient

#### Nutritionist Consultation
- Browse available nutritionists with profiles
- Specialization and experience information
- Rating and review system
- Request advice through chat interface (mocked)
- Multi-language support for nutritionists
- Availability status indicators

#### Community Features
- Share meals with the community
- Discover user-submitted recipes
- Like and interact with community content
- Country-specific meal sharing
- User profiles and meal history
- Inspiration for meal planning

#### Reminders & Habit Support
- Meal reminders with customizable times
- Water intake reminders
- Daily nutrition tips delivery
- Habit tracking with streak visualization
- Weekly progress tracking
- Notification support (ready for implementation)

#### AI-Powered Meal Suggestions
- Intelligent meal recommendations
- Context-aware suggestions based on:
  - User profile and preferences
  - Budget constraints
  - Health goals
  - Past meal selections
- Quick meal discovery interface

#### Categories & Filtering
- Multiple meal categories (Quick & Tasty, Balanced Diet, Budget Friendly, etc.)
- Advanced filtering options:
  - Cooking time
  - Number of servings
  - Food preferences (vegetarian, etc.)
  - Glycemic load
  - Ingredient exclusions
- Search functionality across all meals
- Voice search support

## Architecture

NutriSmart follows the **MVVM (Model-View-ViewModel)** architecture pattern for clean separation of concerns, maintainability, and testability.

### Design Principles

- **Separation of Concerns**: Business logic in ViewModels, UI in Views, data in Models
- **Single Responsibility**: Each component has one clear purpose
- **DRY (Don't Repeat Yourself)**: Reusable components and utilities
- **KISS (Keep It Simple, Stupid)**: Simple, straightforward implementations
- **Offline-First**: All data stored locally, no network dependencies
- **Accessibility**: UI designed for all users

### Key Patterns

- **ObservableObject**: For reactive state management
- **Singleton Pattern**: DataService for centralized data access
- **Factory Pattern**: Meal generation based on country and preferences
- **Strategy Pattern**: Different meal selection strategies for health goals

## Requirements

- iOS 15.0 or later
- Xcode 14.0 or later
- Swift 5.7 or later
- macOS 12.0 or later (for development)

## Installation

### Prerequisites

1. Install Xcode from the Mac App Store
2. Ensure you have a Mac running macOS 12.0 or later
3. Clone this repository

### Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/leandre000/NutriSmart.git
   cd NutriSmart
   ```

2. **Open in Xcode**
   - Open `NutriSmart.xcodeproj` in Xcode
   - If the project file doesn't exist, create a new Xcode project:
     - File → New → Project
     - Select iOS → App
     - Product Name: NutriSmart
     - Interface: SwiftUI
     - Language: Swift
     - Copy all source files into the project

3. **Add JSON Files to Bundle**
   - In Xcode, select the project in the navigator
   - Go to the target's Build Phases
   - Expand "Copy Bundle Resources"
   - Ensure all JSON files in the `Data/` folder are included:
     - meals.json
     - nutritionists.json
     - community_meals.json
     - health_tips.json

4. **Add Image Assets (Optional)**
   - Add meal images to Assets.xcassets
   - Name images according to the `imageName` property in meal JSON data
   - If images are not available, the app will use beautiful placeholder icons

5. **Build and Run**
   - Select a simulator or connected device
   - Press `Cmd + R` to build and run the application

## Usage

### Getting Started

1. **First Launch**
   - Complete the onboarding flow
   - Set up your user profile
   - Select your preferred language

2. **Set Up Your Profile**
   - Tap the profile icon in the top right
   - Enter your age, gender, and select your country
   - Set your weekly or monthly food budget
   - Choose your health goal
   - Save your profile

3. **View Your Meal Plan**
   - The home screen displays today's meals
   - Use the date picker to view meals for other days
   - Tap any meal card to see detailed information
   - Use the AI suggestion card for quick meal ideas

4. **Explore Categories**
   - Browse meal categories from the home screen
   - Filter meals by preferences
   - Discover new recipes aligned with your goals

5. **Weekly Planning**
   - Navigate to the Meal Plan tab for a weekly overview
   - Each meal shows nutrition information and cost
   - Generate shopping lists directly from meal plans
   - Budget alerts appear when meals approach your daily limit

6. **Get Nutrition Advice**
   - Visit the Nutritionists tab
   - Browse available nutritionists with specializations
   - Request advice to start a chat (mocked interaction)

7. **Learn About Nutrition**
   - Go to the Learn tab
   - Read about malnutrition prevention
   - Understand balanced diets
   - View daily health tips

8. **Join the Community**
   - Check the Community tab
   - See meals shared by other users
   - Get inspiration for your own meals
   - Like and interact with community content

9. **Family Planning**
   - Switch to Family mode
   - Add children profiles
   - Set up pregnancy profile if needed
   - Generate family meal plans
   - Get shopping lists for entire family

10. **Manage Reminders**
    - Set meal reminders
    - Track water intake
    - Build healthy habits with streak tracking
    - Receive daily nutrition tips

## Project Structure

```
NutriSmart/
├── Models/                      # Data models
│   ├── User.swift               # User profile model
│   ├── Meal.swift               # Meal data model
│   ├── Country.swift            # Country and currency model
│   ├── Nutritionist.swift       # Nutritionist profile model
│   ├── BudgetAlert.swift        # Budget alert model
│   ├── MalnutritionRisk.swift   # Risk assessment model
│   ├── FamilyNutrition.swift    # Family nutrition models
│   ├── ShoppingList.swift       # Shopping list models
│   ├── FoodSubstitution.swift   # Substitution models
│   └── Reminder.swift           # Reminder models
├── ViewModels/                  # Business logic and state management
│   ├── UserProfileViewModel.swift
│   ├── MealPlanViewModel.swift
│   ├── MealDetailViewModel.swift
│   ├── NutritionistViewModel.swift
│   ├── CommunityViewModel.swift
│   ├── MalnutritionRiskViewModel.swift
│   ├── FamilyNutritionViewModel.swift
│   ├── ShoppingListViewModel.swift
│   ├── FoodSubstitutionViewModel.swift
│   └── ReminderViewModel.swift
├── Views/                       # SwiftUI views
│   ├── HomeView.swift           # Main home screen
│   ├── UserProfileView.swift    # User profile management
│   ├── MealDetailView.swift     # Detailed meal view
│   ├── MealPlanView.swift       # Weekly meal planning
│   ├── NutritionistView.swift   # Nutritionist browsing
│   ├── CommunityView.swift      # Community meal sharing
│   ├── EducationView.swift     # Nutrition education
│   ├── CategoriesView.swift    # Meal categories
│   ├── FamilyNutritionView.swift # Family nutrition mode
│   ├── ShoppingListView.swift  # Shopping list management
│   ├── FoodSubstitutionView.swift # Food substitutions
│   ├── MalnutritionRiskView.swift # Risk assessment
│   ├── RemindersView.swift      # Reminders and habits
│   ├── SettingsView.swift       # App settings
│   ├── MainTabView.swift        # Main navigation
│   └── Components/             # Reusable UI components
│       ├── EnhancedMealCard.swift
│       ├── BudgetCard.swift
│       ├── NutritionCard.swift
│       ├── CategoryCard.swift
│       ├── SearchBar.swift
│       ├── AICard.swift
│       ├── SectionHeader.swift
│       ├── EmptyStateView.swift
│       ├── LoadingView.swift
│       ├── HealthTipCard.swift
│       ├── OnboardingView.swift
│       ├── ErrorBoundary.swift
│       ├── CountrySelector.swift
│       ├── HealthGoalSelector.swift
│       ├── BudgetAlertView.swift
│       ├── ProgressRing.swift
│       ├── ImagePlaceholder.swift
│       └── MealFilterView.swift
├── Services/                    # Data services
│   ├── DataService.swift        # Centralized data loading
│   └── LanguageManager.swift   # Multi-language support
├── Utilities/                   # Helper functions and extensions
│   ├── AppTheme.swift          # Design system and colors
│   ├── Animations.swift        # Animation utilities
│   ├── Extensions.swift        # Swift extensions
│   ├── Formatters.swift       # Data formatters
│   ├── Validators.swift       # Input validation
│   └── ErrorHandler.swift     # Error handling
├── Data/                       # Mock JSON data
│   ├── meals.json             # Meal data for all countries
│   ├── nutritionists.json    # Nutritionist profiles
│   ├── community_meals.json   # Community-shared meals
│   └── health_tips.json       # Educational health tips
└── NutriSmartApp.swift        # App entry point
```

## Data Management

The app uses mock JSON data that simulates real production data. All data is stored locally and works completely offline.

### Data Files

- **meals.json**: Contains meal data for all supported countries with complete nutrition information
- **nutritionists.json**: List of available nutritionists with profiles and specializations
- **community_meals.json**: User-shared meals with nutrition data
- **health_tips.json**: Educational health tips organized by category

### Data Structure

All JSON files follow consistent structures:
- ISO8601 date format (YYYY-MM-DDTHH:MM:SSZ)
- Complete nutrition information with realistic values
- Culturally appropriate meal names and descriptions
- Local currency and cost information

### Adding Custom Data

To add your own meals or modify existing data:

1. Edit the JSON files in the `Data/` folder
2. Follow the existing structure and format
3. Ensure dates use ISO8601 format
4. Maintain consistent field names and types
5. Rebuild the app to load new data

## Supported Countries

### Rwanda
- Traditional foods: Beans, maize, sweet potatoes, vegetables
- Local ingredients: Cassava, plantains, amaranth
- Cultural meals: Isombe, matoke, akabenz

### Kenya
- Traditional foods: Ugali, sukuma wiki, chapati, beans
- Local ingredients: Maize flour, collard greens, lentils
- Cultural meals: Githeri, mukimo, nyama choma

### Nigeria
- Traditional foods: Rice, beans, yam, plantain, fish
- Local ingredients: Palm oil, cassava, groundnuts
- Cultural meals: Jollof rice, egusi soup, moi moi

### India
- Traditional foods: Rice, lentils, wheat, vegetables, spices
- Local ingredients: Turmeric, ginger, coconut, chickpeas
- Cultural meals: Dal, roti, biryani, sambar

### United States
- Traditional foods: Chicken, rice, pasta, vegetables, fruits
- Local ingredients: Various proteins, grains, fresh produce
- Cultural meals: Grilled chicken, salads, pasta dishes

## Health Goals

### Healthy Living
Maintain a balanced diet for overall wellness with appropriate portions of all food groups.

### Weight Gain
Increase calorie intake with nutrient-dense foods while maintaining nutritional balance.

### Weight Loss
Reduce calories while maintaining nutrition through portion control and low-calorie alternatives.

### Anemia Prevention
Focus on iron-rich foods combined with vitamin C for optimal absorption.

### Diabetes-Friendly
Manage blood sugar with low-glycemic index foods and controlled carbohydrate intake.

## Multi-Language Support

NutriSmart supports three languages with complete translations:

### English
- Primary language with full feature support
- All UI elements and content translated

### Kinyarwanda (Ikinyarwanda)
- Complete translation for Rwandan users
- Culturally appropriate terminology
- All features fully localized

### French (Français)
- Complete translation for French-speaking users
- All features fully localized
- Appropriate for multiple countries

### Language Features
- Persistent language preference
- System language detection
- Easy language switching in settings
- All content dynamically translated

## Technical Details

### Design Patterns

- **MVVM Architecture**: Separates business logic from UI for maintainability
- **ObservableObject**: For reactive state management with Combine
- **Singleton Pattern**: DataService for centralized data access
- **Factory Pattern**: Meal generation based on country and preferences
- **Strategy Pattern**: Different meal selection strategies for health goals

### Key Technologies

- **SwiftUI**: Modern declarative UI framework
- **Combine**: Reactive programming via @Published properties
- **Codable**: JSON serialization/deserialization
- **UserDefaults**: Local data persistence for user preferences
- **Foundation**: Core iOS frameworks

### Design System

- **AppTheme**: Centralized color palette and design tokens
- **Consistent Components**: Reusable UI components throughout
- **Animations**: Smooth, friendly animations for better UX
- **Accessibility**: VoiceOver support and accessible design

### Offline Support

The app works completely offline. All data is loaded from local JSON files bundled with the app. No internet connection is required for core functionality.

### Performance

- Efficient data loading with lazy initialization
- Optimized image handling with placeholders
- Smooth animations with spring physics
- Minimal memory footprint

### Error Handling

- Comprehensive error handling throughout
- User-friendly error messages
- Error boundary for graceful failure handling
- Validation for all user inputs

## Contributing

This is a production-ready application designed for real-world use. Contributions are welcome to improve the app and help fight global malnutrition.

### How to Contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes following the existing code style
4. Ensure all features work correctly
5. Test on multiple devices and iOS versions
6. Commit your changes (`git commit -m 'Add amazing feature'`)
7. Push to the branch (`git push origin feature/amazing-feature`)
8. Open a Pull Request

### Code Style

- Follow Swift naming conventions
- Use MVVM architecture pattern
- Keep functions small and focused
- Add comments for complex logic
- Maintain consistent formatting

## License

This project is open source and available for use and modification. See LICENSE file for details.

## Support

For issues, questions, or contributions, please open an issue on the GitHub repository at https://github.com/leandre000/NutriSmart

## Acknowledgments

NutriSmart is designed to address global nutrition challenges and make healthy eating accessible to everyone, regardless of budget or location. The app emphasizes local, culturally appropriate foods to ensure sustainability and affordability.

The application is built with SwiftUI and designed for real-world impact, suitable for deployment by NGOs, health programs, and individuals worldwide.

---

Built with SwiftUI. Designed for impact. Ready for deployment.

Version 2.0.0
