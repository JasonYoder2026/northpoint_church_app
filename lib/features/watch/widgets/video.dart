import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoView extends StatefulWidget {
  final String videoId;
  final String label;

  const VideoView({super.key, required this.videoId, required this.label});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      params: const YoutubePlayerParams(
        enableCaption: true,
        showFullscreenButton: true,
        playsInline: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: _controller,
      aspectRatio: 16 / 9,
      builder: (context, player) {
        return Column(
          children: [
            player,
            const SizedBox(height: 10),
            Text(
              widget.label,
              style: TextStyle(
                color: Theme.of(context).textTheme.displayMedium?.color,
              ),
            ),
          ],
        );
      },
    );
  }
}
