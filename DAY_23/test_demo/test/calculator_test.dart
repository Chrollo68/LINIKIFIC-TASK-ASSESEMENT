import 'package:flutter_test/flutter_test.dart';
import 'package:test_demo/calculator.dart';

void main() {
  group("Calculator Tests", () {
    final calculator = Calculator();

    test("Addition test", () {
      final result = calculator.add(5, 3);

      expect(result, 8);
    });

    test("Subtraction test", () {
      final result = calculator.subtract(10, 4);

      expect(result, 6);
    });

    test("Multiplication test", () {
      final result = calculator.multiply(5, 5);

      expect(result, 25);
    });

    test("Division test", () {
      final result = calculator.divide(10, 2);

      expect(result, 5);
    });

    test("Division by zero should throw error", () {
      expect(() => calculator.divide(5, 0), throwsException);
    });
  });
}
