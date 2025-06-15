import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hui_application/features/auth/models/auth_state.dart';
import 'package:hui_application/features/auth/providers/auth_provider.dart';
import 'package:hui_application/models/users.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  Widget _buildProfileCard(BuildContext context, User user) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFFDFDFDF), width: 1),
      ),
      color: Colors.white, // White background for the card
      elevation: 0, // No box shadow
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.fullName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(user.email ?? 'No email provided'),
                        Text(user.phone ?? 'No phone number provided'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(List<Widget> tiles) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFFDFDFDF), width: 1),
      ),
      color: Colors.white,
      elevation: 0,
      child: Column(children: tiles),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authNotifierProvider).user;
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Account'), centerTitle: true),
        body: Center(child: const CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Account'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildProfileCard(context, user),
          const SizedBox(height: 16),
          _buildSection([
            _AccountTile(
              icon: Icons.person,
              title: 'Profile',
              onTap: () {
                context.push('/account/profile');
              },
            ),
            _AccountTile(
              icon: Icons.security,
              title: 'Security',
              onTap: () {
                context.push('/account/security');
              },
            ),
            _AccountTile(
              icon: Icons.notifications,
              title: 'Notifications',
              onTap: () {
                context.push('/account/notifications');
              },
            ),
            _AccountTile(
              icon: Icons.payment,
              title: 'Payment Methods',
              onTap: () {
                context.push('/account/payment');
              },
            ),
            _AccountTile(
              icon: Icons.history,
              title: 'Transaction History',
              onTap: () {
                context.push('/account/transactions');
              },
            ),
            _AccountTile(
              icon: Icons.help,
              title: 'Help & Support',
              onTap: () {
                context.push('/account/help');
              },
            ),
            _AccountTile(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {
                context.push('/account/settings');
              },
            ),
            _AccountTile(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {
                ref.read(authNotifierProvider.notifier).logout();
                context.go('/login');
              },
            ),
          ]),
        ],
      ),
    );
  }
}

class _AccountTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _AccountTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => ListTile(
    minTileHeight: 56,
    leading: Icon(icon, size: 20),
    title: Text(title, style: const TextStyle(fontSize: 16, height: 20 / 16)),
    onTap: onTap,
    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
  );
}
