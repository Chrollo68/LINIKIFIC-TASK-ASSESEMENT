import '../models/progress_model.dart';
import '../models/workout_model.dart';

class WorkoutService {
  Future<List<WorkoutModel>> getWorkouts() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return [
      WorkoutModel(
        id: 1,
        userId: 1,
        title: 'Morning Cardio',
        duration: 20,
        calories: 220,
        date: DateTime.now(),
        difficulty: 'Easy',
        icon: '🏃',
        description:
            'A brisk start to the day with smooth cardiovascular movement.',
      ),
      WorkoutModel(
        id: 2,
        userId: 1,
        title: 'Core Strength',
        duration: 15,
        calories: 180,
        date: DateTime.now(),
        difficulty: 'Medium',
        icon: '🧠',
        description: 'Stability and strength focused core circuits.',
      ),
      WorkoutModel(
        id: 3,
        userId: 1,
        title: 'HIIT Burn',
        duration: 25,
        calories: 320,
        date: DateTime.now(),
        difficulty: 'Hard',
        icon: '⚡',
        description: 'High intensity rounds to push your endurance.',
      ),
      WorkoutModel(
        id: 4,
        userId: 1,
        title: 'Yoga Flow',
        duration: 18,
        calories: 140,
        date: DateTime.now(),
        difficulty: 'Easy',
        icon: '🧘',
        description: 'Gentle mobility and breathing for recovery.',
      ),
    ];
  }

  ProgressModel getInitialProgress() {
    return const ProgressModel(
      calories: 540,
      water: 1800,
      workoutsCompleted: 3,
      bmi: 23.2,
    );
  }
}
