import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:northpoint_church_app/features/global_widgets/nav_bar.dart';
import 'package:northpoint_church_app/features/settings/widgets/theme_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/settings_tile.dart';
import 'widgets/report_problem.dart';
import '../global_widgets/app_bar.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: GradientAppBar(toolbarHeight: 35),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader('Preferences'),
            // SettingsTile(
            //   icon: Icons.notifications,
            //   title: 'Notifications',
            //   trailing: Switch(value: true, onChanged: (_) {}),
            //   onTap: () {},
            // ),
            const ThemeTile(),
            //const Divider(),
            //_SectionHeader('Help'),
            //const _FaqSection(),
            //const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ReportProblemSection(),
            ),
            //const Divider(),
            SizedBox(height: 20),
            _SectionHeader('Quick Links'),
            _QuickLinksSection(),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(currentIndex: 1),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class _FaqSection extends StatelessWidget {
  const _FaqSection();

  static const _faqs = [
    (
      question: 'How do I reset my password?',
      answer: 'Go to Profile > Change Password and follow the instructions.',
    ),
    (
      question: 'How do I update my profile picture?',
      answer: 'Go to Profile > Edit Profile, then select a new avatar.',
    ),
    (
      question: 'How do I manage notifications?',
      answer:
          'Go to Profile > Notifications and toggle what you want to receive.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _faqs
          .map(
            (faq) => ExpansionTile(
              title: Text(faq.question),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(faq.answer),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

class _QuickLinksSection extends StatelessWidget {
  Future<void> _launchChurchSite() async {
    final url = Uri.parse('https://www.northpointmuncie.com/');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Terms & Conditions'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/terms'),
        ),
        ListTile(
          title: const Text('Privacy Policy'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/privacy'),
        ),
        ListTile(
          title: const Text('Find us on the web'),
          trailing: const Icon(Icons.open_in_new),
          onTap: _launchChurchSite,
        ),
      ],
    );
  }
}
