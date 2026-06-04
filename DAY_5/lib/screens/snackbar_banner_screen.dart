import 'package:flutter/material.dart';

class SnackBarBannerScreen extends StatefulWidget {
  const SnackBarBannerScreen({super.key});

  @override
  State<SnackBarBannerScreen> createState() => _SnackBarBannerScreenState();
}

class _SnackBarBannerScreenState extends State<SnackBarBannerScreen> {
  bool _bannerVisible = false;

  void _showBasicSnackBar() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('This is a basic SnackBar.')));
  }

  void _showActionSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('This SnackBar includes an action.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Undo completed')));
          },
        ),
      ),
    );
  }

  void _showCustomSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        content: const Text('Custom SnackBar styled with Material 3 colors.'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _toggleMaterialBanner() {
    setState(() {
      _bannerVisible = !_bannerVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SnackBar & Banner')),
      body: Column(
        children: [
          if (_bannerVisible)
            MaterialBanner(
              content: const Text('This is a MaterialBanner with an action.'),
              leading: const Icon(Icons.info_outline),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _bannerVisible = false;
                    });
                  },
                  child: const Text('DISMISS'),
                ),
              ],
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  ElevatedButton(
                    onPressed: _showBasicSnackBar,
                    child: const Text('Show Basic SnackBar'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _showActionSnackBar,
                    child: const Text('Show SnackBar with Action'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _showCustomSnackBar,
                    child: const Text('Show Custom SnackBar'),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _toggleMaterialBanner,
                    child: Text(
                      _bannerVisible
                          ? 'Hide Material Banner'
                          : 'Show Material Banner',
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'SnackBars display brief messages along the bottom of the screen, while Material Banners appear at the top and can also show actions.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
