# Flutter Theming App - Setup Guide

Complete step-by-step guide to get the Flutter Theming App running on your machine.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Flutter Installation](#flutter-installation)
3. [Project Setup](#project-setup)
4. [Running the App](#running-the-app)
5. [Troubleshooting](#troubleshooting)
6. [Development Workflow](#development-workflow)

## Prerequisites

### System Requirements

- **Operating System**: Windows, macOS, or Linux
- **RAM**: Minimum 4GB (8GB recommended)
- **Disk Space**: 5GB free space
- **Internet Connection**: Required for downloading dependencies

### Required Software

1. **Git** (Optional but recommended)
   - Download: https://git-scm.com/downloads
   - Verify: `git --version`

2. **Android SDK** (for Android development)
   - Included with Android Studio
   - Minimum API Level: 21
   - Target API Level: 34

3. **Java Development Kit (JDK)**
   - Version: 11 or higher
   - Download: https://www.oracle.com/java/technologies/downloads/

## Flutter Installation

### Step 1: Download Flutter SDK

1. Visit https://flutter.dev/docs/get-started/install
2. Select your operating system
3. Download the latest stable Flutter SDK
4. Extract to a permanent location:
   - **Windows**: `C:\src\flutter`
   - **macOS/Linux**: `~/development/flutter`

### Step 2: Update PATH Environment Variable

#### Windows
1. Open Environment Variables:
   - Search "Environment Variables" in Start Menu
   - Click "Edit the system environment variables"
   - Click "Environment Variables" button
2. Under "User variables", click "New"
3. Variable name: `PATH`
4. Variable value: `C:\src\flutter\bin` (or your extraction path)
5. Click OK and restart terminal

#### macOS/Linux
Add to `~/.bashrc` or `~/.zshrc`:
```bash
export PATH="$PATH:~/development/flutter/bin"
```

### Step 3: Run Flutter Doctor

```bash
flutter doctor
```

This checks all dependencies. Output should show:
```
✓ Flutter (Channel stable)
✓ Android toolchain
✓ Xcode (macOS only)
✓ Visual Studio Code
✓ Android Studio
```

## Project Setup

### Step 1: Open the Project

```bash
cd DAY_6
```

### Step 2: Get Dependencies

```bash
flutter pub get
```

This downloads all required packages:
- `provider: ^6.1.0` - State management
- `shared_preferences: ^2.2.2` - Local storage
- `cupertino_icons: ^1.0.6` - Icons

### Step 3: Verify Setup

```bash
flutter analyze
```

Should show no errors or warnings.

## Running the App

### Step 1: Connect Device or Start Emulator

#### Option A: Physical Device (Android)
1. Enable Developer Mode:
   - Go to Settings > About Phone
   - Tap "Build Number" 7 times
   - Back to Settings > Developer Options
   - Enable "USB Debugging"
2. Connect via USB
3. Verify connection: `flutter devices`

#### Option B: Physical Device (iOS)
1. Connect iPhone via USB
2. Verify connection: `flutter devices`
3. Trust the computer on the device

#### Option C: Android Emulator
1. Open Android Studio
2. Tools > Device Manager
3. Create or start a virtual device
4. Wait for emulator to boot
5. Verify: `flutter devices`

#### Option D: iOS Simulator (macOS)
```bash
open -a Simulator
```

### Step 2: Run the Application

```bash
flutter run
```

Or specify a target:
```bash
flutter run -d <device_id>
```

### Step 3: Verify App is Running

The app should:
- Launch successfully
- Display the Home screen
- Show navigation bar with 4 tabs
- Allow theme switching in Settings

## App Navigation

### Home Tab
- Showcases featured components
- Demonstrates button styles
- Shows progress indicators
- Interactive FAB counter

### Forms Tab
- Complete contact form
- Input validation examples
- Dropdown selection
- Checkbox and switch components
- Form submission and reset

### Components Tab
- Full color palette showcase
- Typography examples
- Dialog and bottom sheet demos
- List components
- Loading states
- Status badges

### Settings Tab
- Theme mode selection
- Quick toggle button
- Theme preview cards
- Theme persistence
- Feature descriptions

## Development Workflow

### Hot Reload

During development, use hot reload for instant changes:

```bash
# While app is running
Press 'r' in terminal
```

### Hot Restart

For state changes or plugin updates:

```bash
# While app is running
Press 'R' in terminal
```

### Development Server

Start the development server:

```bash
flutter run
```

### Build APK (Android Release)

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### Build iOS App

```bash
flutter build ios --release
```

### Build Web

```bash
flutter build web --release
```

## Project Structure

```
lib/
├── main.dart                      # App entry point
│   └── MyApp: MaterialApp configuration
│   └── MainScreen: Navigation layout
│
├── providers/
│   └── theme_provider.dart        # Theme state management
│       └── ThemeProvider: ChangeNotifier
│           - setLightTheme()
│           - setDarkTheme()
│           - setSystemTheme()
│           - toggleTheme()
│
├── themes/
│   ├── app_theme.dart            # Constants and utilities
│   │   ├── AppColors: Color definitions
│   │   ├── AppTypography: Font sizes
│   │   ├── AppSpacing: Spacing values
│   │   └── AppBreakpoints: Responsive breakpoints
│   │
│   ├── light_theme.dart          # Light theme implementation
│   │   └── lightTheme(): Returns ThemeData
│   │
│   └── dark_theme.dart           # Dark theme implementation
│       └── darkTheme(): Returns ThemeData
│
├── screens/
│   ├── home_screen.dart          # Home page with components
│   ├── form_screen.dart          # Form components demo
│   ├── components_screen.dart    # Component showcase
│   └── settings_screen.dart      # Theme settings
│
└── widgets/
    └── custom_widgets.dart       # Reusable widgets
        ├── CustomHeader
        ├── DemoCard
        ├── ThemePreviewCard
        ├── StatusBadge
        ├── SemanticColorTile
        ├── ResponsiveGrid
        └── FeatureSection
```

## File Organization

### Theme Files

**app_theme.dart** - Centralized constants
```dart
class AppColors { ... }
class AppTypography { ... }
class AppSpacing { ... }
class AppBreakpoints { ... }
```

**light_theme.dart** - Light mode styling
```dart
ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    // All component themes...
  );
}
```

**dark_theme.dart** - Dark mode styling
```dart
ThemeData darkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    // All component themes...
  );
}
```

### Provider File

**theme_provider.dart** - State management
```dart
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  
  Future<void> initialize() async { ... }
  Future<void> setLightTheme() async { ... }
  Future<void> setDarkTheme() async { ... }
  Future<void> setSystemTheme() async { ... }
  Future<void> toggleTheme() async { ... }
}
```

### Screen Files

Each screen contains:
- Full page layout
- Component demonstrations
- Interactive examples
- Theme usage examples

### Widget File

**custom_widgets.dart** - Reusable components
```dart
class CustomHeader extends StatelessWidget { ... }
class DemoCard extends StatelessWidget { ... }
class ThemePreviewCard extends StatelessWidget { ... }
// ... more widgets
```

## Customization Guide

### Changing Colors

Edit `lib/themes/app_theme.dart`:

```dart
class AppColors {
  static const Color primary = Color(0xFF6200EE); // Change this
  // ... other colors
}
```

### Adding New Theme Constants

Add to `app_theme.dart`:

```dart
class AppColors {
  // Your new colors
  static const Color customColor = Color(0xFFHEXVALUE);
}

class AppTypography {
  // Your new sizes
  static const double customSize = 24.0;
}
```

### Modifying Theme Styling

Update `light_theme.dart` and `dark_theme.dart`:

```dart
ThemeData lightTheme() {
  return ThemeData(
    // Modify component themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        // Your custom styling
      ),
    ),
  );
}
```

### Creating New Screens

1. Create file: `lib/screens/new_screen.dart`
2. Create StatefulWidget or StatelessWidget
3. Implement build() method
4. Add to navigation in `main.dart`
5. Update BottomNavigationBar

## Debugging

### Enable Debug Logging

```bash
flutter run -v
```

Verbose output shows all steps.

### Debug Mode

Default when running:
```bash
flutter run
```

### Profile Mode

Performance testing:
```bash
flutter run --profile
```

### Release Mode

Final optimized build:
```bash
flutter run --release
```

## Common Issues & Solutions

### Issue: `flutter` command not found
**Solution**: Verify PATH is set correctly. Restart terminal/IDE.

### Issue: App crashes on startup
**Solution**: Run `flutter clean && flutter pub get && flutter run`

### Issue: Theme doesn't persist
**Solution**: Check SharedPreferences initialization in main.dart

### Issue: Hot reload not working
**Solution**: Use hot restart (R) or full rebuild

### Issue: Emulator is slow
**Solution**: Use hardware acceleration or physical device

### Issue: Build fails with version conflict
**Solution**: Run `flutter pub upgrade` or `flutter pub get --no-offline`

## Performance Tips

1. **Use const constructors** where possible
2. **Avoid rebuilds** with Consumer widget
3. **Use ListView.builder** for long lists
4. **Profile with DevTools** for optimization
5. **Release builds** are 10x faster than debug

## Testing the Theme

### Manual Testing Checklist

- [ ] Light theme loads correctly
- [ ] Dark theme loads correctly
- [ ] System theme respects device settings
- [ ] Theme persists after app restart
- [ ] All buttons are styled correctly
- [ ] Text is readable in both themes
- [ ] Forms validate inputs properly
- [ ] Navigation works smoothly
- [ ] Colors contrast is sufficient
- [ ] Responsive layout works on different sizes

## Additional Resources

### Official Documentation
- Flutter: https://flutter.dev/docs
- Dart: https://dart.dev/guides
- Material Design: https://material.io/design
- Provider Package: https://pub.dev/packages/provider

### Video Tutorials
- Flutter Official Channel: https://www.youtube.com/c/flutterdev
- Getting Started: https://flutter.dev/docs/get-started

### Community
- Stack Overflow: Tag `flutter`
- Reddit: r/FlutterDev
- Discord: Flutter community servers

## Next Steps

1. Run the app successfully
2. Explore each screen
3. Test theme switching
4. Try hot reload
5. Customize colors
6. Build for production
7. Deploy to app stores

## Support

If you encounter issues:

1. Check this guide
2. Run `flutter doctor`
3. Review error messages
4. Check internet connection
5. Update Flutter: `flutter upgrade`
6. Clean project: `flutter clean`
7. Get fresh dependencies: `flutter pub get`

## Summary

You now have a fully functional Flutter Theming App with:
- ✅ Professional theming system
- ✅ Material 3 design
- ✅ Theme persistence
- ✅ Responsive UI
- ✅ Complete source code
- ✅ Production-ready structure

Enjoy building with Flutter!

---

**Last Updated**: 2024
**Flutter Version**: 3.0.0+
**Guide Version**: 1.0.0
