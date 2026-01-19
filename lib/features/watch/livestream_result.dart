class LivestreamResult {
  final bool isLive;
  final String videoId;

  LivestreamResult({required this.isLive, required this.videoId});

  factory LivestreamResult.fromJson(Map<String, dynamic> json) {
    return LivestreamResult(
      isLive: json['isLive'] as bool,
      videoId: json['videoId'] as String,
    );
  }
}
