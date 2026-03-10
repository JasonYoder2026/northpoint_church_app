import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoView extends StatefulWidget {
  final String videoId;
  final String label;
  final bool isLive;

  const VideoView({super.key, required this.videoId, required this.label, required this.isLive});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        enableCaption: true,
        controlsVisibleAtStart: true,
        autoPlay:false,
        isLive: widget.isLive,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        aspectRatio: 16 / 9,
        showVideoProgressIndicator: true,
        bottomActions: [
          CurrentPosition(),
          ProgressBar(isExpanded: true,),
          RemainingDuration(),
          PlaybackSpeedButton(),
        ],
      ),
      builder: (context, player) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            player,
            const SizedBox(height: 10),
            Text(
              widget.label,
              textAlign: TextAlign.center,
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