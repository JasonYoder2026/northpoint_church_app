import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'event_model.dart';
import '../global_widgets/app_bar.dart';
import './events_controller.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final SupabaseProvider supabase = GetIt.instance<SupabaseProvider>();
  final EventController controller = EventController();

  List<Event> events = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      final fetched = await supabase.fetchEvents();
      setState(() {
        events = fetched;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching events: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        toolbarHeight: 40,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: 'Upcoming Events',
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return GestureDetector(
                  onTap: () => context.push("/event-details", extra: event),
                  child: EventCard(event: event, controller: controller),
                );
              },
            ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;
  final EventController controller;

  const EventCard({super.key, required this.event, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: 200, // taller card
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background image
            if (event.imageUrl != null)
              Positioned.fill(
                child: Image.network(event.imageUrl!, fit: BoxFit.cover),
              )
            else
              Container(color: Colors.grey[300]),

            // Bottom overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 80, // bottom half height
              child: Container(
                color: Colors.white.withOpacity(0.95),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      event.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.formatDateTime(event),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
