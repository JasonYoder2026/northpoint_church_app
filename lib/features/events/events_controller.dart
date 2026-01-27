import 'package:intl/intl.dart';
import 'event_model.dart';

class EventController {
  String formatDateTime(Event event) {
    if (event.startAt == null || event.endAt == null) return '';

    if (event.allDay == true) {
      final date = event.startAt!.toLocal();
      final dateFormat = DateFormat('EEE, MMM d');
      return '${dateFormat.format(date)} • All day';
    }


    final start = event.startAt!.toLocal();
    final end = event.endAt!.toLocal();

    final dateFormat = DateFormat('EEE, MMM d • h:mm a');
    final endTimeFormat = DateFormat('h:mm a');

    if (start.day == end.day) {
      return '${dateFormat.format(start)} - ${endTimeFormat.format(end)}';
    } else {
      return '${dateFormat.format(start)} - ${dateFormat.format(end)}';
    }
  }
}
