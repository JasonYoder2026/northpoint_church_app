import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'event_model.dart';
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
        debugPrint(events.toString());
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
      appBar: AppBar(title: const Text('Upcoming Events')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return EventCard(event: event, controller: controller);
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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: event.imageUrl != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(event.imageUrl!, width: 60, fit: BoxFit.cover),
        )
            : null,
        title: Text(event.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(controller.formatDateTime(event)),
        onTap: () {},
      ),
    );
  }
}
