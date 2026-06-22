import 'package:flutter/material.dart';

import '../models/chat_message.dart';
import '../models/user_profile.dart';
import '../services/chat_service.dart';
import '../services/profile_service.dart';
import '../services/supabase_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _messageController = TextEditingController();
  final _nameController = TextEditingController();
  UserProfile? _profile;
  bool _isSavingName = false;
  bool _isSendingMessage = false;

  @override
  void initState() {
    super.initState();
    _initializeProfile();
  }

  Future<void> _initializeProfile() async {
    final user = SupabaseService.instance.currentUser;
    if (user == null) return;
    final profile = await ProfileService.instance.fetchOrCreateProfile(
      UserProfile(
        id: user.id,
        email: user.email ?? '',
        fullName:
            user.userMetadata?['full_name']?.toString() ??
            user.email ??
            'Guest',
        avatarUrl: user.userMetadata?['avatar_url']?.toString() ?? '',
        createdAt: DateTime.now().toUtc(),
        updatedAt: DateTime.now().toUtc(),
      ),
    );
    setState(() {
      _profile = profile;
      _nameController.text = profile.fullName;
    });
  }

  Future<void> _sendMessage() async {
    final user = SupabaseService.instance.currentUser;
    if (user == null) return;
    if (_messageController.text.trim().isEmpty) return;

    setState(() => _isSendingMessage = true);
    try {
      await ChatService.instance.sendMessage(
        content: _messageController.text.trim(),
        userId: user.id,
        username: _profile?.fullName.isNotEmpty == true
            ? _profile!.fullName
            : user.email ?? 'Guest',
      );
      _messageController.clear();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Unable to send message: $error')));
    } finally {
      setState(() => _isSendingMessage = false);
    }
  }

  Future<void> _updateDisplayName() async {
    final user = SupabaseService.instance.currentUser;
    if (user == null) return;
    setState(() => _isSavingName = true);
    try {
      await ProfileService.instance.updateProfile(
        user.id,
        _nameController.text.trim(),
      );
      await _initializeProfile();
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile updated')));
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $error')),
      );
    } finally {
      setState(() => _isSavingName = false);
    }
  }

  Future<void> _signOut() async {
    await SupabaseService.instance.signOut();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = SupabaseService.instance.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Supabase Chat'),
        actions: [
          IconButton(onPressed: _signOut, icon: const Icon(Icons.logout)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Logged in as: ${user.email ?? 'Unknown'}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Display name',
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _isSavingName ? null : _updateDisplayName,
                      child: _isSavingName
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Save Profile'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: StreamBuilder<List<ChatMessage>>(
                stream: ChatService.instance.subscribeMessages(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Realtime error: ${snapshot.error}'),
                    );
                  }
                  final messages = snapshot.data ?? [];
                  if (messages.isEmpty) {
                    return const Center(
                      child: Text('No messages yet. Start the conversation!'),
                    );
                  }

                  return ListView.separated(
                    itemCount: messages.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe = message.userId == user.id;
                      return ListTile(
                        title: Text(message.username),
                        subtitle: Text(message.content),
                        trailing: Text(
                          message.createdAt
                              .toLocal()
                              .toString()
                              .split('.')
                              .first,
                          style: const TextStyle(fontSize: 12),
                        ),
                        tileColor: isMe
                            ? Colors.blue.shade50
                            : Colors.grey.shade100,
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _isSendingMessage ? null : _sendMessage,
                  child: _isSendingMessage
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Send'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
