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
      videoId: '5UarsHuiwuQ',
      autoPlay: true,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
        mute: false,
        showControls: true,
        enableJavaScript: true,
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ...[const TopDescriptionWidget()],
          Padding(
            padding:
                const EdgeInsets.only(top: 16, left: 30, right: 30, bottom: 16),
            child: Center(
              // Embed do vídeo do YouTube
              child: YoutubePlayer(controller: _controller),
            ),
          ),
          ...[const FooterDescriptionWidget()]
        ],
      ),
    );
  }
}
