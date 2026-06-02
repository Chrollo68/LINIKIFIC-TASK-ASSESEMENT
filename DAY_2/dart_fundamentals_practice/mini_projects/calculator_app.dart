// Simple console calculator logic.
// Run with: dart run mini_projects/calculator_app.dart

void main() {
  double a = 12.5;
  double b = 4.0;

  print('Calculator operations for $a and $b');
  print('Add: ${add(a, b)}');
  print('Subtract: ${subtract(a, b)}');
  print('Multiply: ${multiply(a, b)}');
  print('Divide: ${divide(a, b)}');
}

double add(double x, double y) => x + y;

double subtract(double x, double y) => x - y;

double multiply(double x, double y) => x * y;

double divide(double x, double y) {
  if (y == 0) {
    throw ArgumentError('Cannot divide by zero');
  }
  return x / y;
}
