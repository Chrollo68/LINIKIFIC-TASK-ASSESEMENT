import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/routine_provider.dart';

class RoutinesScreen extends StatelessWidget {
  const RoutinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final routineProvider = context.read<RoutineProvider>();
    final routines = auth.recommendedRoutines;

    return Scaffold(
      appBar: AppBar(title: const Text('Routines')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: routines.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final r = routines[index];
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              title: Text(r.title),
              subtitle: Text(r.description),
              trailing: Text('${r.minutesPerDay}m'),
              onTap: () {
                routineProvider.startRoutine(r);
                Navigator.pushNamed(context, '/routines/detail');
              },
            ),
          );
        },
      ),
    );
  }
}
