import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/counter_provider.dart';
import '../providers/todo_provider.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Provider Demo")),

      body: Column(
        children: [
          // COUNTER
          Consumer<CounterProvider>(
            builder: (context, counter, child) {
              return Column(
                children: [
                  Text(
                    "Count: ${counter.count}",

                    style: TextStyle(fontSize: 30),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),

                        onPressed: () {
                          context.read<CounterProvider>().decrement();
                        },
                      ),

                      IconButton(
                        icon: Icon(Icons.add),

                        onPressed: () {
                          context.read<CounterProvider>().increment();
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),

          Divider(),

          // TODO INPUT
          TextField(
            controller: controller,

            decoration: InputDecoration(hintText: "Enter Todo"),
          ),

          ElevatedButton(
            onPressed: () {
              context.read<TodoProvider>().addTodo(controller.text);

              controller.clear();
            },

            child: Text("Add Todo"),
          ),

          // TODO LIST
          Expanded(
            child: Consumer<TodoProvider>(
              builder: (context, todo, child) {
                return ListView.builder(
                  itemCount: todo.todos.length,

                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Text(
                        todo.todos[index].title,

                        style: TextStyle(
                          decoration: todo.todos[index].completed
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),

                      value: todo.todos[index].completed,

                      onChanged: (value) {
                        todo.toggleTodo(index);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
