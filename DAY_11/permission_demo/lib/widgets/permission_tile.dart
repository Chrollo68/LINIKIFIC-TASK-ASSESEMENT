import 'package:flutter/material.dart';

class PermissionTile extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const PermissionTile({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: ElevatedButton(
          onPressed: onPressed,
          child: const Text("Request"),
        ),
      ),
    );
  }
}
