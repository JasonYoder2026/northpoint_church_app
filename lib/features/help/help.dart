import 'package:flutter/material.dart';
import 'widgets/report_problem.dart';
import 'package:go_router/go_router.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => context.go("/profile"),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.headlineLarge?.color,
              ),
            ),
            const SizedBox(height: 8),
            ExpansionTile(
              title: const Text('How do I reset my password?'),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Go to Profile > Change Password and follow the instructions.',
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('How do I update my profile picture?'),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Go to Profile > Edit Profile, then select a new avatar.',
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('How do I manage notifications?'),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Go to Profile > Notifications and toggle what you want to receive.',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ReportProblemSection(),
            const SizedBox(height: 24),
            Text(
              'Quick Links',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.headlineLarge?.color,
              ),
            ),
            TextButton(
              onPressed: () {
                context.push("/terms");
              },
              child: const Text('Terms & Conditions'),
            ),
            TextButton(
              onPressed: () {
                context.push("/privacy");
              },
              child: const Text('Privacy Policy'),
            ),
            TextButton(onPressed: () {}, child: const Text('Church Website')),
          ],
        ),
      ),
    );
  }
}
