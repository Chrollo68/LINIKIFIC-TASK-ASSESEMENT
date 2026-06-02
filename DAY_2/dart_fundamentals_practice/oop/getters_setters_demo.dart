// Demonstrates Dart getters and setters in a student class.
// Run with: dart run oop/getters_setters_demo.dart

class Student {
  String _name;
  double _grade;

  Student(this._name, this._grade);

  String get name => _name;

  double get grade => _grade;

  set grade(double value) {
    if (value >= 0 && value <= 100) {
      _grade = value;
    } else {
      print('Grade must be between 0 and 100');
    }
  }
}

void main() {
  Student student = Student('Luis', 88.5);
  print('Student: ${student.name}, grade: ${student.grade}');

  student.grade = 92.3;
  print('Updated grade: ${student.grade}');

  student.grade = 120;
}
