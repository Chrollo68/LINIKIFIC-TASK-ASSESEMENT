class ChatMessage {
  final String id;
  final String content;
  final String userId;
  final String username;
  final DateTime createdAt;

  ChatMessage({
    required this.id,
    required this.content,
    required this.userId,
    required this.username,
    required this.createdAt,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id']?.toString() ?? '',
      content: map['content']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
      username: map['username']?.toString() ?? 'Unknown',
      createdAt:
          DateTime.tryParse(map['created_at']?.toString() ?? '') ??
          DateTime.now().toUtc(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'user_id': userId,
      'username': username,
      'created_at': createdAt.toUtc().toIso8601String(),
    };
  }
}
