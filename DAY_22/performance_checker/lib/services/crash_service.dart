import 'package:flutter/foundation.dart';
// Uncomment after adding Firebase Crashlytics
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashService {
  // Log normal application errors
  static void logError(Object error, StackTrace stackTrace) {
    debugPrint("Error: $error");

    debugPrint("StackTrace: $stackTrace");

    /*
    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      fatal: false,
    );
    */
  }

  // Simulate a crash for testing
  static void generateTestCrash() {
    try {
      throw Exception("This is a test crash generated for debugging");
    } catch (error, stackTrace) {
      logError(error, stackTrace);
    }
  }

  // Example async error handling

  static Future<void> fetchData() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      throw Exception("Network request failed");
    } catch (error, stackTrace) {
      logError(error, stackTrace);
    }
  }
}
