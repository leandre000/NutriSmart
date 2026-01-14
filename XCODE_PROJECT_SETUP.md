# Xcode Project Setup - Step by Step

## Creating the Xcode Project

### Step 1: Create New Project

1. Open **Xcode**
2. File → **New → Project** (or Cmd + Shift + N)
3. Select **iOS** tab
4. Choose **App** template
5. Click **Next**

### Step 2: Configure Project

Fill in the form:

- **Product Name:** `NutriSmart`
- **Team:** (Select your Apple Developer account)
- **Organization Identifier:** `com.yourcompany` (or your domain)
- **Bundle Identifier:** (Auto-generated, e.g., `com.yourcompany.NutriSmart`)
- **Interface:** **SwiftUI** ⚠️ IMPORTANT
- **Language:** **Swift**
- **Storage:** **None** (we'll add files manually)
- **Include Tests:** (Optional)

Click **Next**

### Step 3: Choose Location

- Select where to save the project
- **Create Git repository:** (Optional)
- Click **Create**

### Step 4: Delete Default Files

Xcode creates some default files. Delete these:

1. In Project Navigator, find:
   - `ContentView.swift` (if exists)
   - `Assets.xcassets` (we'll replace it)
   - `Preview Content` folder (optional)

2. Right-click → **Delete**
3. Choose **Move to Trash**

### Step 5: Add Source Files

1. **Right-click** on the project name (NutriSmart) in Navigator
2. Select **"Add Files to NutriSmart..."**
3. Navigate to the `NutriSmart` folder in your project directory
4. **Select ALL these folders/files:**
   ```
   ✅ Models/
   ✅ ViewModels/
   ✅ Views/
   ✅ Services/
   ✅ Utilities/
   ✅ Data/
   ✅ Assets.xcassets/
   ✅ Info.plist
   ✅ NutriSmartApp.swift
   ```
5. **Important Options:**
   - ✅ **Copy items if needed** (check this)
   - ✅ **Create groups** (NOT folder references)
   - ✅ **Add to targets:** NutriSmart (should be checked)
6. Click **Add**

### Step 6: Configure Target Settings

1. Click on **project name** (NutriSmart) in Navigator (blue icon)
2. Select **NutriSmart** target (under TARGETS)
3. Go to **General** tab:

   **Identity:**
   - Display Name: `NutriSmart`
   - Bundle Identifier: (should be set)
   - Version: `1.0`
   - Build: `1`

   **Deployment Info:**
   - iOS: **15.0** (minimum)
   - Devices: **iPhone** (or Universal)

4. Go to **Build Settings** tab:
   - Search for: `Info.plist File`
   - Set value to: `NutriSmart/Info.plist`
   - Search for: `Asset Catalog App Icon Set Name`
   - Set value to: `AppIcon`

5. Go to **Build Phases** tab:
   - Expand **"Copy Bundle Resources"**
   - Verify these files are listed:
     - `Info.plist`
     - `meals.json`
     - `nutritionists.json`
     - `community_meals.json`
     - `health_tips.json`
   - If any are missing:
     - Click **"+"** button
     - Add missing files

### Step 7: Replace App Entry Point

1. Open `NutriSmartApp.swift` in Xcode
2. **Replace entire content** with the code from `NutriSmart/NutriSmartApp.swift`
3. Save (Cmd + S)

### Step 8: Configure App Icon

1. In Navigator, expand `Assets.xcassets`
2. Click on `AppIcon`
3. You'll see placeholder slots
4. **Option A:** Add your icon
   - Drag a 1024x1024 PNG image into the slot
5. **Option B:** Use placeholder (for testing)
   - Leave empty - app will use default icon

### Step 9: Verify File Structure

Your project should look like this:

```
NutriSmart (Project)
├── NutriSmart (Target)
│   ├── NutriSmartApp.swift
│   ├── Models/
│   │   ├── User.swift
│   │   ├── Meal.swift
│   │   └── ... (all model files)
│   ├── ViewModels/
│   │   └── ... (all view model files)
│   ├── Views/
│   │   ├── HomeView.swift
│   │   ├── Components/
│   │   └── ... (all view files)
│   ├── Services/
│   │   ├── DataService.swift
│   │   └── LanguageManager.swift
│   ├── Utilities/
│   │   └── ... (all utility files)
│   ├── Data/
│   │   ├── meals.json
│   │   ├── nutritionists.json
│   │   ├── community_meals.json
│   │   └── health_tips.json
│   ├── Assets.xcassets/
│   │   └── AppIcon.appiconset/
│   └── Info.plist
```

### Step 10: Build and Run

1. **Select Simulator:**
   - Click device selector in toolbar (top left)
   - Choose: **iPhone 15** or any iOS 15+ simulator

2. **Build:**
   - Press **Cmd + B** (or Product → Build)
   - Wait for build to complete
   - Check for errors in Issue Navigator

3. **Run:**
   - Press **Cmd + R** (or Product → Run)
   - App launches in simulator!

## Common Issues and Solutions

### Issue: "Cannot find 'X' in scope"

**Solution:**
1. Select the file with error
2. Open File Inspector (right panel)
3. Under "Target Membership"
4. Ensure "NutriSmart" is checked

### Issue: "No such module 'SwiftUI'"

**Solution:**
1. Check Deployment Target is iOS 15.0+
2. Clean Build Folder: **Cmd + Shift + K**
3. Rebuild: **Cmd + B**

### Issue: JSON files not loading

**Solution:**
1. Go to Build Phases → Copy Bundle Resources
2. Verify JSON files are listed
3. If missing, click "+" and add them
4. Clean and rebuild

### Issue: Info.plist not found

**Solution:**
1. Go to Build Settings
2. Search "Info.plist"
3. Set path to: `NutriSmart/Info.plist`
4. Ensure Info.plist is in Copy Bundle Resources

## Verification Checklist

Before running, verify:

- [ ] All Swift files added to target
- [ ] All JSON files in Copy Bundle Resources
- [ ] Info.plist path configured
- [ ] Deployment Target is iOS 15.0+
- [ ] AppIcon configured (or placeholder)
- [ ] NutriSmartApp.swift is the entry point
- [ ] No build errors
- [ ] Simulator selected

## Success!

If everything is configured correctly:
- ✅ Build succeeds (Cmd + B)
- ✅ App launches in simulator (Cmd + R)
- ✅ Onboarding screen appears
- ✅ All features work

---

**Your NutriSmart app is ready to run!**


