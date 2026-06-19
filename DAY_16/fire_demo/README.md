# Firebase Authentication Flutter App

A complete Flutter application demonstrating Firebase Authentication with email/password and Google Sign-In authentication methods.

## Features Implemented

### ✅ Authentication
- **Email/Password Authentication**
  - User registration with validation
  - Secure login
  - Logout functionality
  - Password visibility toggle

- **Google Sign-In**
  - One-tap Google Sign-In
  - Automatic Firebase integration
  - Profile data retrieval

### ✅ User Management
- User profile display
- Account information
- Email verification status
- Authentication provider tracking
- Account creation timestamp

### ✅ State Management
- Real-time auth state monitoring
- Stream-based navigation
- Provider for dependency injection
- Automatic redirect based on auth state

### ✅ UI/UX
- Clean, modern Material Design UI
- Form validation
- Error handling and display
- Loading states
- Responsive layout
- Password strength indicators

## Project Structure

```
lib/
├── main.dart                         # App entry point and Firebase initialization
├── firebase_options.dart             # Firebase configuration (auto-generated)
├── services/
│   └── auth_service.dart            # Firebase authentication logic
├── models/
│   └── user_model.dart              # User data model
├── screens/
│   ├── auth_wrapper.dart            # Auth state-based navigation
│   ├── login_screen.dart            # Login with email/password and Google
│   ├── register_screen.dart         # User registration
│   ├── home_screen.dart             # Main app home after auth
│   └── profile_screen.dart          # Detailed user profile display
```

## Getting Started

### Prerequisites
- Flutter SDK 3.9.2+
- Firebase Account
- Android SDK (for Android builds)
- Xcode (optional, for iOS builds)

### 1. Firebase Project Setup

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Enable Authentication → Email/Password and Google providers
3. Register Android app with package: `com.example.fire_demo`
4. Download `google-services.json` and place in `android/app/`

### 2. Install FlutterFire CLI

```bash
dart pub global activate flutterfire_cli
```

### 3. Configure Firebase

```bash
cd fire_demo
flutterfire configure
```

This generates `firebase_options.dart` with your Firebase credentials.

### 4. Install Dependencies

```bash
flutter pub get
```

### 5. Run the App

```bash
flutter run
```

## Authentication Flow

### Login Flow
1. User enters email and password or clicks "Sign in with Google"
2. Firebase authenticates credentials
3. `authStateChanges()` stream emits user data
4. App automatically navigates to HomeScreen
5. User can view profile and logout

### Registration Flow
1. User enters name, email, password
2. Form validation checks email format and password strength
3. Firebase creates new user account
4. Display name is set in user profile
5. User redirected to login screen
6. Can now login with new credentials

### Logout Flow
1. User clicks "Sign Out"
2. Confirmation dialog appears
3. Both Firebase and Google Sign-In are signed out
4. App returns to LoginScreen

## Key Classes

### AuthService
Manages all Firebase authentication operations:
- `signUpWithEmail()` - Create new account
- `signInWithEmail()` - Login with email/password
- `signInWithGoogle()` - Google Sign-In
- `signOut()` - Logout
- `resetPassword()` - Password reset
- `authStateChanges` - Stream of auth state changes
- `currentUser` - Get current logged-in user

### UserModel
Represents user data:
- `uid` - Unique user identifier
- `email` - User email
- `displayName` - User's display name
- `photoUrl` - User's profile picture URL
- `createdAt` - Account creation timestamp

### Screens
- **AuthWrapper**: Listens to auth state and routes to appropriate screen
- **LoginScreen**: Email/password login + Google Sign-In
- **RegisterScreen**: New account creation with validation
- **HomeScreen**: Post-login dashboard with user info
- **ProfileScreen**: Detailed profile information display

## Error Handling

The app handles various Firebase auth exceptions:
- Invalid email format
- Weak password
- Email already in use
- User not found
- Wrong password
- Account disabled
- And more...

All errors are displayed to the user with clear, actionable messages.

## Form Validation

### Login Form
- Email: Required and valid format
- Password: Required, minimum 6 characters

### Registration Form
- Name: Required, non-empty
- Email: Required and valid format
- Password: Required, minimum 6 characters
- Confirm Password: Must match password field

