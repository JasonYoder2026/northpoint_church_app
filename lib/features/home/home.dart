import 'package:flutter/material.dart';
import 'widgets/grid_button.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<GridButtonData> _gridButtons = [
    GridButtonData(icon: Icons.event, text: 'Events', route: '/events'),
    GridButtonData(
      icon: Icons.volunteer_activism,
      text: 'Volunteer',
      route: '/volunteer',
    ),
    GridButtonData(icon: Icons.video_library, text: 'Watch', route: '/watch'),
    GridButtonData(icon: Icons.payment, text: 'Give', route: '', onTap: _openGiving),
    GridButtonData(
      icon: Icons.message_rounded,
      text: 'Prayer',
      route: '/prayer',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 25),
          Image.asset('assets/images/logo.png', width: 175, height: 175),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'We\'re so glad you\'re here!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                itemCount: _gridButtons.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return GridButton(btnData: _gridButtons[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _openGiving() async {
  final Uri url =
  Uri.parse('https://app.easytithe.com/app/giving/northpointchurch');

  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch giving page');
  }
}