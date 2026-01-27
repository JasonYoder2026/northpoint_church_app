import 'package:intl/intl.dart';
import 'event_model.dart';

class EventController {
  String formatDateTime(Event event) {
    final start = event.startAt;
    final end = event.endAt;

    final dateFormat = DateFormat('EEE, MMM d • h:mm a');
    final endTimeFormat = DateFormat('h:mm a');

    if (start.day == end.day) {
      return '${dateFormat.format(start)} - ${endTimeFormat.format(end)}';
    } else {
      return '${dateFormat.format(start)} - ${dateFormat.format(end)}';
    }
  }
}
