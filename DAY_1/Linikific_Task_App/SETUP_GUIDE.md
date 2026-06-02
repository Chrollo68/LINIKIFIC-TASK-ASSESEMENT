# Flutter Development Environment Setup Guide

This document provides complete instructions for setting up Flutter development environment with Android Studio, Flutter SDK, and Android emulator.

## Project Overview

This is a Flutter application - a cross-platform mobile framework developed by Google. The project includes:
- **Flutter Framework**: 3.35.7 (Stable Channel)
- **Dart SDK**: 3.9.2
- **Android Toolchain**: Android SDK version 35.0.0
- **Java Development Kit**: JDK 17

## System Requirements

- **OS**: Windows 11 Pro (64-bit) or later
- **RAM**: Minimum 4GB (8GB+ recommended)
- **Disk Space**: 10GB+ for Android Studio, SDK, and emulator

## Installation Steps

### 1. Install Flutter SDK

```bash
# Flutter is already installed at: C:\flutter_windows_3.35.7-stable\flutter
flutter --version

# Verify installation
flutter doctor
```

**Current Status**: ✅ Installed (Flutter 3.35.7)

### 2. Install Android Studio

Android Studio is the IDE for Android development and includes essential Android tools.

```bash
# Verify installation
flutter doctor
```

**Current Setup**:
- Android Studio (2021.2): D:\android ✅
- Android Studio (2023.3): C:\Program Files\Android\Android Studio ⚠️

**Note**: Version 2023.3 has a Java configuration issue, but version 2021.2 is fully functional.

### 3. Configure Java Development Kit (JDK)

```bash
# Current JDK Configuration
java -version
# Output: Java SE Runtime Environment (build 17.0.12+8-LTS-286)

# JDK Location: C:\Program Files\Java\jdk-17\bin\java
```

**Status**: ✅ JDK 17 configured and working

### 4. Android SDK Configuration

The Android SDK includes tools, platform files, and system images needed for development.

```bash
# Android SDK Location: C:\Users\Global\AppData\Local\Android\sdk
# 
# Installed Components:
# - Build Tools: 35.0.0
# - Platform: Android-36
# - Emulator: 34.2.16.0
# - System Images: Multiple Android versions available
```

**All Android licenses**: ✅ Accepted

### 5. Set Up Android Emulator

To create and run an Android emulator:

#### Option A: Using Android Studio GUI (Recommended)
1. Open Android Studio
2. Go to: AVD Manager (Tools → Device Manager)
3. Click "Create Device"
4. Select a device (e.g., Pixel 6)
5. Choose API Level 32 or higher
6. Click "Finish"

#### Option B: Using Command Line
```bash
# List available system images
$ANDROID_SDK = "$env:LOCALAPPDATA\Android\Sdk"
& "$ANDROID_SDK\cmdline-tools\latest\bin\avdmanager.bat" list installed

# Create new AVD
& "$ANDROID_SDK\cmdline-tools\latest\bin\avdmanager.bat" create avd `
  -n flutter_emulator `
  -k "system-images;android-32;google_apis_playstore;x86_64" `
  -f

# Launch emulator
& "$ANDROID_SDK\emulator\emulator.exe" -avd flutter_emulator
```

**Current Status**: Emulator setup ready (system images available)

## Flutter Project Structure

```
my_first_app/
├── android/              # Android-specific code and configurations
├── ios/                  # iOS-specific code and configurations
├── lib/                  # Dart code (main.dart and other source files)
│   └── main.dart        # Entry point of the application
├── macos/               # macOS-specific code
├── web/                 # Web-specific code
├── pubspec.yaml         # Project dependencies and metadata
├── pubspec.lock         # Locked dependency versions
├── analysis_options.yaml # Dart analyzer configuration
└── test/                # Unit and widget tests
```

### Key Files

- **lib/main.dart**: Main entry point with MyApp and MyHomePage widgets
- **pubspec.yaml**: Project configuration with dependencies
- **android/app/build.gradle**: Android build configuration
- **.gitignore**: Git exclusion patterns

## Verifying Your Setup

Run flutter doctor to verify all components:

```bash
flutter doctor

# Expected Output:
# [✓] Flutter (Channel stable, 3.35.7, on Microsoft Windows...)
# [✓] Windows Version (11 Pro 64-bit, 25H2, 2009)
# [✓] Android toolchain - develop for Android devices
# [✓] Chrome - develop for the web
# [✓] Android Studio (version 2021.2)
# [✓] VS Code
# [✓] Connected device
# [✓] Network resources
```

## Running the Application

### Run on Android Emulator

```bash
# Navigate to project directory
cd my_first_app

