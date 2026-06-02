// Demonstrates Dart loops: for, while, for-in, and forEach.
// Run with: dart run basics/loops_demo.dart

void main() {
  List<String> topics = ['variables', 'loops', 'functions', 'classes'];

  print('For loop output:');
  for (int index = 0; index < topics.length; index++) {
    print('Topic ${index + 1}: ${topics[index]}');
  }

  print('\nWhile loop output:');
  int count = 0;
  while (count < topics.length) {
    print('Round ${count + 1}: ${topics[count]}');
    count++;
  }

  print('\nFor-in loop output:');
  for (String topic in topics) {
    print(topic);
  }

  print('\nforEach output:');
  topics.forEach((topic) => print('Topic: $topic'));
}
