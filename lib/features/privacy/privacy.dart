import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
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
