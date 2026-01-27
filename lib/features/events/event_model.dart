class Event {
  final String title;
  final String? imageUrl;
  final DateTime startAt;
  final DateTime endAt;

  Event({
    required this.title,
    this.imageUrl,
    required this.startAt,
    required this.endAt,
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      title: map['title'] ?? '',
      imageUrl: map['image_url'],
      startAt: DateTime.parse(map['start_at']),
      endAt: DateTime.parse(map['end_at']),
    );
  }
}
