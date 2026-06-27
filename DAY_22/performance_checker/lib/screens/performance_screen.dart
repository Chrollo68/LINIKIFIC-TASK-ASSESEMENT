import 'package:flutter/material.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    debugPrint("Widget Rebuilt");

    return Scaffold(
      appBar: AppBar(title: const Text("Performance Demo")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Text("This widget uses const optimization"),

            Text("Count : $counter"),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
              },

              child: const Text("Update State"),
            ),
          ],
        ),
      ),
    );
  }
}
