import 'package:flutter/material.dart';

import '../widgets/common_widgets.dart';

class InstagramPostScreen extends StatelessWidget {
  static const routeName = '/instagram';

  const InstagramPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Instagram Post Card')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 720;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SectionHeader(
                    title: 'Responsive Instagram Post',
                    subtitle:
                        'Mastering Row, Column and Expanded layout patterns.',
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: isWide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 2, child: _PostImage()),
                              Expanded(flex: 3, child: _PostDetails()),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const [
                              _PostHeader(),
                              _PostImage(),
                              _PostActions(),
                              _PostCaption(),
                            ],
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  const _PostHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
              radius: 28,
              backgroundColor: Colors.pink.shade100,
              child: const Icon(Icons.person, size: 28)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('lina.design',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text('San Francisco · 2h ago',
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }
}

class _PostImage extends StatelessWidget {
  const _PostImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Center(
        child: Icon(Icons.image, size: 80, color: Colors.white70),
      ),
    );
  }
}

class _PostActions extends StatelessWidget {
  const _PostActions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(Icons.favorite_border),
          Icon(Icons.comment_outlined),
          Icon(Icons.send_outlined),
          Spacer(),
          Icon(Icons.bookmark_border),
        ],
      ),
    );
  }
}

class _PostCaption extends StatelessWidget {
  const _PostCaption();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'lina.design',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Exploring contrast, texture, and motion with this modern layout experiment. Which style would you try first?',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _PostDetails extends StatelessWidget {
  const _PostDetails();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _PostHeader(),
        _PostImage(),
        _PostActions(),
        _PostCaption(),
      ],
    );
  }
}
