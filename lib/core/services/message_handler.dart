import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';
import 'package:northpoint_church_app/features/events/event_model.dart';

class MessageHandler {
  final GoRouter router;
  final SupabaseProvider supabase;

  MessageHandler(this.router, this.supabase);

  Future<void> handle(Map<String, dynamic> data) async {
    final type = data['type'] as String?;
    final value = data['value'] as String?;

    if (type == null ||
        ((type == 'url' || type == 'youtube') && value == null)) {
      return;
    }

    switch (type) {
      case 'url':
      case 'youtube':
        final uri = Uri.parse(value!);

        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
        break;

      case 'event':
        final Event? event = await supabase.fetchEventById(value!);
        if (event != null) {
          router.go('/event-details', extra: event);
          break;
        }
        router.go('/events');

      default:
        router.go('/home');
        break;
    }
  }
}
