// Calculates a student grade average and letter grade.
// Run with: dart run mini_projects/student_grade_calculator.dart

void main() {
  List<double> grades = [87.5, 92.0, 78.5, 85.0];
  double average =
      grades.reduce((value, element) => value + element) / grades.length;

  print('Grades: $grades');
  print('Average grade: ${average.toStringAsFixed(1)}');
  print('Letter grade: ${letterGrade(average)}');
}

String letterGrade(double score) {
  if (score >= 90) return 'A';
  if (score >= 80) return 'B';
  if (score >= 70) return 'C';
  if (score >= 60) return 'D';
  return 'F';
}
