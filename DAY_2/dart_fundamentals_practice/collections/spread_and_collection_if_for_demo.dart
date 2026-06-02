// Demonstrates Dart spread operator, collection if, and collection for.
// Run with: dart run collections/spread_and_collection_if_for_demo.dart

void main() {
  List<String> morningTasks = ['review email', 'team meeting'];
  List<String> afternoonTasks = ['code review', 'document work'];

  List<String> allTasks = [...morningTasks, ...afternoonTasks];
  print('All tasks: $allTasks');

  bool includeBonus = true;
  List<String> projectTasks = [
    'design review',
    if (includeBonus) 'prepare demo',
  ];
  print('Project tasks: $projectTasks');

  List<String> repeatedTasks = [for (var task in projectTasks) 'Task: $task'];
  print('Repeated tasks: $repeatedTasks');
}
