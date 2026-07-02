import 'package:flutter/material.dart';

import '../models/progress_model.dart';
import '../models/workout_model.dart';
import '../services/workout_service.dart';

class WorkoutProvider extends ChangeNotifier {
  WorkoutProvider() {
    _service = WorkoutService();
    _progress = _service.getInitialProgress();
  }

  late final WorkoutService _service;
  List<WorkoutModel> _workouts = [];
  ProgressModel _progress = const ProgressModel(
    calories: 540,
    water: 1800,
    workoutsCompleted: 3,
    bmi: 23.2,
  );
  bool _isLoading = false;

  List<WorkoutModel> get workouts => _workouts;
  ProgressModel get progress => _progress;
  bool get isLoading => _isLoading;

  Future<void> loadWorkouts() async {
    _isLoading = true;
    notifyListeners();
    _workouts = await _service.getWorkouts();
    _isLoading = false;
    notifyListeners();
  }

  void completeWorkout(WorkoutModel workout) {
    _progress = _progress.copyWith(
      calories: _progress.calories + workout.calories / 2,
      workoutsCompleted: _progress.workoutsCompleted + 1,
    );
    notifyListeners();
  }

  void updateWater(int amount) {
    _progress = _progress.copyWith(water: _progress.water + amount);
    notifyListeners();
  }
}
