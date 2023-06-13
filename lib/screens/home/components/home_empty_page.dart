import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class HomeEmptyPage extends StatelessWidget {
   HomeEmptyPage({Key? key}) : super(key: key);

  final _controller = YoutubePlayerController.fromVideoId(
    videoId: '5UarsHuiwuQ',
    autoPlay: true,
    params: const YoutubePlayerParams(
        showFullscreenButton: true,
      mute: false,
      showControls: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
             const AspectRatio(
              aspectRatio: 5,
              child: Center(
                //TODO: A fazer
                child: Text('Introdução compre o APP',
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 1,
              child: Center(
                // Embed do vídeo do YouTube
                child: YoutubePlayer(
                  controller: _controller
                  ),
                ),
              ),
            const AspectRatio(
              aspectRatio: 5,
              child: Center(
                //TODO: A fazer
                child: Text('Descrição da firma do APP'),
              ),
            ),
          ],
        ),
      );
  }
}
