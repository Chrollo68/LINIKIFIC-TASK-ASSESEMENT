import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/task.dart';

// --------------------
// Provider
// Read only value
// --------------------

final appNameProvider = Provider<String>((ref) {
  return "Riverpod Demo App";
});

// --------------------
// StateProvider
// Simple state
// --------------------

final counterProvider = StateProvider<int>((ref) {
  return 0;
});

// --------------------
// StateNotifierProvider
// Complex state
// --------------------

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  void addTask(String title) {
    state = [...state, Task(title: title)];
  }

  void toggleTask(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          state[i].copyWith(completed: !state[i].completed)
        else
          state[i],
    ];
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});

// --------------------
// FutureProvider
// API simulation
// --------------------

final userProvider = FutureProvider<String>((ref) async {
  await Future.delayed(Duration(seconds: 2));

  return "John Doe";
});
