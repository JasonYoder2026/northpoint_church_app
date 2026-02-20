class Event {
  final String id;
  final String title;
  final String? summary;
  final String? imageUrl;
  final String? registrationUrl;

  final DateTime? startAt;
  final DateTime? endAt;
  final bool allDay;
  final String? location;

  Event({
    required this.id,
    required this.title,
    this.summary,
    this.imageUrl,
    this.registrationUrl,
    this.startAt,
    this.endAt,
    required this.allDay,
    this.location,
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'].toString(),
      title: (map['title'] ?? '').replaceAll(RegExp(r'\s*\(.*?\)'), ''),
      summary: map['summary'],
      imageUrl: map['image_url'],
      registrationUrl: map['registration_url'],
      startAt: map['starts_at'] != null
          ? DateTime.parse(map['starts_at'])
          : null,
      endAt: map['ends_at'] != null ? DateTime.parse(map['ends_at']) : null,
      allDay: map['all_day'] == true,
      location: map['location'],
    );
  }
}
