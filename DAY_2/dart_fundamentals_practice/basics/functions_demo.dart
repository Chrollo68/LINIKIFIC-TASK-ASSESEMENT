// Demonstrates Dart functions: positional, named, optional, return types, and arrow syntax.
// Run with: dart run basics/functions_demo.dart

void main() {
  print('Sum positional: ${add(8, 12)}');

  print('Greeting named: ${greet(name: 'Sam', message: 'Great work')}');

  print('Tax with optional rate: ${calculateTotal(125, taxRate: 0.08)}');
  print('Tax default rate: ${calculateTotal(125)}');

  print('Short arrow multiply: ${multiply(5, 6)}');
}

int add(int a, int b) {
  return a + b;
}

String greet({required String name, String message = 'Hello'}) {
  return '\$message, \\$name!';
}

double calculateTotal(double amount, {double taxRate = 0.1}) {
  return amount + (amount * taxRate);
}

int multiply(int a, int b) => a * b;
