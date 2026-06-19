# Firebase Authentication in Flutter - Complete Setup Guide

## Overview
This guide covers setting up Firebase Authentication in your Flutter app with email/password and Google Sign-In authentication methods.

## Prerequisites
- Flutter SDK installed (3.9.2 or higher)
- Android SDK (for Android builds)
- Xcode (for iOS builds, optional)
- Firebase account
- FlutterFire CLI (optional but recommended)

## Learning Objectives
1. ✅ Setup Firebase in Flutter
2. ✅ Implement Firebase Auth
3. ✅ Email/password authentication
4. ✅ Social authentication (Google Sign-In)
5. ✅ Handle authentication state
6. ✅ Build complete auth app

## Step 1: Create Firebase Project

### 1.1 Go to Firebase Console
1. Navigate to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project"
3. Enter project name: "flutter-auth-demo"
4. Disable Google Analytics (optional)
5. Click "Create project"

### 1.2 Enable Authentication
1. In Firebase Console, go to **Authentication**
2. Click **Get started**
3. Enable these sign-in methods:
   - **Email/Password** - Enable both email/password and email link
   - **Google** - Click enable and select a Google Cloud project

## Step 2: Register Your App with Firebase

### 2.1 Add Android App
1. In Firebase Console, click **Add app** → **Android**
2. Register app with package name: `com.example.fire_demo`
3. Download `google-services.json`
4. Place it in: `android/app/`

### 2.2 Add iOS App (Optional)
1. Click **Add app** → **iOS**
2. Register with bundle ID: `com.example.firDemo`
3. Download `GoogleService-Info.plist`
4. Place it in: `ios/Runner/` and add to Xcode

### 2.3 Get Firebase Credentials
1. Go to Project Settings
2. Find your Web API key (for later use)
3. Download service account key (JSON)

## Step 3: Setup Flutter Project

### 3.1 Install FlutterFire CLI (Recommended)
```bash
dart pub global activate flutterfire_cli
```

### 3.2 Configure Flutter for Firebase
```bash
cd fire_demo
flutterfire configure
```

This command will:
- Ask you to select which platforms to configure
- Automatically generate `firebase_options.dart`
- Update necessary configuration files

**Note:** If you can't use flutterfire configure, manually update `firebase_options.dart` with your credentials.

### 3.3 Get Dependencies
```bash
flutter pub get
```

## Step 4: Firebase Dependencies

Already added to `pubspec.yaml`:
- `firebase_core: ^3.1.0` - Core Firebase library
- `firebase_auth: ^5.1.0` - Firebase Authentication
- `google_sign_in: ^6.2.1` - Google Sign-In
- `provider: ^6.2.0` - State management
- `intl: ^0.19.0` - Date formatting

## Step 5: Android Configuration

### 5.1 Update `android/build.gradle`
```gradle
buildscript {
    ext {
        kotlin_version = '1.8.0'
    }
    dependencies {
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

### 5.2 Update `android/app/build.gradle`
```gradle
apply plugin: 'com.android.application'
apply plugin: 'com.google.gms.google-services'

