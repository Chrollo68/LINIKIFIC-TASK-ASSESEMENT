import 'package:flutter/material.dart';

class DebugCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const DebugCard({
    super.key,

    required this.title,

    required this.description,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),

      child: ListTile(
        title: Text(title),

        subtitle: Text(description),

        trailing: const Icon(Icons.arrow_forward),

        onTap: onTap,
      ),
    );
  }
}
