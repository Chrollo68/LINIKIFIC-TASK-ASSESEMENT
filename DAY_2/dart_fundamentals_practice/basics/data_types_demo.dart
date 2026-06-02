// Demonstrates Dart data types and printing values.
// Run with: dart run basics/data_types_demo.dart

void main() {
  int numberOfStudents = 30;
  double averageGrade = 88.4;
  String welcomeMessage = 'Welcome to Dart practice.';
  bool isClassOpen = true;
  List<String> topics = ['variables', 'functions', 'classes'];
  Map<String, String> courseDetails = {
    'title': 'Dart Fundamentals',
    'level': 'Beginner',
  };

  print('Number of students: $numberOfStudents');
  print('Average grade: $averageGrade');
  print('Message: $welcomeMessage');
  print('Is class open: $isClassOpen');
  print('Learning topics: $topics');
  print('Course details: $courseDetails');
}
