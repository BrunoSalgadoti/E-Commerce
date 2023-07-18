import 'package:brn_ecommerce/screens/who_we_are/components/footer_description_widget.dart';
import 'package:brn_ecommerce/screens/who_we_are/components/top_description_widget.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class WhoWeAreScreen extends StatefulWidget {
  const WhoWeAreScreen({Key? key}) : super(key: key);

  @override
  WhoWeAreScreenState createState() => WhoWeAreScreenState();
}

class WhoWeAreScreenState extends State<WhoWeAreScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController.fromVideoId(
      videoId: "5UarsHuiwuQ",
      autoPlay: false,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
        mute: false,
        showControls: true,
        enableJavaScript: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.stopVideo();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          ...[const TopDescriptionWidget()],
          Padding(
            padding:
                const EdgeInsets.only(top: 16, left: 30, right: 30, bottom: 16),
            child: Center(
              // Embed do vídeo do YouTube
              child: FutureBuilder<void>(
                future: Future.delayed(const Duration(seconds: 2)),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Carregando...');
                  } else {
                    return SizedBox(
                      width: 400,
                      height: 250,
                      child: YoutubePlayer(
                        controller: _controller,
                        aspectRatio: Checkbox.width,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          ...[const FooterDescriptionWidget()]
        ],
      ),
    );
  }
}
