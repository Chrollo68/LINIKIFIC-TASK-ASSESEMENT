import 'package:flutter/material.dart';

import '../widgets/common_widgets.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  bool darkMode = false;
  bool activityStatus = true;
  bool useBiometrics = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings Page')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            const SectionHeader(
              title: 'Profile',
              subtitle: 'Manage your account and preferences.',
            ),
            Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: const Text('Lina Design'),
                subtitle: const Text('lina.design@example.com'),
                trailing: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Preferences',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            SwitchListTile(
              title: const Text('Notifications'),
              subtitle: const Text('Receive updates and offers'),
              value: notificationsEnabled,
              onChanged: (value) =>
                  setState(() => notificationsEnabled = value),
              secondary: const Icon(Icons.notifications),
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Dark Mode'),
              subtitle: const Text('Use dark theme throughout the app'),
              value: darkMode,
              onChanged: (value) => setState(() => darkMode = value),
              secondary: const Icon(Icons.dark_mode),
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Activity Status'),
              subtitle: const Text('Show when you are online'),
              value: activityStatus,
              onChanged: (value) => setState(() => activityStatus = value),
              secondary: const Icon(Icons.visibility),
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Biometric Login'),
              subtitle: const Text('Use fingerprint or face ID'),
              value: useBiometrics,
              onChanged: (value) => setState(() => useBiometrics = value),
              secondary: const Icon(Icons.fingerprint),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Account Settings',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            const ListTile(
              leading: Icon(Icons.lock_outline),
              title: Text('Privacy'),
              subtitle: Text('Profile visibility and blocked contacts'),
              trailing: Icon(Icons.chevron_right),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              subtitle: Text('English'),
              trailing: Icon(Icons.chevron_right),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.help_outline),
              title: Text('Help & Support'),
              subtitle: Text('FAQ and contact support'),
              trailing: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}
