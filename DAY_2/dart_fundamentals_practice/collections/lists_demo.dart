// Demonstrates Dart list usage with a student roster example.
// Run with: dart run collections/lists_demo.dart

void main() {
  List<String> studentNames = ['Amina', 'Diego', 'Leila'];
  print('Initial students: $studentNames');

  studentNames.add('Noah');
  print('After adding a student: $studentNames');

  studentNames.remove('Diego');
  print('After removing a student: $studentNames');

  int enrolledCount = studentNames.length;
  print('Students enrolled: $enrolledCount');

  List<String> upperNames = studentNames
      .map((name) => name.toUpperCase())
      .toList();
  print('Uppercase names: $upperNames');
}