// ... other configs
```

### 5.3 Update `android/app/src/main/AndroidManifest.xml`
No changes needed - Firebase handles this automatically.

## Step 6: iOS Configuration (Optional)

### 6.1 Update Pod dependencies
```bash
cd ios
pod install --repo-update
cd ..
```

### 6.2 Update Runner Build Settings
In Xcode:
1. Open `ios/Runner.xcworkspace`
2. Select Runner → Build Settings
3. Search for "GCC_PREPROCESSOR_DEFINITIONS"
4. Add: `$(inherited) GCC_PREPROCESSOR_DEFINITIONS=COCOAPODS=1`

## Step 7: Project Structure

```
lib/
├── main.dart                    # App entry point
├── firebase_options.dart        # Firebase configuration
├── services/
│   └── auth_service.dart       # Firebase auth logic
├── models/
│   └── user_model.dart         # User data model
├── screens/
│   ├── auth_wrapper.dart       # Navigation based on auth state
│   ├── login_screen.dart       # Login screen
│   ├── register_screen.dart    # Registration screen
│   ├── home_screen.dart        # Home/Dashboard
│   └── profile_screen.dart     # User profile display
```

## Step 8: Key Classes and Features

### 8.1 AuthService
Provides methods for:
- Email/password signup and signin
- Google Sign-In
- Sign out
- Password reset
- User state stream

### 8.2 Authentication Screens
- **LoginScreen**: Email/password login + Google Sign-In
- **RegisterScreen**: Create new account with validation
- **HomeScreen**: Displays user info after login
- **ProfileScreen**: Detailed user profile

### 8.3 Auth State Management
- `authStateChanges()` stream from Firebase
- `AuthWrapper` handles navigation
- Automatic redirect based on authentication state

## Step 9: Running the App

### 9.1 Clean and Get Dependencies
```bash
flutter clean
flutter pub get
```

### 9.2 Run on Android
```bash
flutter run -d android
```

### 9.3 Run on iOS
```bash
flutter run -d ios
```

### 9.4 Run on Web
```bash
flutter run -d web
```

## Step 10: Testing Authentication

### Test Email/Password Authentication
1. Click "Register" on login screen
2. Enter name, email, password
3. Create account
4. Login with email/password
5. View profile on home screen

### Test Google Sign-In
1. Click "Sign in with Google"
2. Select Google account
3. Grant permissions
4. View profile information
5. Logout and verify

## Common Issues and Solutions

### Issue: google-services.json not found
**Solution**: Make sure `android/app/google-services.json` exists after flutterfire configure

### Issue: Firebase initialization fails
**Solution**: 
- Check internet connection
- Verify firebase_options.dart has correct credentials
- Check that app is registered in Firebase console

### Issue: Google Sign-In fails
**Solution**:
- Verify OAuth consent screen is configured in Google Cloud Console
- Check Google credentials in Firebase console
- Ensure package name matches in Firebase console

### Issue: Build fails on iOS
**Solution**:
- Run `cd ios && pod install --repo-update && cd ..`
- Clean build: `flutter clean && flutter pub get`

## Advanced Features (Future Implementation)

1. **Email Verification**
   - Send verification email after signup
   - Verify before login

2. **Password Reset**
   - Implement forgot password flow
   - Email with reset link

3. **Social Authentication**
   - Add Facebook login
   - Add Apple Sign-In

4. **Profile Updates**
   - Edit display name
   - Update profile picture
   - Link/Unlink providers

5. **Security**
   - Email verification
   - Phone authentication
   - Two-factor authentication

## Firebase Security Rules

For Firestore (if you add it):
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth.uid == userId;
    }
  }
}
```

## Useful Resources

### YouTube Channels
- [The Flutter Way](https://www.youtube.com/@TheFlutterWay)
- [Reso Coder](https://www.youtube.com/@ResoCoder)
- [Flutter Explained](https://www.youtube.com/@FlutterExplained)

### Official Documentation
- [Firebase Flutter Documentation](https://firebase.flutter.dev/)
- [FlutterFire Github](https://github.com/FirebaseExtended/flutterfire)
- [Firebase Auth Documentation](https://firebase.google.com/docs/auth)

### Search Terms
- "Firebase Flutter setup"
- "Firebase authentication Flutter"
- "Google sign in Flutter"
- "Flutter Firebase complete tutorial"
- "Firebase email password auth Flutter"

## Deliverables Checklist

- ✅ Firebase integrated app
- ✅ Email/password authentication
- ✅ Google Sign-In working
- ✅ Auth state stream implemented
- ✅ User profile screen
- ✅ README with Firebase setup
- ✅ Login/Register screens with validation
- ✅ Authentication state management
- ✅ Error handling
- ✅ Responsive UI

## Next Steps

1. **Setup Firebase Project** (Step 1-2)
2. **Configure Flutter** (Step 3-6)
3. **Test Locally** (Step 9)
4. **Deploy to Firebase Hosting** (Future)
5. **Add Advanced Features** (Future)

## Support

For issues with:
- **Firebase**: Visit [Firebase Support](https://firebase.google.com/support)
- **Flutter**: Visit [Flutter Issues](https://github.com/flutter/flutter/issues)
- **FlutterFire**: Visit [FlutterFire Issues](https://github.com/FirebaseExtended/flutterfire/issues)
