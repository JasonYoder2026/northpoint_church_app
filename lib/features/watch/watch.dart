import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'watch_controller.dart';
import 'widgets/video.dart';

class LivestreamPage extends ConsumerWidget {
  const LivestreamPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(livestreamControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Livestream')),
      body: switch (state) {
        LivestreamLoading() => const Center(child: CircularProgressIndicator()),

        LivestreamLive(:final videoId) => VideoView(
          videoId: videoId,
          label: '🔴 Live Now',
        ),

        LivestreamOffline(:final videoId) => VideoView(
          videoId: videoId,
          label: "We're not live right now — check out our latest service!",
        ),

        LivestreamError(:final message) => Center(child: Text(message)),
      },
    );
  }
}
