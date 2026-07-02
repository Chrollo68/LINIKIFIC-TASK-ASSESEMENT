class WorkoutModel {
  const WorkoutModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.calories,
    required this.difficulty,
    required this.icon,
    required this.description,
  });

  final String id;
  final String title;
  final String duration;
  final int calories;
  final String difficulty;
  final String icon;
  final String description;
}
