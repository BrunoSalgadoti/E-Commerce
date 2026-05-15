import 'package:brn_ecommerce/shared/widgets/navigation/drawer/custom_drawer.dart';
import 'package:brn_ecommerce/shared/widgets/layout/app_bar/custom_app_bar.dart';
import 'package:brn_ecommerce/views/who_we_are/components/footer_description_widget.dart';
import 'package:brn_ecommerce/views/who_we_are/components/top_description_widget.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WhoWeAreScreen extends StatefulWidget {
  const WhoWeAreScreen({super.key});

  @override
  WhoWeAreScreenState createState() => WhoWeAreScreenState();
}

class WhoWeAreScreenState extends State<WhoWeAreScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: "5UarsHuiwuQ",
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: false,
        forceHD: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.pause(); // pausa antes de descartar
    _controller.dispose(); // libera memória
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: CustomAppBar(title: 'Quem Somos', showDrawerIcon: true, showSearchButton: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TopDescriptionWidget(),
              const SizedBox(height: 20),
              // Vídeo centralizado responsivo
              LayoutBuilder(
                builder: (context, constraints) {
                  final width =
                      constraints.maxWidth < 400 ? constraints.maxWidth : 400.0; // limita largura
                  return Center(
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.red,
                      width: width,
                      bottomActions: const [
                        CurrentPosition(),
                        ProgressBar(isExpanded: true),
                        FullScreenButton(),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              const FooterDescriptionWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
