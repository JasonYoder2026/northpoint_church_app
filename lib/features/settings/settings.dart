import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:northpoint_church_app/features/global_widgets/nav_bar.dart';
import 'package:northpoint_church_app/features/settings/widgets/theme_tile.dart';
import 'widgets/settings_tile.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
          ],
        ),
      ),
      bottomNavigationBar: NavBar(currentIndex: 1),
    );
  }
}
