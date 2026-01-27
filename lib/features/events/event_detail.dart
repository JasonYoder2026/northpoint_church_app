import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'event_model.dart';
import 'events_controller.dart';

class EventDetailPage extends StatelessWidget {
  final Event event;

  const EventDetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final controller = EventController();
    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (event.imageUrl != null) Image.network(event.imageUrl!),
              SizedBox(height: 12),
              Text(
                event.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.headlineLarge?.color,
                ),
              ),
              Text(
                controller.formatDateTime(event),
                style: TextStyle(
                  color: Theme.of(context).textTheme.headlineLarge?.color,
                ),
              ),
              if (event.registrationUrl != null) ...[
                SizedBox(height: 8),
                InkWell(
                  onTap: () => context.push(
                    '/event-registration',
                    extra: event.registrationUrl!,
                  ),
                  child: Text(
                    'Click To Register',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent, // indicate clickable
                    ),
                  ),
                ),
              ],
              if (event.location != null) ...[
                SizedBox(height: 8),
                Text(
                  "Location: ${event.location!}",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headlineLarge?.color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
              if (event.summary != null) ...[
                SizedBox(height: 8),
                Text(
                  event.summary!,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headlineLarge?.color,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
