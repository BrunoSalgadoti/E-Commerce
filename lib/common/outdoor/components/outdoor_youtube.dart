import 'dart:async';

import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class OutdoorYoutube extends StatefulWidget {
  final String url;
  final VoidCallback onEnded;

  const OutdoorYoutube({
    super.key,
    required this.url,
    required this.onEnded,
  });

  @override
  State<OutdoorYoutube> createState() => _OutdoorYoutubeState();
}

class _OutdoorYoutubeState extends State<OutdoorYoutube> {
  late YoutubePlayerController _ytController;
  Timer? _fallbackTimer;

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayerController.convertUrlToId(widget.url)!;

    _ytController = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        playsInline: true,
      ),
      endSeconds: 30,
      autoPlay: true,
    );

    _fallbackTimer = Timer(const Duration(seconds: 30), _triggerEnded);
  }

  void _triggerEnded() {
    if (!mounted) return;
    widget.onEnded();
  }

  @override
  void dispose() {
    _ytController.close();
    _fallbackTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Garantindo que tenha altura definida
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite ? constraints.maxWidth : 300.0;
        final height = width * 9 / 16; // proporção 16:9

        return SizedBox(
          width: width,
          height: height,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: YoutubePlayer(
              controller: _ytController,
              aspectRatio: 16 / 9,
            ),
          ),
        );
      },
    );
  }
}
