import 'package:flutter/material.dart';

class CustomTransitionScreen extends StatelessWidget {
  static const String routeName = '/custom';

  const CustomTransitionScreen({super.key});

  Route<void> _createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(curved),
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.92, end: 1.0).animate(curved),
              child: child,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Transitions'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Custom page transitions using PageRouteBuilder',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(_createRoute(const _TransitionTargetPage(
                    key: ValueKey('transition-target'))));
              },
              child: const Text('Open custom transition page'),
            ),
            const SizedBox(height: 18),
            const Text(
              'The new page appears with a combined fade, slide and scale animation. This is useful for full-screen transitions and custom navigation effects.',
            ),
          ],
        ),
      ),
    );
  }
}

class _TransitionTargetPage extends StatelessWidget {
  const _TransitionTargetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transition Target'), centerTitle: true),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade400,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Text(
            'Custom route transitions are easy to build with PageRouteBuilder.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
