import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/chat_message.dart';

class ChatService {
  final SupabaseClient _client = Supabase.instance.client;
  static final ChatService instance = ChatService._();
  ChatService._();

  Stream<List<ChatMessage>> subscribeMessages() {
    return _client
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .execute()
        .map((payload) {
          final eventData = payload as List<dynamic>;
          return eventData
              .map(
                (raw) =>
                    ChatMessage.fromMap(Map<String, dynamic>.from(raw as Map)),
              )
              .toList();
        });
  }

  Future<void> sendMessage({
    required String content,
    required String userId,
    required String username,
  }) async {
    await _client.from('messages').insert({
      'content': content,
      'user_id': userId,
      'username': username,
      'created_at': DateTime.now().toUtc().toIso8601String(),
    }).execute();
  }

  Future<void> deleteMessage(String messageId) async {
    await _client.from('messages').delete().eq('id', messageId).execute();
  }
}
