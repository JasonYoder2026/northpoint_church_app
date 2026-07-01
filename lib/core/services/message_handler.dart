import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageHandler {
  final GoRouter router;

  MessageHandler(this.router);

  Future<void> handle(Map<String, dynamic> data) async {
    final type = data['type'] as String?;
    final value = data['value'] as String?;

    if (type == null || value == null) return;

    switch (type) {
      case 'url':
        final uri = Uri.parse(value);

        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
        break;

      case 'event':
        router.go('events');
        break;

      default:
        router.go('home');
        break;
    }
  }
}
