import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'profile_controller.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // Fetch the profile once
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileControllerProvider.notifier).loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileControllerProvider);
    final controller = ref.read(profileControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
          ? Center(child: Text(state.error!))
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  _ProfileHeader(
                    name: state.name ?? '',
                    email: state.email ?? '',
                    avatarUrl: state.avatarUrl,
                  ),
                  const SizedBox(height: 32),
                  _SettingsTile(
                    icon: Icons.edit,
                    title: 'Edit Profile',
                    onTap: () => context.go('/edit-profile'),
                  ),
                  _SettingsTile(
                    icon: Icons.lock,
                    title: 'Change Password',
                    onTap: () => context.go('/change-password'),
                  ),
                  _SettingsTile(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    trailing: Switch(value: true, onChanged: (_) {}),
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    onTap: () => context.go('/help'),
                  ),
                  _SettingsTile(
                    icon: Icons.logout,
                    title: 'Log Out',
                    onTap: () async {
                      await controller.signOut();
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

class _ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String? avatarUrl;

  const _ProfileHeader({
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: avatarUrl != null
              ? NetworkImage(avatarUrl!)
              : const AssetImage('assets/images/logo.png') as ImageProvider,
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(email, style: const TextStyle(fontSize: 16, color: Colors.grey)),
      ],
    );
  }
}
