import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase("notes.db");

    return _database!;
  }

  Future<Database> _initDatabase(String fileName) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future _createDatabase(Database db, int version) async {
    await db.execute('''

    CREATE TABLE notes(

      id INTEGER PRIMARY KEY AUTOINCREMENT,

      title TEXT NOT NULL,

      description TEXT,

      createdAt TEXT

    )

    ''');
  }

  Future<int> insert(Note note) async {
    final db = await database;

    return await db.insert('notes', note.toMap());
  }

  Future<List<Note>> getAllNotes() async {
    final db = await database;

    final result = await db.query('notes', orderBy: "id DESC");

    return result.map((e) => Note.fromMap(e)).toList();
  }

  Future<Note?> getNote(int id) async {
    final db = await database;

    final result = await db.query('notes', where: "id=?", whereArgs: [id]);

    if (result.isNotEmpty) {
      return Note.fromMap(result.first);
    }

    return null;
  }

  Future<int> update(Note note) async {
    final db = await database;

    return await db.update(
      'notes',

      note.toMap(),

      where: "id=?",

      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete('notes', where: "id=?", whereArgs: [id]);
  }

  Future<List<Note>> search(String query) async {
    final db = await database;

    final result = await db.query(
      'notes',

      where: "title LIKE ?",

      whereArgs: ["%$query%"],
    );

    return result.map((e) => Note.fromMap(e)).toList();
  }
}
