# SETUP_INSTRUCTIONS.md

# Firebase Authentication Setup - Step by Step

This guide walks you through setting up and running the Firebase Authentication demo app.

## Prerequisites
- Flutter SDK 3.9.2 or higher
- Android Studio (for Android SDK)
- Firebase Account (free tier works)
- Internet connection

## Setup Process

### STEP 1: Create Firebase Project (5 minutes)

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **Create a project**
3. Enter project name: `flutter-auth-demo`
4. Select your country
5. Click **Create project**
6. Wait for project to be created

### STEP 2: Enable Authentication (2 minutes)

1. In Firebase Console, click **Authentication** (left sidebar)
2. Click **Get started**
3. Click **Email/Password** provider
4. Toggle **Enable** to ON
5. Click **Save**

### STEP 3: Enable Google Sign-In (2 minutes)

1. In Authentication, click **Sign-in method** tab
2. Click **Google**
3. Toggle **Enable** to ON
4. Select a Google Cloud Project (or create new)
5. Configure OAuth consent screen (required)
   - Select "External"
   - Fill in app name and email
   - Add scope: email profile openid
   - Add test users (your email)
6. Click **Save**

### STEP 4: Register Android App (3 minutes)

1. In Firebase Console, click **Project settings** (gear icon)
2. Click **Your apps** section
3. Click **Add app** → **Android**
4. Enter:
   - Package name: `com.example.fire_demo`
   - App nickname: `fire_demo`
5. Download `google-services.json`
6. Place file in: `android/app/`

### STEP 5: (Optional) Register iOS App (3 minutes)

1. In Firebase Console, click **Add app** → **iOS**
2. Enter:
   - Bundle ID: `com.example.firDemo`
   - App nickname: `fire_demo`
3. Download `GoogleService-Info.plist`
4. Place file in: `ios/Runner/`

### STEP 6: Install FlutterFire CLI (2 minutes)

```bash
dart pub global activate flutterfire_cli
```

Add to PATH if needed:
```bash
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

### STEP 7: Configure Flutter for Firebase (3 minutes)

```bash
# Navigate to project directory
cd fire_demo

# Run flutterfire configure
flutterfire configure

# Select your Firebase project
# Select platforms (Android/iOS/Web)

# This generates firebase_options.dart automatically
```

**What this does:**
- Reads google-services.json
- Generates firebase_options.dart with credentials
- Updates Android/iOS/Web configurations

### STEP 8: Install Dependencies (3 minutes)

```bash
flutter pub get
```

This installs:
- firebase_core
- firebase_auth
- google_sign_in
- provider
- intl

### STEP 9: Clean and Build (2 minutes)

```bash
flutter clean
flutter pub get
```

### STEP 10: Run the App (2 minutes)

```bash
flutter run
```

Or for specific device:
```bash
flutter run -d android
flutter run -d ios
flutter run -d chrome
```

## First Time Testing (10 minutes)

### Test Email/Password Registration:
1. Tap **Register** on login screen
2. Enter:
   - Name: `Test User`
   - Email: `test@example.com`
   - Password: `password123`
   - Confirm: `password123`
3. Tap **Register**
4. Should return to login screen
5. Tap **Sign In**
6. Enter email and password
7. Tap **Sign In**
8. Should see home screen with your info

### Test Google Sign-In:
1. Tap **Sign in with Google**
2. Select your Google account
3. Grant permissions
4. Should see home screen with Google profile data

### Test Logout:
1. On home screen, tap **Sign Out**
2. Confirm logout
3. Should return to login screen

## Troubleshooting

### Error: "google-services.json not found"
```bash
# Solution: Run flutterfire configure again
flutterfire configure
```

### Error: "Firebase initialization failed"
- Check google-services.json exists in android/app/
- Check internet connection
- Verify Firebase project is created

### Error: "Google Sign-In returns null"
- This is normal if user cancels
- Check OAuth consent screen is configured
- Verify package name in Firebase console

### Error: "Build failed"
```bash
# Solution: Clean and rebuild
flutter clean
flutter pub get
flutter run
```

### Error: "Gradle build failed"
- Ensure google-services.json is in android/app/
- Update Android SDK in Android Studio
- Try: `flutter pub get && flutter build apk`

### Error: "Dart analysis errors"
- Run: `flutter clean`
- Run: `flutter pub get`
- VS Code: Reload window (Ctrl+Shift+P → Reload Window)

## Verification Checklist

✅ Firebase project created
✅ google-services.json downloaded and placed
✅ FlutterFire CLI installed
✅ flutterfire configure run
✅ firebase_options.dart generated
✅ flutter pub get completed
✅ App runs without errors
✅ Can register with email/password
✅ Can login with email/password
✅ Can login with Google
✅ User profile displays correctly
✅ Can logout successfully

## Next Steps After Setup

1. **Explore the Code:**
   - Read lib/main.dart
   - Review lib/services/auth_service.dart
   - Check each screen implementation

2. **Understand Authentication:**
   - Read FIREBASE_SETUP_GUIDE.md
   - Review LEARNING_CONCEPTS.md
   - Study code patterns in QUICK_REFERENCE.md

3. **Test Features:**
   - Register multiple users
   - Test error cases (wrong password, etc.)
   - Check Firebase console for user data
   - Verify user appears in Firebase Authentication

4. **Customize:**
   - Change app colors/theme
   - Add your logo
   - Modify form fields
   - Add additional screens

5. **Extend:**
   - Add password reset UI
   - Implement email verification
   - Add profile picture upload
   - Implement Firestore database

## Important Files

| File | Purpose |
|------|---------|
| `lib/main.dart` | App entry point, Firebase initialization |
| `lib/services/auth_service.dart` | All authentication logic |
| `lib/screens/login_screen.dart` | Login UI |
| `lib/screens/register_screen.dart` | Registration UI |
| `lib/screens/home_screen.dart` | Post-login dashboard |
| `android/app/google-services.json` | Android credentials |
| `firebase_options.dart` | Configuration (auto-generated) |
| `pubspec.yaml` | Dependencies |

## Quick Commands Reference

```bash
# Install dependencies
flutter pub get

