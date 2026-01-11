# NutriSmart Setup Guide

## Quick Setup Instructions

### 1. App Icon Setup

The app icon folder structure has been created at:
- `NutriSmart/Assets.xcassets/AppIcon.appiconset/`

**To add your app icon:**

1. Open the project in Xcode
2. Navigate to `Assets.xcassets` in the project navigator
3. Click on `AppIcon`
4. Drag and drop your app icon image (1024x1024 pixels) into the placeholder
5. The icon should be a PNG file named `AppIcon.png` or you can use any image

**Recommended App Icon Design:**
- Size: 1024x1024 pixels
- Format: PNG (with transparency)
- Design: A simple, recognizable icon representing nutrition/health
- Colors: Use the app's primary green color (#33B366) as a base

### 2. Project Configuration

The `Info.plist` file has been created with:
- App display name: NutriSmart
- Bundle identifier: (Set in Xcode project settings)
- Minimum iOS version: iOS 15.0
- Notification permissions: Configured

### 3. JSON Data Files

All JSON data files are located in `NutriSmart/Data/`:
- `meals.json` - Meal data for all countries
- `nutritionists.json` - Nutritionist profiles
- `community_meals.json` - Community-shared meals
- `health_tips.json` - Educational health tips

**Important:** Ensure these files are added to the Xcode project target:
1. Select the file in Xcode
2. Check "Target Membership" in the File Inspector
3. Ensure "NutriSmart" target is checked

### 4. Build and Run

1. Open `NutriSmart.xcodeproj` in Xcode (or create new project if needed)
2. Select your target device or simulator
3. Press `Cmd + R` to build and run
4. The app should launch successfully

### 5. Known Issues Fixed

✅ App icon folder structure created
✅ Info.plist created with proper configuration
✅ Localization extension fixed (removed duplicate)
✅ UIScreen.main deprecated usage fixed
✅ Missing localization keys added
✅ All components verified

### 6. Troubleshooting

**If the app doesn't build:**
- Ensure all Swift files are added to the target
- Check that JSON files are in the bundle resources
- Verify Info.plist is included in the target

**If data doesn't load:**
- Check that JSON files are in the "Copy Bundle Resources" phase
- Verify JSON file names match exactly (case-sensitive)
- Check console for any error messages

**If images don't appear:**
- Images will use placeholders if not found in Assets.xcassets
- Add meal images to Assets.xcassets with names matching `imageName` in JSON
- Or the app will gracefully show system icon placeholders

### 7. Next Steps

1. Add your app icon image
2. Test on a device or simulator
3. Customize colors in `AppTheme.swift` if needed
4. Add meal images to Assets.xcassets (optional)
5. Test all features to ensure everything works

---

**The app is now ready to build and run!**

