// Demonstrates Dart arithmetic, comparison, and logical operators.
// Run with: dart run basics/operators_demo.dart

void main() {
  int x = 12;
  int y = 5;

  print('x = $x, y = $y');
  print('Addition: ${x + y}');
  print('Subtraction: ${x - y}');
  print('Multiplication: ${x * y}');
  print('Division: ${x / y}');
  print('Integer division: ${x ~/ y}');
  print('Modulo: ${x % y}');

  bool isGreater = x > y;
  bool isEqual = x == y;
  bool isDifferent = x != y;
  print('x > y: $isGreater');
  print('x == y: $isEqual');
  print('x != y: $isDifferent');

  bool onTime = true;
  bool hasResources = false;
  print('Can start project: ${onTime && hasResources}');
  print('Needs follow-up: ${onTime && !hasResources}');
  print('Ready or pending: ${onTime || hasResources}');
}
