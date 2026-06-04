import 'package:flutter/material.dart';

import '../widgets/common_widgets.dart';

class WhatsAppChatScreen extends StatelessWidget {
  static const routeName = '/whatsapp';

  const WhatsAppChatScreen({super.key});

  static final List<_MessageItem> _messages = [
    _MessageItem(
        text: 'Hey there! Are you free for a quick call?',
        time: '09:12',
        isSent: false),
    _MessageItem(
        text: 'Sure, I am on my way to a meeting, but I can chat now.',
        time: '09:14',
        isSent: true),
    _MessageItem(
        text: 'Perfect. I wanted to share the new layout concept with you.',
        time: '09:15',
        isSent: false),
    _MessageItem(
        text: 'Love the modern spacing. The cards look clean and responsive.',
        time: '09:17',
        isSent: true),
    _MessageItem(
        text: 'I will finalize the design system after the review.',
        time: '09:18',
        isSent: false),
    _MessageItem(
        text: 'Great, I will send a summary in the group chat.',
        time: '09:19',
        isSent: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WhatsApp Chat UI')),
      body: SafeArea(
        child: Column(
          children: [
            _ChatHeader(),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return ChatBubble(
                    message: message.text,
                    time: message.time,
                    isSent: message.isSent,
                  );
                },
              ),
            ),
            _ChatComposer(),
          ],
        ),
      ),
    );
  }
}

class _MessageItem {
  final String text;
  final String time;
  final bool isSent;

  const _MessageItem(
      {required this.text, required this.time, required this.isSent});
}

class _ChatHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          const CircleAvatar(radius: 24, child: Icon(Icons.person)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Lina Design',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text('Online',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.green)),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
    );
  }
}

class _ChatComposer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message',
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.emoji_emotions_outlined),
              ),
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 24,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
