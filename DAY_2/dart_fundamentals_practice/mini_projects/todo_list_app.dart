// Simple todo list logic with add, complete and print operations.
// Run with: dart run mini_projects/todo_list_app.dart

class TodoItem {
  String title;
  bool completed;

  TodoItem(this.title, {this.completed = false});
}

void main() {
  List<TodoItem> todos = [TodoItem('Buy groceries'), TodoItem('Update resume')];

  todos.add(TodoItem('Send report'));
  todos[1].completed = true;

  print('Todo list:');
  for (var item in todos) {
    print('- ${item.title} [${item.completed ? 'done' : 'pending'}]');
  }
}
