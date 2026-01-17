import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
Privacy Policy

Your privacy is important to us. This app collects the following information:

- Name and email when you sign up
- Profile pictures
- Problem reports submitted through the app
- Optional usage data for improving the app

We use this information only to provide and improve the services, and we will never sell your data.

By using this app, you consent to this privacy policy.
            ''', style: const TextStyle(fontSize: 14, height: 1.5)),
        ),
      ),
    );
  }
}
