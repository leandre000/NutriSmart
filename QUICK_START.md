# NutriSmart - Quick Start Guide

## 🚀 Get Running in 5 Minutes

### Prerequisites
- Mac with macOS 12.0+
- Xcode 14.0+ installed
- iOS Simulator available

### Steps

1. **Open Xcode**
   ```
   Launch Xcode from Applications
   ```

2. **Create New Project**
   - File → New → Project
   - iOS → App
   - Name: `NutriSmart`
   - Interface: **SwiftUI**
   - Language: **Swift**
   - Click Create

3. **Add Files**
   - Right-click project → "Add Files to NutriSmart"
   - Select ALL folders from `NutriSmart/` directory:
     - Models/
     - ViewModels/
     - Views/
     - Services/
     - Utilities/
     - Data/
     - Assets.xcassets/
     - Info.plist
     - NutriSmartApp.swift
   - Check "Copy items if needed"
   - Check "Create groups"
   - Click Add

4. **Configure Target**
   - Select project → NutriSmart target
   - General → Deployment: **iOS 15.0**
   - Build Settings → Info.plist: `NutriSmart/Info.plist`
   - Build Phases → Copy Bundle Resources:
     - Verify all JSON files are listed
     - Add if missing

5. **Run!**
   - Select iPhone 15 simulator
   - Press **Cmd + R**
   - App launches! 🎉

## ✅ Verification

After running, you should see:
- Onboarding screens (first launch)
- Home screen with meal recommendations
- All tabs working
- No crashes or errors

## 🐛 Troubleshooting

**Build fails?**
- Check all files are added to target
- Verify Deployment Target is iOS 15.0+
- Clean build (Cmd + Shift + K)

**App crashes?**
- Check console for errors
- Verify JSON files are in bundle
- Check Info.plist configuration

**Need help?**
- See `BUILD_INSTRUCTIONS.md` for detailed guide
- See `XCODE_PROJECT_SETUP.md` for step-by-step setup

---

**Happy coding! 🍎**

