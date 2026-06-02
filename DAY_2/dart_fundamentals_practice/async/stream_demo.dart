// Demonstrates Dart Stream basics with a task loader.
// Run with: dart run async/stream_demo.dart

import 'dart:async';

void main() {
  print('Starting task stream...');

  Stream<String> taskStream = loadTasks();
  taskStream.listen(
    (task) => print('Task ready: $task'),
    onDone: () => print('All tasks loaded.'),
    onError: (error) => print('Stream error: $error'),
  );
}

Stream<String> loadTasks() async* {
  yield 'Review requirements';
  await Future.delayed(Duration(milliseconds: 300));
  yield 'Design implementation';
  await Future.delayed(Duration(milliseconds: 300));
  yield 'Write tests';
}
