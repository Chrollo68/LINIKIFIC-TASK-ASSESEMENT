import 'package:flutter/material.dart';
import 'custom_transition_screen.dart';
import 'explicit_animations_screen.dart';
import 'hero_animations_screen.dart';
import 'implicit_animations_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Animations Lab'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Select an animation demo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          _DemoTile(
            label: 'Implicit Animations',
            description:
                'AnimatedContainer, AnimatedOpacity, AnimatedCrossFade',
            icon: Icons.flash_on,
            onTap: () {
              Navigator.pushNamed(context, ImplicitAnimationsScreen.routeName);
            },
          ),
          _DemoTile(
            label: 'Explicit Animations',
            description: 'AnimationController, Tween, AnimatedBuilder',
            icon: Icons.timeline,
            onTap: () {
              Navigator.pushNamed(context, ExplicitAnimationsScreen.routeName);
            },
          ),
          _DemoTile(
            label: 'Hero Animations',
            description: 'Shared element transitions with Hero widget',
            icon: Icons.airplane_ticket,
            onTap: () {
              Navigator.pushNamed(context, HeroAnimationsScreen.routeName);
            },
          ),
          _DemoTile(
            label: 'Custom Page Transitions',
            description: 'PageRouteBuilder with fade, slide, and scale',
            icon: Icons.swap_horiz,
            onTap: () {
              Navigator.pushNamed(context, CustomTransitionScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}

class _DemoTile extends StatelessWidget {
  final String label;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const _DemoTile({
    required this.label,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(description),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
