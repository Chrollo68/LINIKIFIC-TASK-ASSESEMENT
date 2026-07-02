import '../models/progress_model.dart';
import '../models/workout_model.dart';

class WorkoutService {
  Future<List<WorkoutModel>> getWorkouts() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return const [
      WorkoutModel(
        id: '1',
        title: 'Morning Cardio',
        duration: '20 min',
        calories: 220,
        difficulty: 'Easy',
        icon: '🏃',
        description:
            'A brisk start to the day with smooth cardiovascular movement.',
      ),
      WorkoutModel(
        id: '2',
        title: 'Core Strength',
        duration: '15 min',
        calories: 180,
        difficulty: 'Medium',
        icon: '🧠',
        description: 'Stability and strength focused core circuits.',
      ),
      WorkoutModel(
        id: '3',
        title: 'HIIT Burn',
        duration: '25 min',
        calories: 320,
        difficulty: 'Hard',
        icon: '⚡',
        description: 'High intensity rounds to push your endurance.',
      ),
      WorkoutModel(
        id: '4',
        title: 'Yoga Flow',
        duration: '18 min',
        calories: 140,
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
