import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GridButtonData {
  final IconData icon;
  final String text;
  final String route;

  GridButtonData({required this.icon, required this.text, required this.route});
}

class GridButton extends StatelessWidget {
  final GridButtonData btnData;
  const GridButton({super.key, required this.btnData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).go(btnData.route),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color:
              Theme.of(
                context,
              ).elevatedButtonTheme.style?.backgroundColor?.resolve({}) ??
              Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(btnData.icon, size: 48, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              btnData.text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
