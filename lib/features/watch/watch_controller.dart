import 'package:northpoint_church_app/core/services/youtube_service.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';
import 'package:get_it/get_it.dart';

final supabase = GetIt.instance<SupabaseProvider>();

final livestreamControllerProvider =
    StateNotifierProvider<LivestreamController, LivestreamState>(
      (ref) => LivestreamController(),
    );

class LivestreamController extends StateNotifier<LivestreamState> {
  final LivestreamService service = LivestreamService();

  LivestreamController() : super(LivestreamLoading()) {
    load();
  }

  Future<void> load() async {
    try {
      final result = await service.fetchStatus();

      if (result.isLive) {
        state = LivestreamLive(result.videoId);
      } else {
        state = LivestreamOffline(result.videoId);
      }
    } catch (e) {
      state = LivestreamError("We couldn't load the livestream right now.");
    }
  }
}

sealed class LivestreamState {}

class LivestreamLoading extends LivestreamState {}

class LivestreamLive extends LivestreamState {
  final String videoId;
  LivestreamLive(this.videoId);
}

class LivestreamOffline extends LivestreamState {
  final String videoId;
  LivestreamOffline(this.videoId);
}

class LivestreamError extends LivestreamState {
  final String message;
  LivestreamError(this.message);
}
