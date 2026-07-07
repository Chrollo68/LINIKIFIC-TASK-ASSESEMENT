class RoutineStep {
  final String title;
  final String description;
  final int durationSeconds;

  RoutineStep({
    required this.title,
    required this.description,
    this.durationSeconds = 60,
  });
}

class WorkoutRoutine {
  final String id;
  final String title;
  final String description;
  final int minutesPerDay;
  final String? imageAsset;
  final List<RoutineStep> steps;

  WorkoutRoutine({
    required this.id,
    required this.title,
    required this.description,
    this.minutesPerDay = 20,
    this.imageAsset,
    this.steps = const [],
  });
}

class WorkoutRoutineService {
  WorkoutRoutineService._();
  static final WorkoutRoutineService instance = WorkoutRoutineService._();

  List<WorkoutRoutine> getRoutinesForBmi(double bmi) {
    if (bmi <= 0) return _defaultRoutines();

    if (bmi < 18.5) {
      return [
        WorkoutRoutine(
          id: 'strength_gain',
          title: 'Strength & Gain',
          description: 'Full-body strength 3x/week + calorie surplus guidance',
          minutesPerDay: 30,
          imageAsset: null,
          steps: [
            RoutineStep(
              title: 'Warm-up',
              description: 'Joint mobility',
              durationSeconds: 180,
            ),
            RoutineStep(
              title: 'Squats',
              description: '3 sets of 8-12 reps',
              durationSeconds: 300,
            ),
            RoutineStep(
              title: 'Push-ups',
              description: '3 sets of 8-12 reps',
              durationSeconds: 180,
            ),
            RoutineStep(
              title: 'Cool-down',
              description: 'Stretching',
              durationSeconds: 180,
            ),
          ],
        ),
        WorkoutRoutine(
          id: 'core_stability',
          title: 'Core Stability',
          description: 'Daily gentle core and mobility exercises',
          minutesPerDay: 15,
          imageAsset: null,
          steps: [
            RoutineStep(
              title: 'Plank',
              description: '3 x 30s holds',
              durationSeconds: 90,
            ),
            RoutineStep(
              title: 'Bird dog',
              description: '2 x 10 each side',
              durationSeconds: 120,
            ),
            RoutineStep(
              title: 'Hip bridges',
              description: '2 x 12 reps',
              durationSeconds: 120,
            ),
          ],
        ),
      ];
    }

    if (bmi < 25) {
      return [
        WorkoutRoutine(
          id: 'balanced_fitness',
          title: 'Balanced Fitness',
          description: 'Mix of cardio and strength 4x/week',
          minutesPerDay: 30,
          steps: [
            RoutineStep(
              title: 'Warm-up',
              description: 'Light jog 5 min',
              durationSeconds: 300,
            ),
            RoutineStep(
              title: 'Circuit',
              description: '3 rounds of bodyweight circuit',
              durationSeconds: 900,
            ),
            RoutineStep(
              title: 'Cool-down',
              description: 'Stretch 5 min',
              durationSeconds: 300,
            ),
          ],
        ),
        WorkoutRoutine(
          id: 'hiit_boost',
          title: 'HIIT Boost',
          description: 'High intensity intervals 2x/week to maintain fitness',
          minutesPerDay: 20,
          steps: [
            RoutineStep(
              title: 'Warm-up',
              description: 'Dynamic mobility 3 min',
              durationSeconds: 180,
            ),
            RoutineStep(
              title: 'Intervals',
              description: '8 rounds 30s on / 30s off',
              durationSeconds: 480,
            ),
            RoutineStep(
              title: 'Cool-down',
              description: 'Stretch 2 min',
              durationSeconds: 120,
            ),
          ],
        ),
      ];
    }

    if (bmi < 30) {
      return [
        WorkoutRoutine(
          id: 'fat_loss_focus',
          title: 'Fat Loss Focus',
          description:
              'Cardio + resistance training 5x/week with calorie deficit',
          minutesPerDay: 35,
          steps: [
            RoutineStep(
              title: 'Warm-up',
              description: 'Brisk walk 5 min',
              durationSeconds: 300,
            ),
            RoutineStep(
              title: 'Cardio',
              description: '30 min moderate cardio',
              durationSeconds: 1800,
            ),
            RoutineStep(
              title: 'Cool-down',
              description: 'Stretch 5 min',
              durationSeconds: 300,
            ),
          ],
        ),
        WorkoutRoutine(
          id: 'active_recovery',
          title: 'Active Recovery',
          description: 'Mobility, walking and stretching on rest days',
          minutesPerDay: 15,
          steps: [
            RoutineStep(
              title: 'Walk',
              description: 'Gentle walk 15 min',
              durationSeconds: 900,
            ),
            RoutineStep(
              title: 'Stretch',
              description: 'Full body stretch 10 min',
              durationSeconds: 600,
            ),
          ],
        ),
      ];
    }

    // BMI >= 30
    return [
      WorkoutRoutine(
        id: 'beginner_weight_loss',
        title: 'Beginner Weight Loss',
        description: 'Low-impact cardio and progressive resistance 5x/week',
        minutesPerDay: 25,
        steps: [
          RoutineStep(
            title: 'Warm-up',
            description: 'Mobility 5 min',
            durationSeconds: 300,
          ),
          RoutineStep(
            title: 'Low-impact cardio',
            description: 'Bike or walk 20 min',
            durationSeconds: 1200,
          ),
          RoutineStep(
            title: 'Cool-down',
            description: 'Stretch 5 min',
            durationSeconds: 300,
          ),
        ],
      ),
      WorkoutRoutine(
        id: 'mobility_strength',
        title: 'Mobility & Strength',
        description: 'Focus on joint-friendly strength and daily mobility',
        minutesPerDay: 20,
        steps: [
          RoutineStep(
            title: 'Joint mobility',
            description: '5 min',
            durationSeconds: 300,
          ),
          RoutineStep(
            title: 'Resistance',
            description: 'Light resistance 3 sets',
            durationSeconds: 600,
          ),
          RoutineStep(
            title: 'Stretch',
            description: '5 min',
            durationSeconds: 300,
          ),
        ],
      ),
    ];
  }

  List<WorkoutRoutine> _defaultRoutines() => [
    WorkoutRoutine(
      id: 'getting_started',
      title: 'Getting Started',
      description: 'Light activity daily plus basic strength 3x/week',
      minutesPerDay: 20,
      steps: [
        RoutineStep(title: 'Walk', description: '10 min', durationSeconds: 600),
        RoutineStep(
          title: 'Bodyweight circuit',
          description: '10-15 min',
          durationSeconds: 900,
        ),
      ],
    ),
  ];
}
