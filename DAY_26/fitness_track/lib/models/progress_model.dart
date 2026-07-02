class ProgressModel {
  const ProgressModel({
    required this.calories,
    required this.water,
    required this.workoutsCompleted,
    required this.bmi,
  });

  final double calories;
  final double water;
  final int workoutsCompleted;
  final double bmi;

  ProgressModel copyWith({
    double? calories,
    double? water,
    int? workoutsCompleted,
    double? bmi,
  }) {
    return ProgressModel(
      calories: calories ?? this.calories,
      water: water ?? this.water,
      workoutsCompleted: workoutsCompleted ?? this.workoutsCompleted,
      bmi: bmi ?? this.bmi,
    );
  }
}
