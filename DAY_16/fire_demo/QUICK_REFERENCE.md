# Firebase Authentication - Quick Reference Guide

## Installation & Setup

### Add Dependencies to pubspec.yaml
```yaml
dependencies:
  firebase_core: ^3.1.0
  firebase_auth: ^5.1.0
  google_sign_in: ^6.2.1
  provider: ^6.2.0
  intl: ^0.19.0
```

### Install Packages
```bash
flutter pub get
```

### Configure Firebase (Recommended)
```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

## Firebase Initialization

### In main.dart
```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
```

## Authentication Methods

### Email/Password Sign Up
```dart
try {
  final UserCredential credential = 
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: 'user@example.com',
      password: 'password123',
    );
  
  // Update display name
  await credential.user?.updateDisplayName('John Doe');
  await credential.user?.reload();
  
  print('User created: ${credential.user?.uid}');
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('Password too weak');
  } else if (e.code == 'email-already-in-use') {
    print('Email already exists');
  }
}
```

### Email/Password Sign In
```dart
try {
  final UserCredential credential = 
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'user@example.com',
      password: 'password123',
    );
  
  print('Signed in: ${credential.user?.email}');
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found');
  } else if (e.code == 'wrong-password') {
    print('Wrong password');
  }
}
```

### Google Sign In
```dart
try {
  final GoogleSignInAccount? googleUser = 
    await GoogleSignIn().signIn();

  if (googleUser == null) {
    print('Sign in cancelled');
    return;
  }

  final GoogleSignInAuthentication googleAuth = 
    await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final UserCredential userCredential = 
    await FirebaseAuth.instance.signInWithCredential(credential);
  
  print('Signed in: ${userCredential.user?.displayName}');
} catch (e) {
  print('Google Sign-In failed: $e');
}
```

### Sign Out
```dart
// Sign out from Firebase
await FirebaseAuth.instance.signOut();

// Sign out from Google (if using Google Sign-In)
await GoogleSignIn().signOut();

// Combined
await Future.wait([
  FirebaseAuth.instance.signOut(),
  GoogleSignIn().signOut(),
]);
```

## User Management

### Get Current User
```dart
final User? user = FirebaseAuth.instance.currentUser;

if (user != null) {
  print('UID: ${user.uid}');
  print('Email: ${user.email}');
  print('Display Name: ${user.displayName}');
  print('Photo URL: ${user.photoURL}');
  print('Email Verified: ${user.emailVerified}');
}
```

### Update User Profile
```dart
final User? user = FirebaseAuth.instance.currentUser;

if (user != null) {
  // Update display name
  await user.updateDisplayName('New Name');
  
  // Update profile picture
  await user.updatePhotoURL('https://example.com/photo.jpg');
  
  // Reload user data
  await user.reload();
}
```

### Send Password Reset Email
```dart
try {
  await FirebaseAuth.instance.sendPasswordResetEmail(
    email: 'user@example.com',
  );
  print('Password reset email sent');
} on FirebaseAuthException catch (e) {
  print('Error: ${e.message}');
}
```

### Send Email Verification
```dart
final User? user = FirebaseAuth.instance.currentUser;

