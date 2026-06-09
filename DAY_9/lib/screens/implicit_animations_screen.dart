import 'package:flutter/material.dart';

class ImplicitAnimationsScreen extends StatefulWidget {
  static const String routeName = '/implicit';

  const ImplicitAnimationsScreen({super.key});

  @override
  State<ImplicitAnimationsScreen> createState() =>
      _ImplicitAnimationsScreenState();
}

class _ImplicitAnimationsScreenState extends State<ImplicitAnimationsScreen> {
  bool _large = false;
  bool _isVisible = true;
  bool _showFirst = true;
  bool _moveRight = false;

  void _toggleAnimations() {
    setState(() {
      _large = !_large;
      _isVisible = !_isVisible;
      _showFirst = !_showFirst;
      _moveRight = !_moveRight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Implicit Animations'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Implicit animation examples',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 18),
            AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              width: _large ? 280 : 180,
              height: _large ? 180 : 120,
              decoration: BoxDecoration(
                color: _large ? Colors.deepPurple : Colors.indigo,
                borderRadius: BorderRadius.circular(_large ? 32 : 16),
              ),
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'AnimatedContainer',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 600),
              opacity: _isVisible ? 1 : 0.2,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'AnimatedOpacity changes the transparency of this card.',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeInOut,
                    left: _moveRight ? 140 : 10,
                    top: 20,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          'AnimatedPositioned',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AnimatedCrossFade(
              firstChild: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.lightGreen.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text('First child of AnimatedCrossFade.'),
              ),
              secondChild: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.pink.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text('Second child of AnimatedCrossFade.'),
              ),
              crossFadeState: _showFirst
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 650),
              firstCurve: Curves.easeIn,
              secondCurve: Curves.easeOut,
            ),
            const SizedBox(height: 20),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 1.0, end: _large ? 1.4 : 1.0),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade100,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: child,
                  ),
                );
              },
              child: const Text(
                'TweenAnimationBuilder animates this widget smoothly.',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: _toggleAnimations,
              child: const Text('Toggle Implicit Animations'),
            ),
          ],
        ),
      ),
    );
  }
}
