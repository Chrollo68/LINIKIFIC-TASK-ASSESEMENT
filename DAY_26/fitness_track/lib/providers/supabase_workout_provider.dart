import 'package:flutter/material.dart';
import '../models/progress_model.dart';
import '../models/workout_model.dart';
import '../services/supabase_workout_service.dart';

class SupabaseWorkoutProvider extends ChangeNotifier {
  SupabaseWorkoutProvider();

  final _service = SupabaseWorkoutService();
  List<WorkoutModel> _workouts = [];
  List<WorkoutModel> _todayWorkouts = [];
  ProgressModel _progress = const ProgressModel(
    calories: 0,
    water: 0,
    workoutsCompleted: 0,
    bmi: 0,
  );
  bool _isLoading = false;
  String? _errorMessage;

  List<WorkoutModel> get workouts => _workouts;
  List<WorkoutModel> get todayWorkouts => _todayWorkouts;
  ProgressModel get progress => _progress;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Load all workouts for a user
  Future<void> loadWorkouts(int userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _workouts = await _service.getUserWorkouts(userId);
      await _updateProgress(userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load workouts: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load today's workouts
  Future<void> loadTodayWorkouts(int userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _todayWorkouts = await _service.getWorkoutsByDate(userId, DateTime.now());
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load today\'s workouts: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Add a new workout
  Future<WorkoutModel?> addWorkout({
    required int userId,
    required String title,
    required int duration,
    required int calories,
    required DateTime date,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final workout = await _service.addWorkout(
        userId: userId,
        title: title,
        duration: duration,
        calories: calories,
        date: date,
      );

      if (workout != null) {
        _workouts.add(workout);
        _todayWorkouts.add(workout);
        await _updateProgress(userId);
        _isLoading = false;
        notifyListeners();
        return workout;
      }
    } catch (e) {
      _errorMessage = 'Failed to add workout: $e';
    }

    _isLoading = false;
    notifyListeners();
    return null;
  }

  /// Update a workout
  Future<WorkoutModel?> updateWorkout({
    required int workoutId,
    required String title,
    required int duration,
    required int calories,
    required DateTime date,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedWorkout = await _service.updateWorkout(
        workoutId: workoutId,
        title: title,
        duration: duration,
        calories: calories,
        date: date,
      );

      if (updatedWorkout != null) {
        final index = _workouts.indexWhere((w) => w.id == workoutId);
        if (index != -1) {
          _workouts[index] = updatedWorkout;
        }
        _isLoading = false;
        notifyListeners();
        return updatedWorkout;
      }
    } catch (e) {
      _errorMessage = 'Failed to update workout: $e';
    }

    _isLoading = false;
    notifyListeners();
    return null;
  }

  /// Delete a workout
  Future<bool> deleteWorkout(int workoutId, int userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _service.deleteWorkout(workoutId);
      if (success) {
        _workouts.removeWhere((w) => w.id == workoutId);
        _todayWorkouts.removeWhere((w) => w.id == workoutId);
        await _updateProgress(userId);
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      _errorMessage = 'Failed to delete workout: $e';
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  /// Update progress statistics
  Future<void> _updateProgress(int userId) async {
    try {
      final totalWorkouts = await _service.getTotalWorkoutsCount(userId);
      final todayCalories = await _service.getTotalCaloriesByDate(
        userId,
        DateTime.now(),
      );
      await _service.getAverageDuration(userId);

      _progress = ProgressModel(
        calories: todayCalories.toDouble(),
        water: _progress.water,
        workoutsCompleted: totalWorkouts,
        bmi: _progress.bmi,
      );
      notifyListeners();
    } catch (e) {
      print('Error updating progress: $e');
    }
  }

  /// Complete a workout (mark as done)
  void completeWorkout(WorkoutModel workout) {
    _progress = _progress.copyWith(
      calories: _progress.calories + workout.calories,
      workoutsCompleted: _progress.workoutsCompleted + 1,
    );
    notifyListeners();
  }

  /// Update water intake
  void updateWater(int amount) {
    _progress = _progress.copyWith(water: _progress.water + amount);
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
