import 'package:get_it/get_it.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';
import 'package:northpoint_church_app/features/watch/livestream_result.dart';

class LivestreamService {
  final supabase = GetIt.instance<SupabaseProvider>();

  Future<LivestreamResult> fetchStatus() async {
    final response = await supabase.runEdgeFunction("youtube-status", {});

    if (response?.status != 200) {
      throw Exception("Failed to load livestream");
    }

    final data = response!.data;

    return LivestreamResult(
      isLive: data['isLive'] ?? false,
      videoId: data['videoId'] ?? '',
    );
  }
}
