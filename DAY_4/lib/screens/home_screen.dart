import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'ecommerce_grid_screen.dart';
import 'instagram_post_screen.dart';
import 'list_builder_screen.dart';
import 'responsive_gallery_screen.dart';
import 'settings_screen.dart';
import 'stack_demo_screen.dart';
import 'whatsapp_chat_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  const HomeScreen({super.key});

  static const List<_DemoTile> _demoTiles = [
    _DemoTile(
        title: 'Instagram Post Card',
        route: InstagramPostScreen.routeName,
        description: 'Card layout with avatar, image, and caption.'),
    _DemoTile(
        title: 'WhatsApp Chat UI',
        route: WhatsAppChatScreen.routeName,
        description: 'Chat bubbles with timestamps in a scrollable list.'),
    _DemoTile(
        title: 'E-Commerce Product Grid',
        route: EcommerceGridScreen.routeName,
        description: 'Responsive product cards in a grid.'),
    _DemoTile(
        title: 'Settings Page',
        route: SettingsScreen.routeName,
        description: 'ListTiles, toggles and profile summary.'),
    _DemoTile(
        title: 'Dashboard Screen',
        route: DashboardScreen.routeName,
        description: 'Statistics cards and recent activity.'),
    _DemoTile(
        title: 'ListView Builder',
        route: ListBuilderScreen.routeName,
        description: '150 items rendered efficiently.'),
    _DemoTile(
        title: 'Responsive GridView',
        route: ResponsiveGalleryScreen.routeName,
        description: 'Adaptive columns for mobile, tablet, desktop.'),
    _DemoTile(
        title: 'Stack UI Demo',
        route: StackDemoScreen.routeName,
        description: 'Layered layout using Stack and Positioned.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Layout Showcase')),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: _demoTiles.length,
          itemBuilder: (context, index) {
            final demo = _demoTiles[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Card(
                elevation: 2,
                child: ListTile(
                  title: Text(demo.title),
                  subtitle: Text(demo.description),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => Navigator.pushNamed(context, demo.route),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DemoTile {
  final String title;
  final String route;
  final String description;

  const _DemoTile(
      {required this.title, required this.route, required this.description});
}