# Run app
flutter run

# Clean everything
flutter clean

# Configure Firebase
flutterfire configure

# Build APK (Android)
flutter build apk

# Build IPA (iOS)
flutter build ios

# Build Web
flutter build web

# Check for errors
flutter analyze
```

## Firebase Console Tasks

### Monitor Users in Firebase Console:
1. Go to Firebase Console
2. Select your project
3. Click **Authentication**
4. Click **Users** tab
5. View all registered users
6. See their sign-in methods

### Check Activity Logs:
1. Go to Firebase Console
2. Go to **Authentication**
3. Click **Activity logs**
4. See all login attempts
5. Check for errors

## Common Firebase Console Operations

### Delete a Test User:
1. Go to Users list
2. Select user
3. Click delete button
4. Confirm deletion

### Reset Password:
1. Go to Users list
2. Find user
3. Click menu (3 dots)
4. Click "Reset Password"
5. Firebase sends reset email

### Add Custom Claims:
1. Go to Users list
2. Select user
3. Scroll down to "Custom claims"
4. Enter JSON claims
5. Click Save

## Security Reminders

🔐 **Always:**
- Never hardcode credentials
- Keep google-services.json private
- Use environment variables for secrets
- Enable HTTPS for all connections
- Update packages regularly
- Monitor Firebase console
- Review authentication logs

❌ **Never:**
- Share google-services.json publicly
- Commit credentials to Git
- Store passwords in code
- Disable security rules
- Use test accounts in production
- Ignore authentication errors

## Getting Help

### If something doesn't work:
1. Check Troubleshooting section above
2. Read FIREBASE_SETUP_GUIDE.md
3. Review error message carefully
4. Check Firebase console for errors
5. See QUICK_REFERENCE.md for code examples

### Official Resources:
- Firebase Docs: https://firebase.flutter.dev/
- Flutter Docs: https://flutter.dev/
- Stack Overflow: Tag with 'firebase', 'flutter'
- GitHub Issues: github.com/FirebaseExtended/flutterfire/issues

## Success Indicators

You'll know everything is working when:

✅ App launches without errors
✅ Register button creates new account
✅ Login button signs in user
✅ User profile displays correctly
✅ Logout button signs out
✅ Google Sign-In works
✅ User appears in Firebase console
✅ No console errors

## Estimated Time

| Task | Time |
|------|------|
| Firebase project setup | 5 min |
| Configure authentication | 10 min |
| Register Android app | 5 min |
| Download google-services.json | 2 min |
| Install FlutterFire CLI | 3 min |
| Configure Flutter | 5 min |
| Install dependencies | 3 min |
| Run app | 3 min |
| **Total** | **~35 min** |

## You're Ready! 🎉

Once you complete all steps above, you have a fully functional Firebase Authentication app with:
- ✅ Email/password authentication
- ✅ Google Sign-In
- ✅ User profile display
- ✅ Production-ready code
- ✅ Complete documentation

## Next: Start Learning

Now that setup is complete:
1. Read [README.md](README.md) for overview
2. Check [LEARNING_CONCEPTS.md](LEARNING_CONCEPTS.md) to understand how it works
3. Review [QUICK_REFERENCE.md](QUICK_REFERENCE.md) for code patterns
4. Explore [INDEX.md](INDEX.md) for full documentation

## Questions?

See [FIREBASE_SETUP_GUIDE.md](FIREBASE_SETUP_GUIDE.md) for detailed step-by-step guide.

---

**Setup Time:** ~35 minutes
**Status:** Ready to begin
**Next:** Read README.md
