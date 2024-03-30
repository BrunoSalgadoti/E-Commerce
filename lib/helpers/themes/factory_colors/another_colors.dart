import 'package:flutter/material.dart';

class AnotherColors {
  const AnotherColors({
    // Gradient Colors of Home Screen Android
    this.homeGradientColor1Android = const Color.fromARGB(255, 245, 250, 82),
    this.homeGradientColor2Android = const Color.fromARGB(255, 255, 255, 255),
    // Gradient Colors of Home Screen IOS
    this.homeGradientColor1Ios = const Color.fromARGB(255, 169, 40, 175),
    this.homeGradientColor2Ios = const Color.fromARGB(255, 231, 180, 243),
    // Gradient Colors of Home Screen WEB
    this.homeGradientColor1Web = const Color.fromARGB(255, 162, 225, 225),
    this.homeGradientColor2Web = const Color.fromARGB(255, 217, 217, 217),
  });

  final Color homeGradientColor1Android;
  final Color homeGradientColor2Android;

  final Color homeGradientColor1Ios;
  final Color homeGradientColor2Ios;

  final Color homeGradientColor1Web;
  final Color homeGradientColor2Web;
}
