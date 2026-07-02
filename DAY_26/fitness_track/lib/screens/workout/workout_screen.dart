import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/workout_provider.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/workout_card.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<WorkoutProvider>().loadWorkouts());
  }

  @override
  Widget build(BuildContext context) {
    final workoutProvider = context.watch<WorkoutProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Workouts'), centerTitle: false),
      body: workoutProvider.isLoading
          ? const LoadingWidget()
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              itemCount: workoutProvider.workouts.length,
              itemBuilder: (context, index) {
                final workout = workoutProvider.workouts[index];
                return WorkoutCard(
                  workout: workout,
                  onPressed: () {
                    workoutProvider.completeWorkout(workout);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${workout.title} started')),
                    );
                  },
                );
              },
            ),
    );
  }
}
