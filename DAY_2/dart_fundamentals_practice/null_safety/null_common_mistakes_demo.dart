// Demonstrates common null-safety mistakes and proper fixes.
// Run with: dart run null_safety/null_common_mistakes_demo.dart

void main() {
  String? nullableText = 'Hello';

  // Mistake: using non-null variable without verifying nullability.
  print('Safe access length: ${nullableText.length}');

  // Mistake: unsafe assertion can crash if value is null.
  nullableText = null;
  if (nullableText == null) {
    print('Value is null, skipping unsafe access.');
  }

  // Correct use of ?? to provide fallback.
  String message = nullableText ?? 'Default message';
  print(message);
}
