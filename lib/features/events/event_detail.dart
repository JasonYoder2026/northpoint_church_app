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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                event.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: event.imageUrl != null
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(event.imageUrl!, fit: BoxFit.cover),

                        /// Dark overlay for readability
                        Container(color: Colors.black.withOpacity(0.4)),
                      ],
                    )
                  : Container(color: Colors.grey[300]),
            ),
          ),

          /// 🔥 CONTENT
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    controller.formatDateTime(event),
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),

                  if (event.registrationUrl != null) ...[
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () => context.push(
                        '/event-registration',
                        extra: event.registrationUrl!,
                      ),
                      child: const Text(
                        'Click To Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ],

                  if (event.location != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      "Location: ${event.location!}",
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],

                  if (event.summary != null) ...[
                    const SizedBox(height: 16),
                    Text(event.summary!, style: const TextStyle(height: 1.5)),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
