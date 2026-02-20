import 'package:flutter/material.dart';
import 'package:northpoint_church_app/features/global_widgets/nav_bar.dart';
import 'package:northpoint_church_app/features/global_widgets/app_bar.dart';
import 'widgets/grid_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<GridButtonData> _gridButtons = [
    GridButtonData(icon: Icons.payment, text: 'Tithe', route: '/tithe'),

    GridButtonData(
      icon: Icons.message_rounded,
      text: 'Prayer',
      route: '/prayer',
    ),
    GridButtonData(
      icon: Icons.volunteer_activism,
      text: 'Volunteer',
      route: '/volunteer',
    ),
    GridButtonData(icon: Icons.video_library, text: 'Watch', route: '/watch'),
    GridButtonData(icon: Icons.event, text: 'Events', route: '/events'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(toolbarHeight: 35),
      body: Column(
        children: [
          SizedBox(height: 50),
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
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Top Row (3 buttons)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: GridButton(btnData: _gridButtons[0])),
                      const SizedBox(width: 16),
                      Expanded(child: GridButton(btnData: _gridButtons[1])),
                      const SizedBox(width: 16),
                      Expanded(child: GridButton(btnData: _gridButtons[2])),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// Bottom Row (2 centered buttons)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GridButton(btnData: _gridButtons[3]),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: GridButton(btnData: _gridButtons[4]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavBar(currentIndex: 0),
    );
  }
}
