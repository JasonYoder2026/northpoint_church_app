import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;

  const NavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor:
          Theme.of(
            context,
          ).elevatedButtonTheme.style?.backgroundColor?.resolve({}) ??
          Colors.blue,
      onTap: (index) {
        switch (index) {
          case 0:
            router.go('/home');
            break;
          case 1:
            router.go('/settings');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
