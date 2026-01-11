# NutriSmart - Complete Project Structure

## Directory Structure

```
NutriSmart/
├── NutriSmartApp.swift          # App entry point
├── Info.plist                   # App configuration
├── Assets.xcassets/             # Image assets and app icon
│   ├── AppIcon.appiconset/      # App icon
│   ├── LaunchImage.imageset/    # Launch screen image
│   └── LaunchScreenBackground.colorset/  # Launch screen color
├── Models/                      # Data models
│   ├── User.swift
│   ├── Meal.swift
│   ├── Country.swift
│   ├── Nutritionist.swift
│   ├── BudgetAlert.swift
│   ├── MalnutritionRisk.swift
│   ├── FamilyNutrition.swift
│   ├── ShoppingList.swift
│   ├── FoodSubstitution.swift
│   └── Reminder.swift
├── ViewModels/                  # Business logic
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
│   ├── HomeView.swift
│   ├── UserProfileView.swift
│   ├── MealDetailView.swift
│   ├── MealPlanView.swift
│   ├── NutritionistView.swift
│   ├── CommunityView.swift
│   ├── EducationView.swift
│   ├── CategoriesView.swift
│   ├── FamilyNutritionView.swift
│   ├── ShoppingListView.swift
│   ├── FoodSubstitutionView.swift
│   ├── MalnutritionRiskView.swift
│   ├── RemindersView.swift
│   ├── SettingsView.swift
│   ├── MainTabView.swift
│   └── Components/              # Reusable components
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
├── Services/                   # Data services
│   ├── DataService.swift       # JSON data loading
│   └── LanguageManager.swift   # Multi-language support
├── Utilities/                   # Helper utilities
│   ├── AppTheme.swift         # Design system
│   ├── Animations.swift       # Animation utilities
│   ├── Extensions.swift       # Swift extensions
│   ├── Formatters.swift      # Data formatters
│   ├── Validators.swift      # Input validation
│   └── ErrorHandler.swift    # Error handling
└── Data/                       # JSON data files
    ├── meals.json             # Meal data
    ├── nutritionists.json     # Nutritionist profiles
    ├── community_meals.json   # Community meals
    └── health_tips.json       # Health tips
```

## File Count Summary

- **Models:** 10 files
- **ViewModels:** 10 files
- **Views:** 17 main views + 16 components = 33 files
- **Services:** 2 files
- **Utilities:** 6 files
- **Data:** 4 JSON files
- **Assets:** App icon + launch screen
- **Configuration:** Info.plist, App entry point

**Total:** ~70+ source files

## Build Requirements

### Required Files for Build

1. **App Entry:**
   - `NutriSmartApp.swift` (must have @main)

2. **Configuration:**
   - `Info.plist` (app settings)
   - `Assets.xcassets` (images and icons)

3. **Source Files:**
   - All Swift files in Models/
   - All Swift files in ViewModels/
   - All Swift files in Views/
   - All Swift files in Services/
   - All Swift files in Utilities/

4. **Resources:**
   - All JSON files in Data/
   - Assets.xcassets

### Xcode Project Setup

When creating Xcode project:

1. **Add all folders** to project
2. **Ensure target membership** for all files
3. **Add JSON files** to "Copy Bundle Resources"
4. **Configure Info.plist** path in Build Settings
5. **Set deployment target** to iOS 15.0+

## Dependencies

- **SwiftUI:** Built-in iOS framework
- **Foundation:** Built-in iOS framework
- **UserNotifications:** For reminders (optional)
- **No external dependencies:** Pure Swift/SwiftUI

## Build Configuration

### Minimum Requirements
- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

### Build Settings
- Deployment Target: iOS 15.0
- Swift Language Version: Swift 5
- Asset Catalog: Assets.xcassets
- Info.plist: NutriSmart/Info.plist

---

This structure is ready for Xcode project creation!

