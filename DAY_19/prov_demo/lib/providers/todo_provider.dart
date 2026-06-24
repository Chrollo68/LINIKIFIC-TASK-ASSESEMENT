import 'package:flutter/material.dart';

import '../models/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> todos = [];

  void addTodo(String text) {
    todos.add(Todo(title: text));

    notifyListeners();
  }

  void toggleTodo(int index) {
    todos[index].completed = !todos[index].completed;

    notifyListeners();
  }
}
