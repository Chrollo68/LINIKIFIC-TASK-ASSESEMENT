import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CompletedWorkout {
  final int workoutId;
  final String title;
  final int duration;
  final int calories;
  final DateTime completedAt;

  CompletedWorkout({
    required this.workoutId,
    required this.title,
    required this.duration,
    required this.calories,
    required this.completedAt,
  });

  Map<String, dynamic> toJson() => {
    'workoutId': workoutId,
    'title': title,
    'duration': duration,
    'calories': calories,
    'completedAt': completedAt.toIso8601String(),
  };

  factory CompletedWorkout.fromJson(Map<String, dynamic> json) =>
      CompletedWorkout(
        workoutId: json['workoutId'] as int,
        title: json['title'] as String,
        duration: json['duration'] as int,
        calories: json['calories'] as int,
        completedAt: DateTime.parse(json['completedAt'] as String),
      );
}

class WorkoutTracker {
  WorkoutTracker._();
  static final WorkoutTracker _instance = WorkoutTracker._();

  factory WorkoutTracker() => _instance;

  static const String _completionKey = 'workout_completions_';
  static const String _waterKey = 'water_intake_';

  /// Get today's date key
  static String _getTodayKey(String userEmail) {
    final now = DateTime.now();
    final date =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    return '$_completionKey${userEmail}_$date';
  }

  /// Get this week's date key
  static String _getWeekKey(String userEmail) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final date =
        '${weekStart.year}-${weekStart.month.toString().padLeft(2, '0')}-${weekStart.day.toString().padLeft(2, '0')}';
    return '$_completionKey${userEmail}_week_$date';
  }

  /// Record a completed workout
  Future<void> recordWorkout(
    String userEmail,
    int workoutId,
    String title,
    int duration,
    int calories,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final todayKey = _getTodayKey(userEmail);
    final weekKey = _getWeekKey(userEmail);

    final completedWorkout = CompletedWorkout(
      workoutId: workoutId,
      title: title,
      duration: duration,
      calories: calories,
      completedAt: DateTime.now(),
    );

    // Save to today
    final todayJson = prefs.getString(todayKey) ?? '[]';
    final todayList = List<Map<String, dynamic>>.from(
      jsonDecode(todayJson) as List,
    );
    todayList.add(completedWorkout.toJson());
    await prefs.setString(todayKey, jsonEncode(todayList));

    // Save to this week
    final weekJson = prefs.getString(weekKey) ?? '[]';
    final weekList = List<Map<String, dynamic>>.from(
      jsonDecode(weekJson) as List,
    );
    weekList.add(completedWorkout.toJson());
    await prefs.setString(weekKey, jsonEncode(weekList));
  }

  /// Get today's completed workouts
  Future<List<CompletedWorkout>> getTodayWorkouts(String userEmail) async {
    final prefs = await SharedPreferences.getInstance();
    final todayKey = _getTodayKey(userEmail);
    final json = prefs.getString(todayKey) ?? '[]';
    final list = List<Map<String, dynamic>>.from(jsonDecode(json) as List);
    return list.map((e) => CompletedWorkout.fromJson(e)).toList();
  }

  /// Get this week's completed workouts
  Future<List<CompletedWorkout>> getWeekWorkouts(String userEmail) async {
    final prefs = await SharedPreferences.getInstance();
    final weekKey = _getWeekKey(userEmail);
    final json = prefs.getString(weekKey) ?? '[]';
    final list = List<Map<String, dynamic>>.from(jsonDecode(json) as List);
    return list.map((e) => CompletedWorkout.fromJson(e)).toList();
  }

  /// Get today's totals
  Future<Map<String, dynamic>> getTodayTotals(String userEmail) async {
    final workouts = await getTodayWorkouts(userEmail);
    final calories = workouts.fold<int>(0, (sum, w) => sum + w.calories);
    final duration = workouts.fold<int>(0, (sum, w) => sum + w.duration);

    return {
      'calories': calories,
      'duration': duration,
      'count': workouts.length,
    };
  }

  /// Get this week's totals
  Future<Map<String, dynamic>> getWeekTotals(String userEmail) async {
    final workouts = await getWeekWorkouts(userEmail);
    final calories = workouts.fold<int>(0, (sum, w) => sum + w.calories);
    final duration = workouts.fold<int>(0, (sum, w) => sum + w.duration);
    final uniqueDays = workouts.map((w) => w.completedAt.day).toSet().length;

    return {
      'calories': calories,
      'duration': duration,
      'count': workouts.length,
      'daysActive': uniqueDays,
    };
  }

  /// Record water intake
  Future<void> recordWater(String userEmail, int amount) async {
    final prefs = await SharedPreferences.getInstance();
    final key =
        '$_waterKey${userEmail}_${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    final current = prefs.getInt(key) ?? 0;
    await prefs.setInt(key, current + amount);
  }

  /// Get today's water intake
  Future<int> getTodayWater(String userEmail) async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final key = '$_waterKey${userEmail}_${now.year}-${now.month}-${now.day}';
    return prefs.getInt(key) ?? 0;
  }

  /// Calculate progress percentages
  Future<Map<String, double>> calculateWeekProgress(String userEmail) async {
    final weekTotals = await getWeekTotals(userEmail);
    final weekWorkouts = weekTotals['count'] as int;
    final daysActive = weekTotals['daysActive'] as int;

    // Goal: 5 workouts per week (82% for 4 workouts, 100% for 5+)
    final goalProgress = ((weekWorkouts / 5) * 100).clamp(0, 100) / 100;

    // Focus: 300 total minutes per week (68% for ~200 min, 100% for 300+)
    final focusMinutes = weekTotals['duration'] as int;
    final focusProgress = ((focusMinutes / 300) * 100).clamp(0, 100) / 100;

    // Recovery: 6 active days per week (90% for 5 days, 100% for 6)
    final recoveryProgress = ((daysActive / 6) * 100).clamp(0, 100) / 100;

    // Overall: average of all three
    final overall = (goalProgress + focusProgress + recoveryProgress) / 3;

    return {
      'goal': goalProgress,
      'focus': focusProgress,
      'recovery': recoveryProgress,
      'overall': overall,
    };
  }
}
