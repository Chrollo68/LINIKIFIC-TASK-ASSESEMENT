// Demonstrates nullable and non-nullable types in Dart.
// Run with: dart run null_safety/nullable_non_nullable_demo.dart

void main() {
  String nonNullableName = 'Sofia';
  print('Non-nullable name: $nonNullableName');

  String? nullableName;
  print('Nullable name before assignment: $nullableName');

  nullableName = 'Noor';
  print('Nullable name after assignment: $nullableName');

  // The following line would cause a compile-time error if uncommented:
  // String invalid = nullableName;
}
