class ProgressModel {
  const ProgressModel({
    required this.calories,
    required this.water,
    required this.workoutsCompleted,
    required this.bmi,
    this.goalProgress = 0.0,
    this.focusProgress = 0.0,
    this.recoveryProgress = 0.0,
    this.overallProgress = 0.0,
  });

  final double calories;
  final double water;
  final int workoutsCompleted;
  final double bmi;
  final double goalProgress;
  final double focusProgress;
  final double recoveryProgress;
  final double overallProgress;

  ProgressModel copyWith({
    double? calories,
    double? water,
    int? workoutsCompleted,
    double? bmi,
    double? goalProgress,
    double? focusProgress,
    double? recoveryProgress,
    double? overallProgress,
  }) {
    return ProgressModel(
      calories: calories ?? this.calories,
      water: water ?? this.water,
      workoutsCompleted: workoutsCompleted ?? this.workoutsCompleted,
      bmi: bmi ?? this.bmi,
      goalProgress: goalProgress ?? this.goalProgress,
      focusProgress: focusProgress ?? this.focusProgress,
      recoveryProgress: recoveryProgress ?? this.recoveryProgress,
      overallProgress: overallProgress ?? this.overallProgress,
    );
  }
}
