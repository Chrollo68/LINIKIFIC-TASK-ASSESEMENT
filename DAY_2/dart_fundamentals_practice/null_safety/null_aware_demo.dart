// Demonstrates Dart null-aware operators and behavior.
// Run with: dart run null_safety/null_aware_demo.dart

void main() {
  String? maybeName = null;
  print('Name with ? before assignment: $maybeName');

  print('Length using ?.: ${maybeName?.length}');

  String defaultName = maybeName ?? 'Guest';
  print('Name after ?? fallback: $defaultName');

  maybeName = 'Ariel';
  print('Name after assignment: $maybeName');
  print('Length using !: ${maybeName.length}');
}
