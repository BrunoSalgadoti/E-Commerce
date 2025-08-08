import 'package:flutter/material.dart';

/// ## Another Colors (Folder: helpers/themes/factory_colors)
/// ### AnotherColors
/// A class that defines gradient colors for different platforms on the home screen.
///
/// This class encapsulates the gradient color scheme used on the home screen for Android, iOS, and Web platforms.
class AnotherColors {
  /// The first color of the gradient for Android.
  final Color homeGradientColor1Android;

  /// The second color of the gradient for Android.
  final Color homeGradientColor2Android;

  /// The first color of the gradient for iOS.
  final Color homeGradientColor1Ios;

  /// The second color of the gradient for iOS.
  final Color homeGradientColor2Ios;

  /// The first color of the gradient for Web.
  final Color homeGradientColor1Web;

  /// The second color of the gradient for Web.
  final Color homeGradientColor2Web;

  /// Creates an [AnotherColors] object with the specified gradient color values.
  ///
  /// The [homeGradientColor1Android] parameter represents the first color of the gradient for Android.
  ///
  /// The [homeGradientColor2Android] parameter represents the second color of the gradient for Android.
  ///
  /// The [homeGradientColor1Ios] parameter represents the first color of the gradient for iOS.
  ///
  /// The [homeGradientColor2Ios] parameter represents the second color of the gradient for iOS.
  ///
  /// The [homeGradientColor1Web] parameter represents the first color of the gradient for Web.
  ///
  /// The [homeGradientColor2Web] parameter represents the second color of the gradient for Web.
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
}
