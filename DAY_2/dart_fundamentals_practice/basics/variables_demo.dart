// Demonstrates Dart variable declarations and basic data types.
// Run with: dart run basics/variables_demo.dart

void main() {
  // var allows type inference and can be reassigned.
  var studentName = 'Amina';
  print('Student name (var): $studentName');

  studentName = 'Ravi';
  print('Student name updated: $studentName');

  // final creates a single-assignment variable.
  final int age = 21;
  print('Student age (final): $age');

  // const creates a compile-time constant.
  const double pi = 3.14159;
  print('Circle constant (const): $pi');

  // Using a String.
  String course = 'Dart Fundamentals';
  print('Course name: $course');

  // Boolean values.
  bool isEnrolled = true;
  print('Is enrolled: $isEnrolled');

  // List of scores.
  List<int> scores = [88, 92, 75];
  print('Initial scores: $scores');

  // Map for student details.
  Map<String, dynamic> studentInfo = {
    'name': studentName,
    'age': age,
    'course': course,
  };
  print('Student info: $studentInfo');

  // Simple arithmetic example.
  int quizScore = 15;
  int totalScore = quizScore + 5;
  print('Quiz score plus bonus: $totalScore');

  // Comparison example.
  bool passed = totalScore >= 20;
  print('Passed quiz threshold: $passed');

  // Logical operator example.
  bool readyToLearn = isEnrolled && passed;
  print('Ready to learn more: $readyToLearn');
}
