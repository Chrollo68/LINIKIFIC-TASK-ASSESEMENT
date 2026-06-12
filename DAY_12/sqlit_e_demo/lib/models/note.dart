class Note {
  final int? id;
  final String title;
  final String description;
  final String createdAt;

  Note({
    this.id,

    required this.title,

    required this.description,

    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'title': title,

      'description': description,

      'createdAt': createdAt,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],

      title: map['title'],

      description: map['description'],

      createdAt: map['createdAt'],
    );
  }
}
