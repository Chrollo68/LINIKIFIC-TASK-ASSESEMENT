// Demonstrates async/await and try-catch in Dart.
// Run with: dart run async/async_await_demo.dart

import 'dart:async';

Future<void> main() async {
  print('Loading user profile...');

  try {
    String profile = await loadUserProfile();
    print(profile);
  } catch (error) {
    print('Error while loading profile: $error');
  }

  print('Async/await example finished.');
}

Future<String> loadUserProfile() async {
  await Future.delayed(Duration(milliseconds: 800));
  return 'User profile loaded for Sofia.';
}
