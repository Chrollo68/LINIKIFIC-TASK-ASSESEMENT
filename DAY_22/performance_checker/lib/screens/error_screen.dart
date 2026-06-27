import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/crash_service.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  String message = "Press a button to test errors";

  void divideByZero() {
    try {
      int value = 10 ~/ 0;

      setState(() {
        message = "Result: $value";
      });
    } catch (error, stackTrace) {
      CrashService.logError(error, stackTrace);

      setState(() {
        message = "Division error handled successfully";
      });
    }
  }

  void nullError() {
    try {
      String? name;

      if (kDebugMode) {
        print(name!.length);
      }
    } catch (error, stackTrace) {
      CrashService.logError(error, stackTrace);

      setState(() {
        message = "Null error handled";
      });
    }
  }

  void testCrash() {
    CrashService.generateTestCrash();

    setState(() {
      message = "Test crash captured in logs";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error Handling Demo")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(message, style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: divideByZero,

              child: const Text("Division By Zero Error"),
            ),

            ElevatedButton(
              onPressed: nullError,

              child: const Text("Null Exception"),
            ),

            ElevatedButton(
              onPressed: testCrash,

              child: const Text("Generate Test Crash"),
            ),
          ],
        ),
      ),
    );
  }
}
