import 'package:flutter/material.dart';
import '../widgets/debug_card.dart';
import 'performance_screen.dart';
import 'error_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Debugging Demo")),

      body: Column(
        children: [
          DebugCard(
            title: "Logging Demo",
            description: "print() and debugPrint()",
            onTap: () {
              print("Normal Print Executed");

              debugPrint("Debug Print Executed");
            },
          ),

          DebugCard(
            title: "Performance Testing",
            description: "Check rebuild optimization",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PerformanceScreen(),
                ),
              );
            },
          ),

          DebugCard(
            title: "Error Handling",
            description: "Generate and handle errors",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ErrorScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
