import 'package:flutter/material.dart';
import 'package:northpoint_church_app/features/global_widgets/nav_bar.dart';
import 'widgets/grid_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<GridButtonData> _gridButtons = [
    GridButtonData(icon: Icons.payment, text: 'Tithe', route: '/tithe'),
    GridButtonData(icon: Icons.video_library, text: 'Watch', route: '/watch'),
    GridButtonData(icon: Icons.event, text: 'Events', route: '/events'),
    GridButtonData(
      icon: Icons.message_rounded,
      text: 'Prayer',
      route: '/prayer',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 32),
          Image.asset('assets/images/logo.png', width: 180, height: 180),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'We\'re so glad you\'re here!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          // GridView inside Expanded to fill remaining space
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 45,
                crossAxisSpacing: 45,
                children: _gridButtons
                    .map((btn) => GridButton(btnData: btn))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavBar(currentIndex: 0),
    );
  }
}
