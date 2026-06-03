import 'package:flutter/material.dart';

class ListBuilderScreen extends StatelessWidget {
  static const routeName = '/list-builder';

  const ListBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListView Builder')),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemCount: 150,
          separatorBuilder: (context, index) =>
              const Divider(height: 1, indent: 16, endIndent: 16),
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text('Sample item ${index + 1}'),
              subtitle: Text('This is details for item number ${index + 1}.'),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
