import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appName = ref.watch(appNameProvider);

    final counter = ref.watch(counterProvider);

    final tasks = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(title: Text(appName)),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [
            Text("Counter", style: TextStyle(fontSize: 22)),

            Text("${counter}", style: TextStyle(fontSize: 40)),

            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state++;
              },

              child: Text("Increase"),
            ),

            Divider(),

            Text("Tasks", style: TextStyle(fontSize: 22)),

            ElevatedButton(
              onPressed: () {
                ref.read(taskProvider.notifier).addTask("Learn Riverpod");
              },

              child: Text("Add Task"),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,

                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(tasks[index].title),

                    value: tasks[index].completed,

                    onChanged: (value) {
                      ref.read(taskProvider.notifier).toggleTask(index);
                    },
                  );
                },
              ),
            ),

            Consumer(
              builder: (context, ref, child) {
                final user = ref.watch(userProvider);

                return user.when(
                  loading: () => CircularProgressIndicator(),

                  error: (e, stack) => Text("Error"),

                  data: (name) => Text("API User: $name"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
