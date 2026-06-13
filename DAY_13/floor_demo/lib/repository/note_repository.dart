import '../dao/note_dao.dart';
import '../entities/note.dart';

class NoteRepository {
  final NoteDao dao;

  NoteRepository(this.dao);

  Future<List<Note>> getNotes() {
    return dao.getAllNotes();
  }

  Future<void> addNote(Note note) {
    return dao.insertNote(note);
  }

  Future<void> updateNote(Note note) {
    return dao.updateNote(note);
  }

  Future<void> deleteNote(Note note) {
    return dao.deleteNote(note);
  }
}
