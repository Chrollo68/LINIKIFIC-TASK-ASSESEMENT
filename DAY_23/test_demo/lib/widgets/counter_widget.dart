import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Testing Demo")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(
              "$counter",

              key: const Key("counter_text"),

              style: const TextStyle(fontSize: 30),
            ),

            ElevatedButton(
              key: const Key("increment_button"),

              onPressed: increment,

              child: const Text("Increment"),
            ),
          ],
        ),
      ),
    );
  }
}
