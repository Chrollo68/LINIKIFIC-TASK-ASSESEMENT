import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/note.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  const AddEditNoteScreen({super.key, this.note});

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final title = TextEditingController();

  final description = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      title.text = widget.note!.title;

      description.text = widget.note!.description;
    }
  }

  void save() async {
    final note = Note(
      id: widget.note?.id,

      title: title.text,

      description: description.text,

      createdAt: DateTime.now().toString(),
    );

    if (widget.note == null) {
      await DatabaseHelper.instance.insert(note);
    } else {
      await DatabaseHelper.instance.update(note);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? "Add Note" : "Edit Note"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: title,

              decoration: const InputDecoration(labelText: "Title"),
            ),

            TextField(
              controller: description,

              decoration: const InputDecoration(labelText: "Description"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(onPressed: save, child: const Text("SAVE")),
          ],
        ),
      ),
    );
  }
}
