import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/routine_provider.dart';

class RoutineDetailScreen extends StatelessWidget {
  const RoutineDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routineProv = context.watch<RoutineProvider>();
    final routine = routineProv.currentRoutine;
    if (routine == null) {
      return const Scaffold(body: Center(child: Text('No routine selected')));
    }

    final step = routine.steps[routineProv.currentStepIndex];

    return Scaffold(
      appBar: AppBar(title: Text(routine.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (routine.imageAsset != null)
              Image.asset(routine.imageAsset!, height: 160, fit: BoxFit.cover),
            const SizedBox(height: 12),
            Text(step.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(step.description),
            const SizedBox(height: 24),
            Center(
              child: Text(
                '${routineProv.remainingSeconds}s',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilledButton(
                  onPressed: routineProv.previousStep,
                  child: const Text('Prev'),
                ),
                FilledButton(
                  onPressed: routineProv.isRunning
                      ? routineProv.pause
                      : routineProv.resume,
                  child: Text(routineProv.isRunning ? 'Pause' : 'Resume'),
                ),
                FilledButton(
                  onPressed: routineProv.nextStep,
                  child: const Text('Next'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            FilledButton.tonal(
              onPressed: () {
                routineProv.stop();
                Navigator.pop(context);
              },
              child: const Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }
}
