import 'package:flutter/material.dart';

import '../database/app_database.dart';
import '../entities/note.dart';
import '../repository/note_repository.dart';

class NotesScreen extends StatefulWidget {
  final AppDatabase database;

  const NotesScreen(this.database, {super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late NoteRepository repository;

  List<Note> notes = [];

  @override
  void initState() {
    super.initState();

    repository = NoteRepository(widget.database.noteDao);

    loadNotes();
  }

  void loadNotes() async {
    final result = await repository.getNotes();

    setState(() {
      notes = result;
    });
  }

  void addNote() async {
    final note = Note(title: "New Note", content: "Floor Database");

    await repository.addNote(note);

    loadNotes();
  }

  void deleteNote(Note note) async {
    await repository.deleteNote(note);

    loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Floor Notes")),

      floatingActionButton: FloatingActionButton(
        onPressed: addNote,

        child: const Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: notes.length,

        itemBuilder: (context, index) {
          final note = notes[index];

          return ListTile(
            title: Text(note.title),

            subtitle: Text(note.content),

            trailing: IconButton(
              icon: const Icon(Icons.delete),

              onPressed: () {
                deleteNote(note);
              },
            ),
          );
        },
      ),
    );
  }
}
