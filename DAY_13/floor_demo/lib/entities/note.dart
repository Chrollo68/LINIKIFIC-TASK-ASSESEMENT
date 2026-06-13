import 'package:floor/floor.dart';

@Entity(tableName: "notes")
class Note {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String title;

  final String content;

  Note({this.id, required this.title, required this.content});
}
