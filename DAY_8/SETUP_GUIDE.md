# Quick Setup Guide

## 🚀 Get Started in 5 Minutes

### Prerequisites
- ✅ Flutter SDK installed (Latest Stable)
- ✅ Dart 3.0 or higher
- ✅ Android Studio / VS Code
- ✅ Android emulator or physical device

---

## Step-by-Step Setup

### 1. Navigate to Project Directory
```bash
cd DAY_8
```

### 2. Install Dependencies
```bash
flutter pub get
```

**Output should show:**
```
Running "flutter pub get" in navigation_showcase...
# ... package downloads ...
Got dependencies!
```

### 3. Check Flutter Status
```bash
flutter doctor
```

**Ensure all checkmarks are present:**
- ✓ Flutter
- ✓ Android toolchain
- ✓ Connected device or emulator

### 4. Run the Application

#### Option A: Physical Device
```bash
# Connect device via USB
flutter run
```

#### Option B: Android Emulator
```bash
# Start emulator first, then run
flutter run
```

#### Option C: iOS Simulator (Mac only)
```bash
flutter run -d macos
```

#### Option D: Web Browser
```bash
# Enable web (first time only)
flutter config --enable-web

# Run on browser
flutter run -d web-server
```

### 5. Verify Installation
You should see:
- App launching on device/emulator
- Home Screen with "Navigation Showcase" title
- Bottom navigation bar with 4 tabs
- Drawer menu on left side

---

## 📱 First Time Using the App

1. **Click "Navigate to Details Screen"** - See basic push/pop navigation
2. **Open the Drawer** - Click menu icon, explore navigation patterns
3. **Use Bottom Navigation** - Switch between Home, Search, Favorites, Profile
4. **Fill Out Form** - See data returning backward
5. **View TabBar** - Click "View TabBar Navigation Demo" to see tab switching

---

## ⚙️ Configuration

### Material 3 Enabled
Material 3 is already configured in `lib/main.dart`:
```dart
useMaterial3: true
```

### Custom Theme
Edit colors in `lib/main.dart` under `ThemeData`:
```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: Colors.blue,
  brightness: Brightness.light,
)
```

---

## 🔧 Development Commands

### Format Code
```bash
dart format lib/
```

### Analyze Code
```bash
flutter analyze
```

### Run with Debug Output
```bash
flutter run -v
```

### Run in Release Mode
```bash
flutter run --release
```

### Clean Build
```bash
flutter clean
flutter pub get
flutter run
```

---

## 📁 Project Files Overview

| File | Purpose |
|------|---------|
| `lib/main.dart` | App entry point & routes |
| `lib/screens/home_screen.dart` | Main screens (Home, Details, Form, TabBar, Nested) |
| `lib/screens/profile_screen.dart` | Profile display screen |
| `lib/screens/settings_screen.dart` | Settings screen |
| `lib/screens/about_screen.dart` | About, Search, Favorites screens |
| `lib/widgets/app_drawer.dart` | Navigation drawer |
| `lib/widgets/custom_bottom_nav.dart` | Bottom navigation bar |
| `lib/models/user.dart` | User data model |
| `lib/routes/app_routes.dart` | Route constants |
| `pubspec.yaml` | Dependencies |
| `README.md` | Full documentation |

---

## 🐛 Common Issues & Solutions

### Issue: "Flutter command not found"
**Solution:**
```bash
# Add Flutter to PATH
# Linux/Mac: Add to ~/.bashrc or ~/.zshrc
export PATH="$PATH:[Flutter SDK path]/bin"

# Windows: Add Flutter\bin to System Environment Variables
```

### Issue: Android emulator not starting
**Solution:**
```bash
# List available emulators
flutter emulators

# Start specific emulator
flutter emulators --launch emulator_name

# Or use Android Studio's AVD Manager
```

### Issue: "No iOS devices found" (Mac)
**Solution:**
```bash
# Start iOS simulator
open -a Simulator

# Then run
flutter run -d macos
```

### Issue: Pub dependencies not updating
**Solution:**
```bash
flutter pub cache repair
flutter pub get
```

### Issue: Build cache issues
**Solution:**
```bash
flutter clean
flutter pub get
flutter run
```

---

## 📚 Learning Resources

### In This Project
1. **Home Screen** - Learn basic navigation
2. **App Drawer** - Learn drawer implementation
3. **Profile Screen** - Learn named routes
4. **TabBar Screen** - Learn tab navigation
5. **Nested Navigation Screen** - Learn complex navigation

### External Resources
- [Flutter Navigation Docs](https://docs.flutter.dev/development/ui/navigation)
- [Material 3 Guide](https://material.io/design/material-3)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)

---

## ✅ Success Checklist

After setup, verify:
- [ ] App launches without errors
- [ ] Home screen displays
- [ ] Drawer opens/closes smoothly
- [ ] Bottom navigation works
- [ ] Can navigate to different screens
- [ ] Back button works correctly
- [ ] Data passing works
- [ ] TabBar navigation works

---

## 🎓 Next Steps

1. **Run the app** and explore all features
2. **Read the code comments** in each file
3. **Modify styles** - Change colors in `main.dart`
4. **Add new screens** - Follow the pattern used in existing screens
5. **Experiment with routes** - Add your own named routes
6. **Study the README** - Detailed explanation of all concepts

---

## 💡 Tips

- **Use hot reload** (Ctrl+S) for quick development
- **Read code comments** - They explain each concept
- **Follow Material 3 guidelines** - Already applied in this project
- **Keep screens separate** - Easy to maintain and understand
- **Use named routes** - Better for large apps

---

## 🆘 Need Help?

1. Check the **README.md** for detailed explanations
2. Review **code comments** in relevant files
3. Check **Troubleshooting section** in README
4. Review **Flutter documentation**
5. Run `flutter doctor` to check environment

---

## 🎉 Ready to Go!

Your Flutter Navigation Showcase App is ready. Start exploring and learning about Flutter navigation!

**Happy Coding! 🚀**
