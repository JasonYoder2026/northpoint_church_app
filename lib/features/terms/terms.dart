import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text('''
Terms & Conditions

By using this app, you agree to the following terms:

1. You are responsible for your account and actions.
2. Do not submit abusive, harmful, or illegal content.
3. We may suspend or terminate your account for misuse.
4. We are not liable for any data loss or damages.

These terms may be updated from time to time. Continued use of the app constitutes acceptance of the updated terms.
            ''', style: const TextStyle(fontSize: 14, height: 1.5)),
        ),
      ),
    );
  }
}