# Start the app in debug mode
flutter run

# Run with specific device
flutter run -d flutter_emulator

# Run in release mode
flutter run --release
```

### Run on Web Browser

```bash
flutter run -d chrome
# or
flutter run -d edge
```

### Hot Reload and Hot Restart

While the app is running:
- **Hot Reload** (r): Reload code without losing app state
- **Hot Restart** (R): Full restart and rebuild
- **Quit** (q): Stop the app

## Understanding Flutter Architecture

### Widget System
Flutter uses a reactive widget framework. Two types:

1. **StatelessWidget**: Immutable, no mutable state
2. **StatefulWidget**: Can hold mutable state

### Widget Tree
Your app builds a tree of widgets:

```
MyApp (StatelessWidget)
  └── MaterialApp
        └── MyHomePage (StatefulWidget)
              └── Scaffold
                    ├── AppBar
                    ├── FloatingActionButton
                    └── Center
                          └── Column
```

### Material Design
Flutter uses Google's Material Design by default, providing:
- Pre-built UI components
- Consistent theming system
- Responsive layouts

## Common Commands

```bash
# Create new Flutter project
flutter create project_name

# Get dependencies
flutter pub get

# Run tests
flutter test

# Build APK (Android)
flutter build apk

# Build web app
flutter build web

# Format code
dart format .

# Analyze code
dart analyze

# Clean build
flutter clean
```

## Troubleshooting

### Issue: Emulator not starting
**Solution**: 
- Check if Hyper-V is enabled (for Windows 11)
- Try running with `-gpu off` flag: `emulator -avd flutter_emulator -gpu off`

### Issue: "flutter: command not found"
**Solution**: Add Flutter to PATH environment variable
- Flutter location: `C:\flutter_windows_3.35.7-stable\flutter\bin`

### Issue: Android license errors
**Solution**:
```bash
flutter doctor --android-licenses
# Accept all licenses
```

### Issue: Build fails
**Solution**:
```bash
flutter clean
flutter pub get
flutter run
```

## Environment Variables

Important environment variables for Flutter development:

```bash
# Flutter SDK
FLUTTER_HOME=C:\flutter_windows_3.35.7-stable\flutter

# Android SDK
ANDROID_HOME=C:\Users\Global\AppData\Local\Android\sdk
ANDROID_SDK_ROOT=C:\Users\Global\AppData\Local\Android\sdk

# Java
JAVA_HOME=C:\Program Files\Java\jdk-17
```

## Next Steps

1. ✅ Complete this setup guide
2. ✅ Run `flutter doctor` and verify all checks pass
3. 📱 Create an Android Virtual Device (emulator)
4. 🚀 Run your first Flutter app: `flutter run`
5. 📚 Explore Flutter documentation: https://docs.flutter.dev
6. 🎨 Modify the app UI in `lib/main.dart`
7. 🧪 Write tests in `test/` directory
8. 📦 Build for production: `flutter build apk`

## Useful Resources

- **Official Documentation**: https://docs.flutter.dev/
- **API Reference**: https://api.flutter.dev/
- **Community**: https://flutter.dev/community
- **YouTube Channel**: https://www.youtube.com/c/flutterdev
- **Packages**: https://pub.dev/

## Device Setup

### Android Physical Device

To run on a physical Android device:

1. Enable Developer Mode (tap Build Number 7 times in Settings)
2. Enable USB Debugging
3. Connect via USB
4. Run: `flutter run`

### iOS Device (macOS only)

iOS development is only available on macOS. This setup focuses on Android.

## Build and Distribution

### Android APK

```bash
# Build APK
flutter build apk

# Build with specific configurations
flutter build apk --split-per-abi
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### Google Play Distribution

1. Create a keystore
2. Configure signing in `android/key.properties`
3. Build signed APK
4. Upload to Google Play Console

## Additional Notes

- This project was created on: May 30, 2026
- Flutter version: 3.35.7 (Stable)
- Target Flutter version: Latest stable
- All Android licenses have been accepted
- Development tools are fully configured

## Support

For issues or questions:
1. Run `flutter doctor` for diagnostic info
2. Check the official Flutter documentation
3. Visit Stack Overflow with tag [flutter]
4. File issues on GitHub: https://github.com/flutter/flutter/issues

---

**Setup Verified**: ✅ All systems operational
**Last Updated**: May 30, 2026
**Status**: Ready for development
