import 'package:flutter/material.dart';

class HeroAnimationsScreen extends StatelessWidget {
  static const String routeName = '/hero';

  const HeroAnimationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _HeroExample(tag: 'blueBox', label: 'Blue Hero', color: Colors.blue),
      _HeroExample(tag: 'greenBox', label: 'Green Hero', color: Colors.green),
      _HeroExample(tag: 'pinkBox', label: 'Pink Hero', color: Colors.pink),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Hero Animations'), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HeroDetailScreen(example: item),
                  ),
                );
              },
              leading: Hero(
                tag: item.tag,
                flightShuttleBuilder:
                    (
                      flightContext,
                      animation,
                      flightDirection,
                      fromContext,
                      toContext,
                    ) {
                      final Hero toHero = toContext.widget as Hero;
                      return ScaleTransition(
                        scale: animation,
                        child: toHero.child,
                      );
                    },
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: item.color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              title: Text(item.label),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}

class HeroDetailScreen extends StatelessWidget {
  final _HeroExample example;

  const HeroDetailScreen({required this.example, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(example.label), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: example.tag,
              flightShuttleBuilder:
                  (
                    flightContext,
                    animation,
                    flightDirection,
                    fromContext,
                    toContext,
                  ) {
                    final Hero toHero = toContext.widget as Hero;
                    return RotationTransition(
                      turns: animation,
                      child: toHero.child,
                    );
                  },
              child: Container(
                height: 240,
                decoration: BoxDecoration(
                  color: example.color,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Text(
                    'Hero Transition',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'This screen demonstrates Hero animations with matching tags and a custom flight shuttle. Tap back to see the shared element perform a more complex transition.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroExample {
  final String tag;
  final String label;
  final Color color;

  _HeroExample({required this.tag, required this.label, required this.color});
}
