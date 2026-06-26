import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/counter_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final CounterController controller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Packages Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Counter value', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Obx(
              () => Text(
                controller.counter.value.toString(),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: controller.increment,
              child: const Text('Increment Counter'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Get.toNamed('/api'),
              child: const Text('Go to API Demo'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Get.toNamed('/storage'),
              child: const Text('Go to Hive Demo'),
            ),
          ],
        ),
      ),
    );
  }
}
