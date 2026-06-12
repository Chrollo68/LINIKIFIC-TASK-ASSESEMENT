import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/note.dart';
import '../widgets/note_card.dart';
import 'add_edit_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();

    loadNotes();
  }

  void loadNotes() async {
    notes = await DatabaseHelper.instance.getAllNotes();

    setState(() {});
  }

  void searchNotes(String value) async {
    if (value.isEmpty) {
      loadNotes();

      return;
    }

    notes = await DatabaseHelper.instance.search(value);

    setState(() {});
  }

  void deleteNote(int id) async {
    await DatabaseHelper.instance.delete(id);

    loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Notes")),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () async {
          await Navigator.push(
            context,

            MaterialPageRoute(builder: (_) => const AddEditNoteScreen()),
          );

          loadNotes();
        },
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),

            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search notes",

                border: OutlineInputBorder(),
              ),

              onChanged: searchNotes,
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: notes.length,

              itemBuilder: (context, index) {
                return NoteCard(
                  note: notes[index],

                  onDelete: () {
                    deleteNote(notes[index].id!);
                  },

                  onTap: () async {
                    await Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) => AddEditNoteScreen(note: notes[index]),
                      ),
                    );

                    loadNotes();
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
