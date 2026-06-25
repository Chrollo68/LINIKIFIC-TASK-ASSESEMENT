class Task {
  final String title;
  final bool completed;

  Task({required this.title, this.completed = false});

  Task copyWith({bool? completed}) {
    return Task(title: title, completed: completed ?? this.completed);
  }
}
