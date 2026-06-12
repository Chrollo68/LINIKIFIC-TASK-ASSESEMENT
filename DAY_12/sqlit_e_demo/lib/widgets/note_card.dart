import 'package:flutter/material.dart';

import '../models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  final VoidCallback onDelete;

  final VoidCallback onTap;

  const NoteCard({
    super.key,

    required this.note,

    required this.onDelete,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,

        title: Text(note.title),

        subtitle: Text(note.description),

        trailing: IconButton(
          icon: const Icon(Icons.delete),

          onPressed: onDelete,
        ),
      ),
    );
  }
}
