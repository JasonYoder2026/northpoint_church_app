class Event {
  final String id;
  final String title;
  final String? imageUrl;
  final DateTime? startAt;
  final DateTime? endAt;
  final bool? allDay;

  Event({
    required this.id,
    required this.title,
    this.imageUrl,
    this.startAt,
    this.endAt,
    this.allDay,
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'].toString(),
      title: map['title'] ?? '',
      imageUrl: map['image_url'],  // matches your DB
      startAt: map['starts_at'] != null ? DateTime.parse(map['starts_at']) : null,
      endAt: map['ends_at'] != null ? DateTime.parse(map['ends_at']) : null,
      allDay: map['all_day'] == true
    );
  }
}
