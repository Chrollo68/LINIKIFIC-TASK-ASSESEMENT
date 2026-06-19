import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class ProfileScreen extends StatelessWidget {
  final UserModel userModel;

  const ProfileScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade300, Colors.purple.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // User Avatar
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        backgroundImage: user?.photoURL != null
                            ? NetworkImage(user!.photoURL!)
                            : null,
                        child: user?.photoURL == null
                            ? Text(
                                (user?.displayName ?? user?.email ?? 'U')[0]
                                    .toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ),
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Name
                  Text(
                    user?.displayName ?? 'User',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // Email
                  Text(
                    user?.email ?? 'No email',
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  // Status
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Active',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Account Details Section
            _buildSection(
              title: 'Account Details',
              children: [
                _buildDetailTile('UID', userModel.uid),
                _buildDetailTile('Email', userModel.email ?? 'Not provided'),
                _buildDetailTile(
                  'Display Name',
                  userModel.displayName ?? 'Not provided',
                ),
                _buildDetailTile(
                  'Photo URL',
                  userModel.photoUrl ?? 'Not provided',
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Account Status Section
            _buildSection(
              title: 'Account Status',
              children: [
                _buildDetailTile(
                  'Email Verified',
                  user?.emailVerified ?? false ? 'Yes ✓' : 'No',
                  valueColor: user?.emailVerified ?? false
                      ? Colors.green
                      : Colors.orange,
                ),
                _buildDetailTile(
                  'Account Created',
                  _formatDate(userModel.createdAt),
                ),
                _buildDetailTile(
                  'Last Sign In',
                  _formatDate(user?.metadata.lastSignInTime),
                ),
                _buildDetailTile('Authentication Method', _getAuthMethod(user)),
              ],
            ),
            const SizedBox(height: 20),
            // Security Section
            _buildSection(
              title: 'Security',
              children: [
                _buildDetailTile(
                  'Provider',
                  user?.providerData.isNotEmpty == true
                      ? user!.providerData.first.providerId
                      : 'Email/Password',
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Edit Profile Button (for future implementation)
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Edit profile feature coming soon'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildDetailTile(String label, String value, {Color? valueColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(fontWeight: FontWeight.w500, color: valueColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? dateTime) {
    if (dateTime == null) return 'Not available';
    try {
      return DateFormat('MMM dd, yyyy - HH:mm').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }

  String _getAuthMethod(firebase_auth.User? user) {
    if (user == null) return 'Unknown';
    if (user.providerData.isEmpty) return 'Email/Password';

    final providers = user.providerData.map((p) => p.providerId).join(', ');
    return providers.isNotEmpty ? providers : 'Email/Password';
  }
}
