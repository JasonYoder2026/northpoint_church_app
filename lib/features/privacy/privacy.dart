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
            color: Colors.white,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Privacy Policy",
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.displayMedium?.color,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '''
Your privacy is important to us. This app collects only the information necessary to provide and improve our services:

1. Information Collected
   - Name and email when you sign up
   - Profile pictures
   - Problem reports submitted through the app
   - Optional usage data for app improvement

2. How We Use Your Information
   - To provide and personalize your app experience
   - To respond to support requests
   - To improve app functionality

3. Data Sharing
   - We will never sell your personal data.
   - We may share information with service providers to help run the app (e.g., cloud storage).

4. Security
   - We take reasonable measures to protect your information.

5. Consent
   - By using this app, you consent to this privacy policy.

Thank you for trusting us with your information.
            ''',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Theme.of(context).textTheme.displayMedium?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
