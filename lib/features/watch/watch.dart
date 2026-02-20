import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'watch_controller.dart';
import 'widgets/video.dart';
import 'package:go_router/go_router.dart';
import '../global_widgets/app_bar.dart';

class LivestreamPage extends ConsumerWidget {
  const LivestreamPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(livestreamControllerProvider);

    return Scaffold(
      appBar: GradientAppBar(
        toolbarHeight: 40,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: switch (state) {
        LivestreamLoading() => const Center(child: CircularProgressIndicator()),

        LivestreamLive(:final videoId) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
          child: VideoView(videoId: videoId, label: ''),
        ),

        LivestreamOffline(:final videoId) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
          child: VideoView(
            videoId: videoId,
            label: "We're not live right now — check out our latest service!",
          ),
        ),

        LivestreamError(:final message) => Center(child: Text(message)),
      },
    );
  }
}
