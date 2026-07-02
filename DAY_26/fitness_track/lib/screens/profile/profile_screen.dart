import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/profile_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _pickImage(AuthProvider authProvider) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final updatedUser = authProvider.user!.copyWith(photoPath: image.path);
    await authProvider.updateProfile(updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final user = authProvider.user;
    if (user == null) {
      return const Center(child: Text('Please sign in'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () => themeProvider.toggleTheme(),
            icon: const Icon(Icons.brightness_6_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Center(
            child: Column(
              children: [
                Hero(
                  tag: 'profile-photo',
                  child: CircleAvatar(
                    radius: 54,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.16),
                    backgroundImage: user.photoPath != null
                        ? FileImage(File(user.photoPath!))
                        : null,
                    child: user.photoPath == null
                        ? Icon(
                            Icons.person,
                            size: 40,
                            color: Theme.of(context).colorScheme.primary,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 12),
                FilledButton.tonalIcon(
                  onPressed: () => _pickImage(authProvider),
                  icon: const Icon(Icons.image_outlined),
                  label: const Text('Edit Profile'),
                ),
                const SizedBox(height: 16),
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(user.email, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                ProfileTile(
                  title: 'Height',
                  value: '${user.height.toInt()} cm',
                  icon: Icons.height,
                ),
                ProfileTile(
                  title: 'Weight',
                  value: '${user.weight.toInt()} kg',
                  icon: Icons.monitor_weight_outlined,
                ),
                ProfileTile(
                  title: 'BMI',
                  value: user.bmi.toStringAsFixed(1),
                  icon: Icons.speed_outlined,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                const ProfileTile(
                  title: 'Notifications',
                  value: 'Enabled',
                  icon: Icons.notifications_active_outlined,
                ),
                const ProfileTile(
                  title: 'Privacy',
                  value: 'Private',
                  icon: Icons.lock_outline,
                ),
                const ProfileTile(
                  title: 'Units',
                  value: 'Metric',
                  icon: Icons.straighten_outlined,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            onPressed: () async {
              await authProvider.logout();
              if (!mounted) return;
              Navigator.pushReplacementNamed(context, '/auth');
            },
          ),
        ],
      ),
    );
  }
}
