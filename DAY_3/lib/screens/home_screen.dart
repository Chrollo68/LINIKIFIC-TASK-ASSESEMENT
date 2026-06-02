import 'package:flutter/material.dart';
import 'package:day_3/models/user_profile.dart';
import 'package:day_3/screens/item_list_screen.dart';
import 'package:day_3/screens/profile_card_screen.dart';
import 'package:day_3/screens/simple_form_screen.dart';
import 'package:day_3/widgets/screen_description.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    const introText =
        'This beginner Flutter demo app shows four screens, navigation, state management, and common widgets.';

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Fundamentals Home')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ScreenDescription(
            title: 'Welcome to Flutter Fundamentals',
            description: introText,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Icon(
                        Icons.flutter_dash,
                        size: 64,
                        color: Colors.indigo.shade700,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Use this app to learn:',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• StatelessWidget and StatefulWidget\n• Navigation with Navigator.push/pop\n• ListView.builder and Card widgets',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ElevatedButton(
                  onPressed: () => _navigateTo(
                    context,
                    const ProfileCardScreen(
                      profile: UserProfile(
                        name: 'Alex Johnson',
                        email: 'alex.johnson@example.com',
                        jobTitle: 'Mobile Developer',
                        avatarInitials: 'AJ',
                      ),
                    ),
                  ),
                  child: const Text('Go to Profile Card Screen'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () =>
                      _navigateTo(context, const SimpleFormScreen()),
                  child: const Text('Go to Simple Form Screen'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => _navigateTo(context, const ItemListScreen()),
                  child: const Text('Go to Item List Screen'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Home Screen Explanation',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                const Text(
                  'The Home Screen uses MaterialApp, Scaffold, AppBar, Column, Row, Stack, Padding, and navigation buttons. It is the entry point for navigating to the other fundamental screens.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
