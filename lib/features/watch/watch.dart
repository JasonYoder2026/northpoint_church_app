import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'watch_controller.dart';
import 'widgets/video.dart';
import 'package:go_router/go_router.dart';

class LivestreamPage extends ConsumerWidget {
  const LivestreamPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(livestreamControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: switch (state) {
        LivestreamLoading() => const Center(child: CircularProgressIndicator()),

        LivestreamLive(:final videoId) => VideoView(
          videoId: videoId,
          label: '',
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