## Testing

### Test Email/Password Auth
1. Register: new@example.com / password123 / John Doe
2. Logout
3. Login: new@example.com / password123
4. View profile

### Test Google Sign-In
1. Tap "Sign in with Google"
2. Select your Google account
3. Grant permissions
4. View profile with Google data

### Test Error Cases
1. Enter invalid email
2. Enter password < 6 chars
3. Register with existing email
4. Login with wrong password

## Firebase Console Configuration

### Email/Password Provider
- Enable email and password sign-up
- Optional: Enable email link sign-in
- Optional: Send verification email

### Google Provider
1. Get Google OAuth credentials
2. Configure OAuth consent screen
3. Add test users if in development
4. Enable Google Sign-In provider

### Security Rules
Keep default rules during development:
```
{
  "rules": {
    ".read": "auth != null",
    ".write": "auth != null"
  }
}
```

## Dependencies

- **firebase_core**: Firebase initialization
- **firebase_auth**: Firebase Authentication
- **google_sign_in**: Google Sign-In integration
- **provider**: Dependency injection and state management
- **intl**: Date formatting utilities
- **cupertino_icons**: iOS-style icons

## Build and Deployment

### Android Build
```bash
flutter build apk
```

### iOS Build
```bash
flutter build ios
```

### Web Build
```bash
flutter build web
```

## Performance Considerations

1. **Auth State Caching**: Firebase caches auth state locally
2. **Provider Pattern**: Singleton AuthService reduces multiple listeners
3. **Lazy Loading**: Screens only load when needed
4. **Image Caching**: Profile images cached by Flutter
5. **Stream Optimization**: One auth state stream for entire app

## Security Best Practices

1. ✅ Passwords never stored in code
2. ✅ Firebase handles secure credential storage
3. ✅ Google OAuth 2.0 for social auth
4. ✅ HTTPS for all Firebase connections
5. ✅ Email verification ready for implementation
6. ✅ Password reset mechanism

## Future Enhancements

1. **Email Verification**
   - Send verification email after signup
   - Verify before first login

2. **Password Recovery**
   - "Forgot Password" link
   - Email reset flow

3. **Profile Updates**
   - Edit display name
   - Upload profile picture
   - Link/unlink auth providers

4. **Advanced Auth**
   - Phone authentication
   - Two-factor authentication
   - Biometric authentication

5. **Data Persistence**
   - Firestore user profiles
   - Save user preferences
   - Activity history

## Resources

### Official Documentation
- [Firebase Flutter Documentation](https://firebase.flutter.dev/)
- [Firebase Authentication](https://firebase.google.com/docs/auth)
- [Google Sign-In for Flutter](https://pub.dev/packages/google_sign_in)

### Learning Resources
- [Firebase Authentication Tutorial](https://www.youtube.com/results?search_query=firebase+flutter+authentication)
- [Flutter Provider Pattern](https://www.youtube.com/results?search_query=flutter+provider+pattern)
- [Firebase Console Guide](https://firebase.google.com/docs/projects/learn-more)

### YouTube Channels
- The Flutter Way
- Reso Coder
- Flutter Explained
- Fireship.io

## Troubleshooting

### Issue: google-services.json not found
```bash
flutterfire configure
```

### Issue: Firebase initialization error
- Check internet connection
- Verify Firebase credentials in firebase_options.dart
- Ensure app is registered in Firebase console

### Issue: Google Sign-In not working
- Check OAuth credentials in Google Cloud Console
- Verify package name in Firebase console
- Clear app cache and reinstall

### Issue: Hot reload not working with Firebase
- Stop and restart the app (full rebuild)
- Run `flutter clean && flutter pub get`

## Support & Contribution

For issues or improvements:
- Check [Firebase Support](https://firebase.google.com/support)
- Review [Flutter Issues](https://github.com/flutter/flutter/issues)
- Check [FlutterFire Issues](https://github.com/FirebaseExtended/flutterfire/issues)

## License

This project is open source and available under the MIT License.

---

**Last Updated**: 2024
**Flutter Version**: 3.9.2+
**Firebase Core**: 3.1.0+
