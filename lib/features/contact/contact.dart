import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../global_widgets/app_bar.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  // ----------------------------
  // Launch Helpers
  // ----------------------------

  Future<void> _launchPhone() async {
    final Uri uri = Uri(scheme: 'tel', path: '7657173183');
    await launchUrl(uri);
  }

  Future<void> _launchEmail() async {
    final Uri uri = Uri(scheme: 'mailto', path: 'info@northpointmuncie.com');
    await launchUrl(uri);
  }

  Future<void> _launchMaps() async {
    final Uri uri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=NorthPoint+Church+Muncie",
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _launchExternal(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static const String facebookUrl = "https://facebook.com/NorthPointChurch";
  static const String instagramUrl =
      "https://instagram.com/northpointchurchmuncie/";
  static const String youtubeUrl =
      "https://youtube.com/@NorthPointChurchMuncie";

  Widget _socialButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: Ink(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color.fromARGB(255, 174, 174, 174),
        ),
        child: Icon(icon, size: 28, color: Colors.black87),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.displayMedium?.color;

    return GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
            Navigator.of(context).pop(); // swipe right → pop
          }
        },
        child: Scaffold(
      appBar: GradientAppBar(
        toolbarHeight: 40,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------------------
            // Header
            // ----------------------------
            Center(
              child: Text(
                "Contact Us",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ----------------------------
            // Contact Card
            // ----------------------------
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text("(765) 717-3183"),
                    subtitle: const Text("Tap to call"),
                    onTap: _launchPhone,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text("info@northpointmuncie.com"),
                    subtitle: const Text("Tap to email"),
                    onTap: _launchEmail,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: const Text("NorthPoint Church"),
                    subtitle: const Text("Muncie, IN\nTap for directions"),
                    onTap: _launchMaps,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ----------------------------
            // Service Times Section
            // ----------------------------
            Text(
              "Service Times",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: const ListTile(
                leading: Icon(Icons.access_time),
                title: Text("Sunday Worship"),
                subtitle: Text("10:45 AM"),
              ),
            ),

            const SizedBox(height: 32),

            // ----------------------------
            // Footer Message
            // ----------------------------
            Center(
              child: Text(
                "We'd love to hear from you!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: textColor,
                ),
              ),
            ),
            const SizedBox(height: 32),

            Center(
              child: Text(
                "Follow Us",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialButton(
                  icon: Icons.facebook,
                  onTap: () => _launchExternal(facebookUrl),
                ),
                const SizedBox(width: 24),
                _socialButton(
                  icon: Icons.camera_alt, // Instagram
                  onTap: () => _launchExternal(instagramUrl),
                ),
                const SizedBox(width: 24),
                _socialButton(
                  icon: Icons.play_circle_fill, // YouTube
                  onTap: () => _launchExternal(youtubeUrl),
                ),
              ],
            ),
          ],
        ),
      ),
        )
    );
  }
}
