import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final assetsAudioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      // Set the release mode to keep the source after playback has completed.
      assetsAudioPlayer.setReleaseMode(ReleaseMode.stop);

      // Start the player as soon as the app is displayed.
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await assetsAudioPlayer.setSource(AssetSource(RootAssets.vignetteAudio));
        await assetsAudioPlayer.resume();
      });
      Timer(const Duration(seconds: 6), () {
        Navigator.pushReplacementNamed(context, RoutesNavigator.homeScreen);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorTween = ColorTween(begin: Colors.grey, end: Colors.blue);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          TweenAnimationBuilder(
            duration: const Duration(seconds: 7),
            tween: colorTween,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  invertColors: true,
                  image: AssetImage(RootAssets.splashScreenJpg),
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.all(16),
            ),
            builder: (BuildContext context, Color? color, Widget? widget) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(color!, BlendMode.overlay),
                child: widget,
              );
            },
          ),
          TweenAnimationBuilder(
            duration: const Duration(seconds: 5),
            tween: Tween<double>(begin: 50, end: 500),
            builder: (BuildContext context, double width, Widget? widget) {
              return SizedBox(
                width: width,
                height: 500,
                child: Image.asset(RootAssets.storeImgLogo),
              );
            },
          ),
          const Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 400),
                child: CircularProgressIndicator(
                  color: Colors.red,
                  strokeWidth: 6,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (mounted) {
      assetsAudioPlayer.stop();
      assetsAudioPlayer.dispose();
      super.dispose();
    }
  }
}
