import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);

    debugPrint("Flutter Error: ${details.exception}");
  };

  runApp(const DebugDemoApp());
}

class DebugDemoApp extends StatelessWidget {
  const DebugDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: "Flutter Debugging Demo",

      theme: ThemeData(primarySwatch: Colors.blue),

      home: const HomeScreen(),
    );
  }
}
