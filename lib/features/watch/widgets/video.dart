import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoView extends StatelessWidget {
  final String videoId;
  final String label;

  const VideoView({super.key, required this.videoId, required this.label});

  @override
  Widget build(BuildContext context) {
    final controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      //autoPlay: true,
      params: YoutubePlayerParams(
        //mute: true,
        enableCaption: true,
        showFullscreenButton: true,
      ),
    );

    return YoutubePlayerScaffold(
      controller: controller,
      aspectRatio: 16 / 9,
      builder: (context, player) {
        return Column(
          children: [
            player,
            SizedBox(height: 10),
            Text(
              label,
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
