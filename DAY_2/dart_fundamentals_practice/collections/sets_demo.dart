// Demonstrates Dart set usage with a task list example.
// Run with: dart run collections/sets_demo.dart

void main() {
  Set<String> tasks = {'review code', 'write tests', 'deploy app'};
  print('Initial tasks: $tasks');

  tasks.add('write docs');
  print('After adding a task: $tasks');

  tasks.add('review code');
  print('After attempting duplicate add: $tasks');

  bool hasDeploy = tasks.contains('deploy app');
  print('Contains deploy app: $hasDeploy');
}
