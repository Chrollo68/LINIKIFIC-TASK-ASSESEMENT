class Post {
  final int userId;
  final int? id;
  final String title;
  final String body;

  Post({
    required this.userId,
    this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int?,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'userId': userId,
      'title': title,
      'body': body,
    };
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }
}
