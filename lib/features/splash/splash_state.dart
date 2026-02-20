enum SplashStatus { loading, ready, error }

class SplashState {
  final double progress; // 0.0 → 1.0
  final SplashStatus status;
  final String? message;

  const SplashState({
    required this.progress,
    required this.status,
    this.message,
  });

  SplashState copyWith({
    double? progress,
    SplashStatus? status,
    String? message,
  }) {
    return SplashState(
      progress: progress ?? this.progress,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}