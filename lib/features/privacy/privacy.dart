import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../global_widgets/app_bar.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        toolbarHeight: 40,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
Your privacy is important to us.

1. Information Collected
   This app does not require user accounts and does not collect or store personal information such as names, email addresses, or profile data.

   If you choose to submit forms (such as event signups or prayer requests), those submissions are handled directly through external services (e.g., Planning Center). Any information entered there is governed by their privacy policies.

2. App Usage Data
   The app may store limited technical information necessary for functionality, such as device push notification tokens. This information is not used to identify you personally.

3. Data Sharing
   We do not sell, rent, or trade personal information. Because we do not collect personal data within the app, there is no personal data to share.

4. Security
   We take reasonable measures to protect the integrity of the app and its data.

5. Consent
   By using this app, you agree to this privacy policy.

If you have questions about privacy, please contact the church directly.
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
