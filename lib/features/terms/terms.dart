import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../global_widgets/app_bar.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

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
            children: [
              Text(
                "Terms & Conditions",
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.displayMedium?.color,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '''
Welcome to the Northpoint Church App. By using this app, you agree to the following terms:

1. Use of the App
   - You may use the app for personal, non-commercial purposes related to church activities.
   - You agree not to misuse the app or interfere with its functionality.

2. Content
   - All content provided in the app is for informational purposes only.
   - You may not copy, distribute, or modify any content without permission.

3. Liability
   - The app is provided "as is" and the church is not responsible for any errors, interruptions, or data loss.

4. Updates
   - We may update these terms at any time. Continued use of the app constitutes acceptance of any changes.

Thank you for using the app responsibly.
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
