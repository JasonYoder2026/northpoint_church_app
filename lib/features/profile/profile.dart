import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final supabaseService = GetIt.instance<SupabaseProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            // Profile header
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                'assets/images/logo.png',
              ), // replace with user image
            ),
            const SizedBox(height: 16),
            Text(
              'John Doe', // replace with dynamic user name
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'johndoe@email.com', // replace with dynamic email
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),

            // Settings / options list
            _SettingsTile(
              icon: Icons.edit,
              title: 'Edit Profile',
              onTap: () {
                context.go('/edit-profile'); // replace with your route
              },
            ),
            _SettingsTile(
              icon: Icons.lock,
              title: 'Change Password',
              onTap: () {
                context.go('/change-password');
              },
            ),
            _SettingsTile(
              icon: Icons.notifications,
              title: 'Notifications',
              trailing: Switch(
                value: true, // replace with actual value
                onChanged: (val) {},
              ),
              onTap: () {},
            ),
            _SettingsTile(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {
                context.go('/help');
              },
            ),
            _SettingsTile(
              icon: Icons.logout,
              title: 'Log Out',
              onTap: () {
                supabaseService.signOut();
                context.go('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Reusable settings tile
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
