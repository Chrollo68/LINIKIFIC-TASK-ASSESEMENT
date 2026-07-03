import '../config/supabase_config.dart';
import '../models/workout_model.dart';

class SupabaseWorkoutService {
  /// Add a new workout
  Future<WorkoutModel?> addWorkout({
    required int userId,
    required String title,
    required int duration,
    required int calories,
    required DateTime date,
  }) async {
    try {
      final response = await SupabaseConfig.client
          .from('workouts')
          .insert({
            'user_id': userId,
            'title': title,
            'duration': duration,
            'calories': calories,
            'date': date.toIso8601String().split('T')[0],
          })
          .select()
          .single();

      final workout = WorkoutModel.fromJson(response);
      return workout;
    } catch (e) {
      print('Add workout error: $e');
      return null;
    }
  }

  /// Get all workouts for a user
  Future<List<WorkoutModel>> getUserWorkouts(int userId) async {
    try {
      final response = await SupabaseConfig.client
          .from('workouts')
          .select()
          .eq('user_id', userId)
          .order('date', ascending: false);

      final workouts = (response as List).map((json) {
        return WorkoutModel.fromJson(json as Map<String, dynamic>);
      }).toList();

      return workouts;
    } catch (e) {
      print('Get workouts error: $e');
      return [];
    }
  }

  /// Get workouts for a specific date
  Future<List<WorkoutModel>> getWorkoutsByDate(
    int userId,
    DateTime date,
  ) async {
    try {
      final dateString = date.toIso8601String().split('T')[0];

      final response = await SupabaseConfig.client
          .from('workouts')
          .select()
          .eq('user_id', userId)
          .eq('date', dateString)
          .order('date', ascending: false);

      final workouts = (response as List).map((json) {
        return WorkoutModel.fromJson(json as Map<String, dynamic>);
      }).toList();

      return workouts;
    } catch (e) {
      print('Get workouts by date error: $e');
      return [];
    }
  }

  /// Update a workout
  Future<WorkoutModel?> updateWorkout({
    required int workoutId,
    required String title,
    required int duration,
    required int calories,
    required DateTime date,
  }) async {
    try {
      final response = await SupabaseConfig.client
          .from('workouts')
          .update({
            'title': title,
            'duration': duration,
            'calories': calories,
            'date': date.toIso8601String().split('T')[0],
          })
          .eq('id', workoutId)
          .select()
          .single();

      final workout = WorkoutModel.fromJson(response);
      return workout;
    } catch (e) {
      print('Update workout error: $e');
      return null;
    }
  }

  /// Delete a workout
  Future<bool> deleteWorkout(int workoutId) async {
    try {
      await SupabaseConfig.client.from('workouts').delete().eq('id', workoutId);

      return true;
    } catch (e) {
      print('Delete workout error: $e');
      return false;
    }
  }

  /// Get total calories burned by user on a specific date
  Future<int> getTotalCaloriesByDate(int userId, DateTime date) async {
    try {
      final dateString = date.toIso8601String().split('T')[0];

      final response = await SupabaseConfig.client
          .from('workouts')
          .select('calories')
          .eq('user_id', userId)
          .eq('date', dateString);

      int totalCalories = 0;
      for (var item in response as List) {
        totalCalories += (item['calories'] as int);
      }

      return totalCalories;
    } catch (e) {
      print('Get total calories error: $e');
      return 0;
    }
  }

  /// Get total workouts completed by user
  Future<int> getTotalWorkoutsCount(int userId) async {
    try {
      final response = await SupabaseConfig.client
          .from('workouts')
          .select('id')
          .eq('user_id', userId);

      return (response as List).length;
    } catch (e) {
      print('Get total workouts count error: $e');
      return 0;
    }
  }

  /// Get average duration of workouts
  Future<double> getAverageDuration(int userId) async {
    try {
      final response = await SupabaseConfig.client
          .from('workouts')
          .select('duration')
          .eq('user_id', userId);

      if (response.isEmpty) return 0.0;

      int totalDuration = 0;
      for (var item in response as List) {
        totalDuration += (item['duration'] as int);
      }

      return totalDuration / response.length;
    } catch (e) {
      print('Get average duration error: $e');
      return 0.0;
    }
  }
}