if (user != null && !user.emailVerified) {
  await user.sendEmailVerification();
  print('Verification email sent');
}
```

## Authentication State Management

### Listen to Auth State Changes
```dart
FirebaseAuth.instance.authStateChanges().listen((User? user) {
  if (user == null) {
    print('User logged out');
  } else {
    print('User logged in: ${user.email}');
  }
});
```

### Listen to ID Token Changes
```dart
FirebaseAuth.instance.idTokenChanges().listen((User? user) {
  if (user == null) {
    print('User not authenticated');
  } else {
    print('User authenticated');
  }
});
```

### Listen to User Changes
```dart
FirebaseAuth.instance.userChanges().listen((User? user) {
  if (user == null) {
    print('User profile not available');
  } else {
    print('User profile: ${user.displayName}');
  }
});
```

### Get Future (not stream)
```dart
Future<User?> getUser() async {
  return FirebaseAuth.instance.currentUser;
}
```

## Flutter Widget Patterns

### Stream Builder for Auth State
```dart
StreamBuilder<User?>(
  stream: FirebaseAuth.instance.authStateChanges(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    if (snapshot.hasData && snapshot.data != null) {
      return HomeScreen(user: snapshot.data!);
    }
    
    return LoginScreen();
  },
)
```

### Provider Pattern
```dart
// Create AuthService
class AuthService {
  Future<void> signUp(String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

// Provide service
MultiProvider(
  providers: [
    Provider<AuthService>(create: (_) => AuthService()),
  ],
  child: MyApp(),
)

// Use service
final authService = Provider.of<AuthService>(context);
```

## Error Handling

### Handle Firebase Auth Exceptions
```dart
try {
  // Firebase operation
} on FirebaseAuthException catch (e) {
  String errorMessage = '';
  
  switch (e.code) {
    case 'weak-password':
      errorMessage = 'Password is too weak';
      break;
    case 'email-already-in-use':
      errorMessage = 'Email already registered';
      break;
    case 'invalid-email':
      errorMessage = 'Invalid email format';
      break;
    case 'operation-not-allowed':
      errorMessage = 'Operation not allowed';
      break;
    case 'user-disabled':
      errorMessage = 'User account is disabled';
      break;
    case 'user-not-found':
      errorMessage = 'User not found';
      break;
    case 'wrong-password':
      errorMessage = 'Incorrect password';
      break;
    case 'invalid-credential':
      errorMessage = 'Invalid credentials';
      break;
    case 'too-many-requests':
      errorMessage = 'Too many attempts. Try again later';
      break;
    default:
      errorMessage = e.message ?? 'Unknown error occurred';
  }
  
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(errorMessage)),
  );
}
```

## Form Validation

### Email Validation
```dart
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
  );
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}
```

### Password Validation
```dart
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}
```

### Password Match Validation
```dart
String? validatePasswordMatch(String? value, String password) {
  if (value == null || value.isEmpty) {
    return 'Confirm password is required';
  }
  if (value != password) {
    return 'Passwords do not match';
  }
  return null;
}
```

## Firebase Console Codes

### Provider IDs
```
password       // Email/Password
google.com     // Google
facebook.com   // Facebook
apple.com      // Apple
phone          // Phone
anonymous      // Anonymous
```

### Common Error Codes
```
auth/admin-restricted-operation
auth/argument-error
auth/app-deleted
auth/app-not-authorized
auth/argument-error
auth/captcha-check-failed
auth/code-expired
auth/cordova-not-ready
auth/cors-unsupported
auth/credential-already-in-use
auth/custom-token-mismatch
auth/depends-on-cordova
auth/dynamic-link-not-activated
auth/email-already-in-use
auth/expired-action-code
auth/expired-oidc-id-token
auth/expired-popup-request
auth/extra-generic-oauth-scopes
auth/federated-user-id-already-linked
auth/firebase-app-not-initialized
auth/google-populate-user-record-failed
auth/idp-already-linked
auth/idle-timeout
auth/illegal-argument
auth/insufficient-permission
auth/internal-error
auth/invalid-api-key
auth/invalid-argument
auth/invalid-auth-event
auth/invalid-cert-hash
auth/invalid-code
auth/invalid-config
auth/invalid-continue-uri
auth/invalid-credential
auth/invalid-custom-token
auth/invalid-dynamic-link-domain
auth/invalid-email
auth/invalid-message-payload
auth/invalid-oauth-client-id
auth/invalid-oauth-provider
auth/invalid-operation-type
auth/invalid-persistence-type
auth/invalid-phone-number
auth/invalid-provider-id
auth/invalid-recipient-email
auth/invalid-sender
auth/invalid-user-import-options
auth/internal-error
auth/invalid-verification-code
auth/invalid-verification-id
auth/missing-android-pkg-name
auth/missing-app-credential
auth/missing-app-check-token
auth/missing-auth-domain
auth/missing-client-version
auth/missing-continue-uri
auth/missing-iframe-start
auth/missing-ios-bundle-id
auth/missing-or-invalid-nonce
auth/missing-phone-number
auth/missing-public-client-id
auth/missing-verification-code
auth/missing-verification-id
auth/mod-go-fetch-error
auth/needs-redirect-fix
auth/network-request-failed
auth/null-user
auth/no-auth-event
auth/no-signing-certificate
auth/operation-not-allowed
auth/operation-not-supported-in-this-environment
auth/popup-blocked
auth/popup-closed-by-user
auth/provider-already-linked
auth/quota-exceeded
auth/redirect-cancelled-by-user
auth/redirect-operation-pending
auth/rejected-credential
auth/remote-service-exception
auth/removed-app
auth/repo-operation-failed
auth/required-cross-origin-auth-event-error
auth/response-type-not-set
auth/rpc-error
auth/second-factor-already-in-use
auth/second-factor-limit-exceeded
auth/sender-email-mismatch
auth/session-expired
auth/setting-country-code-failed
auth/sign-in-cancelled
auth/too-many-attempts-try-later
auth/too-many-requests
auth/uid-already-exists
auth/unauthorized
auth/unsupported-first-factor
auth/unsupported-oauth-client-type
auth/unsupported-operation
auth/unsupported-persistence-type
auth/unsupported-tenant-operation
auth/unverified-email
auth/user-cancelled
auth/user-deleted
auth/user-disabled
auth/user-mismatch
auth/user-not-found
auth/user-signed-out
auth/username-already-exists
auth/weak-password
auth/webauthn-not-supported
auth/wrong-password
auth/wrapping-key-error
auth/xcode-not-set
```

## Quick Troubleshooting

### Issue: "Firebase not initialized"
```dart
// Solution: Add this in main()
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
```

### Issue: "google-services.json not found"
```bash
# Solution: Run flutterfire configure again
flutterfire configure
```

### Issue: "Google Sign-In returns null"
```dart
// Solution: Check if user cancelled
final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
if (googleUser == null) {
  print('User cancelled sign-in');
  return;
}
```

### Issue: "User stays logged in after uninstall"
```dart
// This is normal - Firebase persists locally
// Clean up: Use Firebase console to delete user or
await FirebaseAuth.instance.signOut();
```

## Performance Tips

1. **Cache user data**
   ```dart
   final user = FirebaseAuth.instance.currentUser;
   ```

2. **Use `listen: false` when not rebuilding**
   ```dart
   final auth = Provider.of<AuthService>(context, listen: false);
   ```

3. **Optimize streams**
   ```dart
   Stream<User?> get authStateChanges => 
     _firebaseAuth.authStateChanges();
   ```

4. **Use const constructors**
   ```dart
   const LoginScreen()
   ```

5. **Lazy load images**
   ```dart
   Image.network(
     url,
     cacheHeight: 200,
     cacheWidth: 200,
   )
   ```

## Testing Checklist

- [ ] Email/password registration works
- [ ] Email/password login works
- [ ] Email/password logout works
- [ ] Google Sign-In works
- [ ] Error messages display correctly
- [ ] Forms validate input
- [ ] Loading states appear
- [ ] User data displays correctly
- [ ] Navigation works after auth
- [ ] App remembers login after restart

---

**Quick Links:**
- [Firebase Docs](https://firebase.flutter.dev/)
- [Flutter Provider](https://pub.dev/packages/provider)
- [Google Sign-In](https://pub.dev/packages/google_sign_in)
