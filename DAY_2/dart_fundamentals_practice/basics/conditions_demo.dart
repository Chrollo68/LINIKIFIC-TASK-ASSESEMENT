// Demonstrates Dart if/else and switch statements.
// Run with: dart run basics/conditions_demo.dart

void main() {
  int score = 74;

  if (score >= 90) {
    print('Grade: A');
  } else if (score >= 75) {
    print('Grade: B');
  } else if (score >= 60) {
    print('Grade: C');
  } else {
    print('Grade: Needs improvement');
  }

  String status = 'pending';
  switch (status) {
    case 'completed':
      print('The task is completed.');
      break;
    case 'pending':
      print('The task is pending review.');
      break;
    case 'cancelled':
      print('The task has been cancelled.');
      break;
    default:
      print('Unknown task status.');
  }
}
