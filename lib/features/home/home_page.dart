import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Northpoint Church')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome to Northpoint!', style: textTheme.headlineLarge),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // placeholder for navigation / future feature
              },
              child: const Text('View Events'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // placeholder for navigation / future feature
              },
              child: const Text('Live Stream'),
            ),
          ],
        ),
      ),
    );
  }
}
