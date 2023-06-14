import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class HomeEmptyPage extends StatefulWidget {
  const HomeEmptyPage({Key? key}) : super(key: key);

  @override
  HomeEmptyPageState createState() => HomeEmptyPageState();
}

class HomeEmptyPageState extends State<HomeEmptyPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController.fromVideoId(
      videoId: '5UarsHuiwuQ',
      autoPlay: true,
      params: const YoutubePlayerParams(
          showFullscreenButton: true,
          mute: false,
          showControls: true,
          enableJavaScript: kIsWeb ? false : true // verificar se funciona
          ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const AspectRatio(
            aspectRatio: 5,
            child: Center(
              //TODO: A fazer
              child: Text('Introdução compre o APP'),
            ),
          ),
          kIsWeb
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 150), // Espaço à esquerda
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: YoutubePlayer(
                          controller: _controller,
                        ),
                      ),
                    ),
                    const SizedBox(width: 150), // Espaço à direita
                  ],
                )
              : AspectRatio(
                  aspectRatio: 1,
                  child: Center(
                    // Embed do vídeo do YouTube
                    child: YoutubePlayer(controller: _controller),
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
