# NutriSmart - Complete Build Instructions

## Quick Start

### Option 1: Create New Xcode Project (Recommended)

1. **Open Xcode**
   - Launch Xcode on your Mac
   - Select "Create a new Xcode project" or File → New → Project

2. **Project Settings**
   - Choose **iOS** → **App**
   - Click **Next**
   - Configure:
     - **Product Name:** `NutriSmart`
     - **Team:** Select your development team
     - **Organization Identifier:** `com.yourcompany` (or your domain)
     - **Bundle Identifier:** Will auto-generate (e.g., `com.yourcompany.NutriSmart`)
     - **Interface:** **SwiftUI**
     - **Language:** **Swift**
     - **Storage:** **None** (we'll add files manually)
   - Click **Next**
   - Choose location and click **Create**

3. **Delete Default Files**
   - Delete `ContentView.swift` (if created)
   - Keep `NutriSmartApp.swift` but we'll replace it

4. **Add Source Files**
   - In Xcode, right-click on the project folder
   - Select "Add Files to NutriSmart..."
   - Navigate to the `NutriSmart` folder
   - Select ALL folders:
     - Models/
     - ViewModels/
     - Views/
     - Services/
     - Utilities/
     - Data/
     - Assets.xcassets/
     - Info.plist
     - NutriSmartApp.swift
   - Check "Copy items if needed" (if files are outside project)
   - Check "Create groups" (not folder references)
   - Click **Add**

5. **Configure Target**
   - Select the project in navigator
   - Select the **NutriSmart** target
   - **General Tab:**
     - Deployment Target: **iOS 15.0**
     - Device Family: **iPhone** (or Universal)
   - **Build Settings:**
     - Search for "Info.plist File"
     - Set to: `NutriSmart/Info.plist`
     - Search for "Asset Catalog App Icon Set Name"
     - Set to: `AppIcon`
   - **Build Phases:**
     - Expand "Copy Bundle Resources"
     - Ensure all JSON files are included:
       - meals.json
       - nutritionists.json
       - community_meals.json
       - health_tips.json
     - If missing, click "+" and add them

6. **Replace App Entry Point**
   - Open `NutriSmartApp.swift` in the project
   - Replace with the content from `NutriSmart/NutriSmartApp.swift`

7. **Add App Icon**
   - Navigate to `Assets.xcassets` → `AppIcon`
   - Drag a 1024x1024 PNG image into the placeholder
   - Or use the system placeholder for now

8. **Build and Run**
   - Select a simulator (e.g., iPhone 15)
   - Press **Cmd + R** or click the Play button
   - The app should build and launch!

### Option 2: Use Existing Project Structure

If you already have an Xcode project:

1. **Add Files to Project**
   - Right-click project → "Add Files to [Project]"
   - Add all folders from `NutriSmart/` directory
   - Ensure "Copy items if needed" is checked

2. **Update Info.plist**
   - Replace existing Info.plist with `NutriSmart/Info.plist`
   - Or merge settings manually

3. **Update Assets**
   - Replace or merge Assets.xcassets
   - Ensure AppIcon is configured

4. **Update App Entry**
   - Replace App file with `NutriSmart/NutriSmartApp.swift`

## Build Configuration

### Minimum Requirements
- **iOS:** 15.0+
- **Xcode:** 14.0+
- **Swift:** 5.7+
- **macOS:** 12.0+ (for development)

### Build Settings Checklist

1. **General Settings:**
   - Deployment Target: iOS 15.0
   - Device Family: iPhone (or Universal)

2. **Info.plist:**
   - Path: `NutriSmart/Info.plist`
   - Ensure it's in "Copy Bundle Resources"

3. **Assets:**
   - Asset Catalog: `Assets.xcassets`
   - App Icon Set: `AppIcon`

4. **Bundle Resources:**
   - All JSON files from `Data/` folder
   - Info.plist

## Troubleshooting

### Build Errors

**Error: "Cannot find type 'X' in scope"**
- Ensure all Swift files are added to the target
- Check File Inspector → Target Membership → NutriSmart

**Error: "No such module 'SwiftUI'"**
- Check Deployment Target is iOS 15.0+
- Clean build folder (Cmd + Shift + K)
- Rebuild (Cmd + B)

**Error: "Could not find Info.plist"**
- Set Info.plist path in Build Settings
- Ensure Info.plist is in Copy Bundle Resources

**Error: "JSON file not found"**
- Add JSON files to "Copy Bundle Resources" in Build Phases
- Check file names match exactly (case-sensitive)

### Runtime Errors

**App crashes on launch:**
- Check console for error messages
- Verify all JSON files are in bundle
- Check Info.plist configuration

**Data doesn't load:**
- Verify JSON files are in bundle
- Check file names match DataService expectations
- Check console for loading warnings

**Images don't appear:**
- This is normal - app uses placeholders
- Add images to Assets.xcassets if desired
- Images should match `imageName` in JSON

## Testing on Simulator

1. **Select Simulator:**
   - Click device selector in Xcode toolbar
   - Choose iPhone 15, iPhone 14, etc.

2. **Run:**
   - Press Cmd + R
   - Wait for build to complete
   - App launches in simulator

3. **Test Features:**
   - Onboarding flow
   - Home screen
   - Meal browsing
   - Profile setup
   - All tabs

## Testing on Device

1. **Connect Device:**
   - Connect iPhone via USB
   - Trust computer on device

2. **Select Device:**
   - Choose your device in Xcode

3. **Configure Signing:**
   - Go to Signing & Capabilities
   - Select your Team
   - Xcode will handle provisioning

4. **Run:**
   - Press Cmd + R
   - App installs and launches on device

## Next Steps

1. ✅ Build successfully
2. ✅ Run on simulator
3. ✅ Test all features
4. ✅ Add app icon image
5. ✅ Customize if needed
6. ✅ Test on physical device

---

**Your app is ready to build and run!**

