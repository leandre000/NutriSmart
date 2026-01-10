# NutriSmart

NutriSmart is a production-ready iOS application built with SwiftUI that helps people plan healthy, affordable meals using local foods based on their country, budget, and health goals. The app addresses global malnutrition and unhealthy eating patterns by providing personalized meal planning solutions.

## Features

### Core Functionality

- **User Profile Management**
  - Age, gender, and location tracking
  - Monthly and weekly budget configuration
  - Health goal selection (healthy living, weight gain, weight loss, anemia prevention, diabetes-friendly)

- **Country-Based Meal Planning**
  - Meals adapt to selected country (Rwanda, Kenya, Nigeria, India, USA)
  - Culturally appropriate and locally available ingredients
  - Budget-aware meal suggestions

- **Comprehensive Meal Details**
  - High-quality food images
  - Complete ingredient lists with quantities
  - Step-by-step preparation instructions
  - Detailed nutrition breakdown (calories, macros, micronutrients)
  - Health benefits and advice

- **Budget Management**
  - Daily, weekly, and monthly budget tracking
  - Real-time cost monitoring
  - Budget alerts and warnings
  - Affordable alternative suggestions

- **Nutrition Education**
  - Daily health tips
  - Malnutrition prevention information
  - Balanced diet explanations for non-technical users
  - Educational content on macronutrients and micronutrients

- **Nutritionist Consultation (Mocked)**
  - Browse available nutritionists
  - Request advice through chat interface
  - Specialized nutrition guidance

- **Community Features**
  - Share meals with the community
  - Discover user-submitted recipes
  - Like and interact with community content

## Architecture

NutriSmart follows the **MVVM (Model-View-ViewModel)** architecture pattern for clean separation of concerns and maintainability.

### Project Structure

```
NutriSmart/
├── Models/              # Data models
│   ├── User.swift
│   ├── Meal.swift
│   ├── Country.swift
│   ├── Nutritionist.swift
│   └── BudgetAlert.swift
├── ViewModels/         # Business logic and state management
│   ├── UserProfileViewModel.swift
│   ├── MealPlanViewModel.swift
│   ├── MealDetailViewModel.swift
│   ├── NutritionistViewModel.swift
│   └── CommunityViewModel.swift
├── Views/              # SwiftUI views
│   ├── HomeView.swift
│   ├── UserProfileView.swift
│   ├── MealDetailView.swift
│   ├── MealPlanView.swift
│   ├── NutritionistView.swift
│   ├── CommunityView.swift
│   ├── EducationView.swift
│   ├── MainTabView.swift
│   └── Components/     # Reusable UI components
│       ├── BudgetCard.swift
│       ├── NutritionCard.swift
│       ├── MealCard.swift
│       ├── HealthTipCard.swift
│       ├── ImagePlaceholder.swift
│       ├── BudgetAlertView.swift
│       └── LoadingView.swift
├── Services/           # Data services
│   └── DataService.swift
├── Utilities/         # Helper functions and extensions
│   ├── Extensions.swift
│   └── Formatters.swift
├── Data/              # Mock JSON data
│   ├── meals.json
│   ├── nutritionists.json
│   ├── community_meals.json
│   └── health_tips.json
└── NutriSmartApp.swift
```

## Requirements

- iOS 15.0 or later
- Xcode 14.0 or later
- Swift 5.7 or later

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
   - Ensure all JSON files in the `Data/` folder are added to "Copy Bundle Resources"

4. **Add Image Assets (Optional)**
   - Add meal images to Assets.xcassets
   - Name images according to the `imageName` property in meal JSON data
   - If images are not available, the app will use placeholder icons

5. **Build and Run**
   - Select a simulator or connected device
   - Press `Cmd + R` to build and run the application

## Usage

### Getting Started

1. **Set Up Your Profile**
   - Tap the profile icon in the top right
   - Enter your age, gender, and select your country
   - Set your monthly food budget
   - Choose your health goal

2. **View Your Meal Plan**
   - The home screen displays today's meals
   - Use the date picker to view meals for other days
   - Tap any meal card to see detailed information

3. **Explore Meals**
   - Navigate to the Meal Plan tab for a weekly overview
   - Each meal shows nutrition information and cost
   - Budget alerts appear when meals approach your daily limit

4. **Get Nutrition Advice**
   - Visit the Nutritionists tab
   - Browse available nutritionists
   - Request advice to start a chat (mocked interaction)

5. **Learn About Nutrition**
   - Go to the Learn tab
   - Read about malnutrition prevention
   - Understand balanced diets
   - View daily health tips

6. **Join the Community**
   - Check the Community tab
   - See meals shared by other users
   - Get inspiration for your own meals

## Data

The app uses mock JSON data that simulates real production data. All data is stored locally and works offline.

### Data Files

- **meals.json**: Contains meal data for all supported countries
- **nutritionists.json**: List of available nutritionists
- **community_meals.json**: User-shared meals
- **health_tips.json**: Educational health tips

### Adding Custom Data

To add your own meals or modify existing data:

1. Edit the JSON files in the `Data/` folder
2. Follow the existing structure and format
3. Ensure dates use ISO8601 format (YYYY-MM-DDTHH:MM:SSZ)
4. Rebuild the app to load new data

## Supported Countries

- **Rwanda**: Beans, maize, sweet potatoes, vegetables
- **Kenya**: Ugali, sukuma wiki, chapati, beans
- **Nigeria**: Rice, beans, yam, plantain, fish
- **India**: Rice, lentils, wheat, vegetables, spices
- **United States**: Chicken, rice, pasta, vegetables, fruits

## Health Goals

- **Healthy Living**: Maintain a balanced diet for overall wellness
- **Weight Gain**: Increase calorie intake with nutrient-dense foods
- **Weight Loss**: Reduce calories while maintaining nutrition
- **Anemia Prevention**: Focus on iron-rich foods and vitamin C
- **Diabetes-Friendly**: Manage blood sugar with low-GI foods

## Technical Details

### Design Patterns

- **MVVM Architecture**: Separates business logic from UI
- **ObservableObject**: For reactive state management
- **Singleton Pattern**: DataService for centralized data access

### Key Technologies

- **SwiftUI**: Modern declarative UI framework
- **Combine**: Reactive programming (via @Published properties)
- **Codable**: JSON serialization/deserialization
- **UserDefaults**: Local data persistence

### Offline Support

The app works completely offline. All data is loaded from local JSON files bundled with the app. No internet connection is required.

## Contributing

This is a production-ready application designed for real-world use. Contributions are welcome:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## Future Enhancements

Potential features for future versions:

- Backend integration for real-time data
- User authentication and profiles
- Meal photo uploads
- Shopping list generation
- Recipe scaling for different serving sizes
- Integration with local food markets
- Barcode scanning for nutrition information
- Meal planning calendar export
- Social sharing features

## License

This project is open source and available for use and modification.

## Support

For issues, questions, or contributions, please open an issue on the GitHub repository.

## Acknowledgments

NutriSmart is designed to address global nutrition challenges and make healthy eating accessible to everyone, regardless of budget or location. The app emphasizes local, culturally appropriate foods to ensure sustainability and affordability.

---

Built with SwiftUI and designed for impact.

