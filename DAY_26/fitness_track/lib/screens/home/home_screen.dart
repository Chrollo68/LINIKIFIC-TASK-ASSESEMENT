import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/workout_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/workout_provider.dart';
import '../../services/workout_tracker.dart';
import '../../widgets/circular_stat_widget.dart';
import '../../widgets/dashboard_card.dart';
import '../../widgets/info_card.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/progress_card.dart';

class WorkoutActivity {
  final String title;
  final int duration;
  final int calories;

  WorkoutActivity({
    required this.title,
    required this.duration,
    required this.calories,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<WorkoutProvider>().loadWorkouts());
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final workoutProvider = context.watch<WorkoutProvider>();
    final user = authProvider.user;

    if (workoutProvider.isLoading) {
      return const LoadingWidget();
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning, ${user?.name.split(' ').first ?? 'Athlete'}',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              'Stay on track today',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundColor: Theme.of(
                context,
              ).colorScheme.primary.withOpacity(0.14),
              child: const Icon(Icons.notifications_none_rounded),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          DashboardCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today’s Workout',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'A balanced plan for strength and recovery.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.local_fire_department_outlined,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: InfoCard(
                  title: 'Calories',
                  value: '${workoutProvider.progress.calories.toInt()} kcal',
                  icon: Icons.local_fire_department_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InfoCard(
                  title: 'Water',
                  value: '${workoutProvider.progress.water.toInt()} ml',
                  icon: Icons.water_drop_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DashboardCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Weekly Progress',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${(workoutProvider.progress.overallProgress * 100).toStringAsFixed(0)}%',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProgressCard(
                      value: workoutProvider.progress.goalProgress.clamp(
                        0.0,
                        1.0,
                      ),
                      label: 'Goal',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    ProgressCard(
                      value: workoutProvider.progress.focusProgress.clamp(
                        0.0,
                        1.0,
                      ),
                      label: 'Focus',
                      color: Colors.orangeAccent,
                    ),
                    ProgressCard(
                      value: workoutProvider.progress.recoveryProgress.clamp(
                        0.0,
                        1.0,
                      ),
                      label: 'Recovery',
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          DashboardCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _actionChip(
                      context,
                      Icons.add,
                      'Add Water',
                      () => workoutProvider.updateWater(250),
                    ),
                    _actionChip(
                      context,
                      Icons.play_circle_fill,
                      'Complete',
                      () => workoutProvider.completeWorkout(
                        WorkoutModel(
                          id: 0,
                          userId: 1,
                          title: 'Quick Session',
                          duration: 10,
                          calories: 140,
                          date: DateTime.now(),
                          difficulty: 'Easy',
                          icon: '⚡',
                          description: 'Quick move',
                        ),
                      ),
                    ),
                    _actionChip(
                      context,
                      Icons.dark_mode_outlined,
                      'Theme',
                      () => {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          DashboardCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Activities',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                FutureBuilder<List<dynamic>>(
                  future: _buildRecentActivities(workoutProvider, authProvider),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          height: 30,
                          child: Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          'No activities yet. Complete a workout to get started!',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.6),
                              ),
                        ),
                      );
                    }

                    return Column(
                      children: (snapshot.data as List).map((activity) {
                        if (activity is WorkoutActivity) {
                          return _activityRow(
                            context,
                            activity.title,
                            '${activity.duration} min',
                            Icons.directions_run,
                          );
                        }
                        return const SizedBox.shrink();
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          DashboardCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Motivational quote',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '"Small steps every day create a stronger you."',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const CircularStatWidget(
                  value: 'BMI',
                  label: '23.2',
                  color: Color(0xFF22C55E),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<List<dynamic>> _buildRecentActivities(
    WorkoutProvider workoutProvider,
    AuthProvider authProvider,
  ) async {
    final userEmail = authProvider.user?.email ?? '';
    if (userEmail.isEmpty) return [];

    final tracker = WorkoutTracker();
    final completedWorkouts = await tracker.getTodayWorkouts(userEmail);

    return completedWorkouts
        .map(
          (w) => WorkoutActivity(
            title: w.title,
            duration: w.duration,
            calories: w.calories,
          ),
        )
        .toList();
  }

  Widget _actionChip(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.10),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  Widget _activityRow(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(
              context,
            ).colorScheme.primary.withOpacity(0.12),
            child: Icon(icon, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
