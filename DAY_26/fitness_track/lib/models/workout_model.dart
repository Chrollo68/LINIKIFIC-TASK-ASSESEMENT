class WorkoutModel {
  const WorkoutModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.duration,
    required this.calories,
    required this.date,
    this.difficulty = 'Medium',
    this.icon = '🏋️',
    this.description = '',
  });

  final int id;
  final int userId;
  final String title;
  final int duration;
  final int calories;
  final DateTime date;
  final String difficulty;
  final String icon;
  final String description;

  /// Convert WorkoutModel to JSON map for Supabase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'duration': duration,
      'calories': calories,
      'date': date.toIso8601String().split('T')[0], // Store as DATE
    };
  }

  /// Create WorkoutModel from JSON map
  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      title: json['title'] as String,
      duration: json['duration'] as int,
      calories: json['calories'] as int,
      date: DateTime.parse(json['date'] as String),
    );
  }

  WorkoutModel copyWith({
    int? id,
    int? userId,
    String? title,
    int? duration,
    int? calories,
    DateTime? date,
    String? difficulty,
    String? icon,
    String? description,
  }) {
    return WorkoutModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      calories: calories ?? this.calories,
      date: date ?? this.date,
      difficulty: difficulty ?? this.difficulty,
      icon: icon ?? this.icon,
      description: description ?? this.description,
    );
  }
}
