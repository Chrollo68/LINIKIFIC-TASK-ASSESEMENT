import 'package:flutter/material.dart';

import '../models/progress_model.dart';
import '../models/workout_model.dart';
import '../services/workout_service.dart';
import '../services/workout_tracker.dart';

class WorkoutProvider extends ChangeNotifier {
  WorkoutProvider() {
    _service = WorkoutService();
    _tracker = WorkoutTracker();
    _progress = _service.getInitialProgress();
  }

  late final WorkoutService _service;
  late final WorkoutTracker _tracker;
  List<WorkoutModel> _workouts = [];
  ProgressModel _progress = const ProgressModel(
    calories: 0,
    water: 2000,
    workoutsCompleted: 0,
    bmi: 23.2,
    goalProgress: 0,
    focusProgress: 0,
    recoveryProgress: 0,
    overallProgress: 0,
  );
  bool _isLoading = false;
  String _userEmail = '';

  List<WorkoutModel> get workouts => _workouts;
  ProgressModel get progress => _progress;
  bool get isLoading => _isLoading;

  Future<void> initializeWithUser(String userEmail) async {
    _userEmail = userEmail;
    await loadWorkouts();
    await updateProgressMetrics();
  }

  Future<void> loadWorkouts() async {
    _isLoading = true;
    notifyListeners();
    _workouts = await _service.getWorkouts();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateProgressMetrics() async {
    if (_userEmail.isEmpty) return;

    final todayTotals = await _tracker.getTodayTotals(_userEmail);
    final progressPercentages = await _tracker.calculateWeekProgress(
      _userEmail,
    );

    _progress = _progress.copyWith(
      calories: (todayTotals['calories'] as int).toDouble(),
      workoutsCompleted: todayTotals['count'] as int,
      goalProgress: progressPercentages['goal']!,
      focusProgress: progressPercentages['focus']!,
      recoveryProgress: progressPercentages['recovery']!,
      overallProgress: progressPercentages['overall']!,
    );
    notifyListeners();
  }

  Future<void> completeWorkout(WorkoutModel workout) async {
    if (_userEmail.isEmpty) return;

    await _tracker.recordWorkout(
      _userEmail,
      workout.id,
      workout.title,
      workout.duration,
      workout.calories,
    );

    await updateProgressMetrics();
    notifyListeners();
  }

  Future<void> updateWater(int amount) async {
    if (_userEmail.isEmpty) return;

    await _tracker.recordWater(_userEmail, amount);
    final waterIntake = await _tracker.getTodayWater(_userEmail);

    _progress = _progress.copyWith(water: waterIntake.toDouble());
    notifyListeners();
  }
}
