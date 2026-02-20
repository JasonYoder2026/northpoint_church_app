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
    GridButtonData(icon: Icons.event, text: 'Events', route: '/events'),
    GridButtonData(
      icon: Icons.volunteer_activism,
      text: 'Volunteer',
      route: '/volunteer',
    ),
    GridButtonData(icon: Icons.video_library, text: 'Watch', route: '/watch'),
    GridButtonData(icon: Icons.payment, text: 'Give', route: '/tithe'),
    GridButtonData(
      icon: Icons.message_rounded,
      text: 'Prayer',
      route: '/prayer',
    ),
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
                  /// 🔥 HERO BUTTON
                  Center(child: GridButton(btnData: _gridButtons[0])),

                  const SizedBox(height: 25),

                  /// Middle Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GridButton(btnData: _gridButtons[1]),
                      GridButton(btnData: _gridButtons[2]),
                    ],
                  ),

                  const SizedBox(height: 25),

                  /// Bottom Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GridButton(btnData: _gridButtons[3]),
                      GridButton(btnData: _gridButtons[4]),
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
