import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:northpoint_church_app/features/profile/widgets/theme_tile.dart';
import 'profile_controller.dart';
import 'widgets/profile_header.dart';
import 'widgets/settings_tile.dart';

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
      appBar: AppBar(),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
          ? Center(child: Text(state.error!))
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  ProfileHeader(
                    name: state.name ?? '',
                    email: state.email ?? '',
                    avatarUrl: state.avatarUrl,
                  ),
                  const SizedBox(height: 32),
                  SettingsTile(
                    icon: Icons.edit,
                    title: 'Edit Profile',
                    onTap: () => context.go('/edit-profile'),
                  ),
                  SettingsTile(
                    icon: Icons.lock,
                    title: 'Change Password',
                    onTap: () => context.go('/change-password'),
                  ),
                  SettingsTile(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    trailing: Switch(value: true, onChanged: (_) {}),
                    onTap: () {},
                  ),
                  const ThemeTile(),
                  SettingsTile(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    onTap: () => context.go('/help'),
                  ),
                  SettingsTile(
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
