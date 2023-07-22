import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    assetsAudioPlayer.open(
      Audio("assets/vignette/vignette.mp3"),
    );
    Timer(const Duration(seconds: 6), () {
      Navigator.pushReplacementNamed(context, "/drawer");
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorTween = ColorTween(begin: Colors.grey, end: Colors.green);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          TweenAnimationBuilder(
            duration: const Duration(seconds: 7),
            tween: colorTween,
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  invertColors: true,
                  image: AssetImage("assets/images/splashScreen.jpg"),
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
                child: Image.asset("assets/logo/storeLogo.png"),
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
}
