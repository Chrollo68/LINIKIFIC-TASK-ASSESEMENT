import 'package:floor/floor.dart';

import '../entities/note.dart';

@dao
abstract class NoteDao {
  @Query("SELECT * FROM notes")
  Future<List<Note>> getAllNotes();

  @Query("SELECT * FROM notes WHERE id = :id")
  Future<Note?> getNoteById(int id);

  @Insert()
  Future<void> insertNote(Note note);

  @Update()
  Future<void> updateNote(Note note);

  @delete
  Future<void> deleteNote(Note note);
}
