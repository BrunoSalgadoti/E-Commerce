import 'dart:io';

import 'package:brn_ecommerce/helpers/themes/factory_colors/android_factory_colors.dart';
import 'package:brn_ecommerce/helpers/themes/factory_colors/another_colors.dart';
import 'package:brn_ecommerce/helpers/themes/factory_colors/ios_factory_colos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'factory_colors/web_factory_colors.dart';


Color getComplementAppBarCollor([BuildContext? context]) {
  if (kIsWeb) {
    return const AnotherColors().complementHomeAppBarCollorWeb;
  } else if (Platform.isAndroid) {
    return const AnotherColors().complementHomeAppBarCollorAndroid;
  } else if (Platform.isIOS) {
    return const AnotherColors().complementHomeAppBarCollorIos;
  } else {
    return Colors.lightBlueAccent;
  }
}
Color getDrawerColorSecond([BuildContext? context]) {
  if (kIsWeb) {
    return const AnotherColors().drawerCollorSecondWeb;
  } else if (Platform.isAndroid) {
    return const AnotherColors().drawerCollorSecondAndroid;
  } else if (Platform.isIOS) {
    return const AnotherColors().drawerCollorFirstIos;
  } else {
    return Colors.lightBlueAccent;
  }
}

Color getDrawerColorFirst([BuildContext? context]) {
  if (kIsWeb) {
    return const AnotherColors().drawerCollorFirstWeb;
  } else if (Platform.isAndroid) {
    return const AnotherColors().drawerCollorFirstAndroid;
  } else if (Platform.isIOS) {
    return const AnotherColors().drawerCollorFirstIos;
  } else {
    return Colors.lightBlueAccent;
  }
}
/// ## Color Helper Functions  (Folder: helpers/themes/factory_colors)
/// ### getEspecialColor
/// Returns a special color based on the platform or device type.
///
/// This function checks the platform or device type and returns a specific color accordingly.
///
/// The [context] parameter is optional and can be used to obtain the current build context.
Color getEspecialColor([BuildContext? context]) {
  if (kIsWeb) {
    return const WebFactoryColors().iconDrawerColor;
  } else if (Platform.isAndroid) {
    return const AndroidFactoryColors().iconDrawerColor;
  } else if (Platform.isIOS) {
    return const IosFactoryColors().iconDrawerColor;
  } else {
    return Colors.lightBlueAccent;
  }
}

/// ### getGradientColorFirst
/// Returns the first gradient color based on the platform or device type.
///
/// This function checks the platform or device type and returns the first gradient color accordingly.
///
/// The [context] parameter is optional and can be used to obtain the current build context.
Color getGradientColorFirst([BuildContext? context]) {
  if (kIsWeb) {
    return const AnotherColors().homeGradientColor1Web;
  } else if (Platform.isAndroid) {
    return const AnotherColors().homeGradientColor1Android;
  } else if (Platform.isIOS) {
    return const AnotherColors().homeGradientColor1Ios;
  } else {
    return Colors.blue;
  }
}

/// ### getGradientColorSecond
/// Returns the second gradient color based on the platform or device type.
///
/// This function checks the platform or device type and returns the second gradient color accordingly.
///
/// The [context] parameter is optional and can be used to obtain the current build context.
Color getGradientColorSecond([BuildContext? context]) {
  if (kIsWeb) {
    return const AnotherColors().homeGradientColor2Web;
  } else if (Platform.isAndroid) {
    return const AnotherColors().homeGradientColor2Android;
  } else if (Platform.isIOS) {
    return const AnotherColors().homeGradientColor2Ios;
  } else {
    return Colors.lightBlueAccent;
  }
}

/// ### getButtonColor
/// Returns the button color based on the platform or device type.
///
/// This function checks the platform or device type and returns the button color accordingly.
///
/// The [context] parameter is optional and can be used to obtain the current build context.
Color getButtonColor([BuildContext? context]) {
  if (kIsWeb) {
    return const WebFactoryColors().buttonColor;
  } else if (Platform.isAndroid) {
    return const AndroidFactoryColors().buttonColor;
  } else if (Platform.isIOS) {
    return const IosFactoryColors().buttonColor;
  } else {
    return Colors.blue;
  }
}

/// ### getTextColor
/// Returns the text color based on the platform or device type.
///
/// This function checks the platform or device type and returns the text color accordingly.
///
/// The [context] parameter is optional and can be used to obtain the current build context.
Color getTextColor([BuildContext? context]) {
  if (kIsWeb) {
    return const WebFactoryColors().titleMediumColor;
  } else if (Platform.isAndroid) {
    return const AndroidFactoryColors().titleMediumColor;
  } else if (Platform.isIOS) {
    return const IosFactoryColors().titleMediumColor;
  } else {
    return Colors.blue;
  }
}

Color getCustomAppBarColorBackground([BuildContext? context]) {
  if (kIsWeb) {
    return const WebFactoryColors().appBarBackgroundColor;
  } else if (Platform.isAndroid) {
    return const AndroidFactoryColors().appBarBackgroundColor;
  } else if (Platform.isIOS) {
    return const IosFactoryColors().appBarBackgroundColor;
  } else {
    return Colors.blue;
  }
}

Color getCustomAppBarColorTitle([BuildContext? context]) {
  if (kIsWeb) {
    return const WebFactoryColors().appBarTextColor;
  } else if (Platform.isAndroid) {
    return const AndroidFactoryColors().appBarTextColor;
  } else if (Platform.isIOS) {
    return const IosFactoryColors().appBarTextColor;
  } else {
    return Colors.blue;
  }
}

Color getCustomAppBarColorIcons([BuildContext? context]) {
  if (kIsWeb) {
    return const WebFactoryColors().iconColor;
  } else if (Platform.isAndroid) {
    return const AndroidFactoryColors().iconColor;
  } else if (Platform.isIOS) {
    return const IosFactoryColors().iconColor;
  } else {
    return Colors.blue;
  }
}

/// ## getTextColorBasedOnBackground
/// Determines the optimal text color based on the background color's luminance.
///
/// Takes a [backgroundColor] and returns the optimal text color (black or white) for readability.
Color getTextColorBasedOnBackground(Color backgroundColor) {
  // Calculates the luminosity of the background color.
  final luminance = backgroundColor.computeLuminance();

  // Sets the text color based on luminosity.
  final textColor = luminance > 0.2 ? Colors.black : Colors.white;

  return textColor;
}

/// ## getBorderColorInvertedTextColor
/// Determines the optimal text color (inverted) based on the background color's luminance.
///
/// Takes a [backgroundColor] and returns the inverted optimal text color (black or white) for readability.
Color getBorderColorInvertedTextColor(Color backgroundColor) {
  // Calculates the luminosity of the background color.
  final luminance = backgroundColor.computeLuminance();

  // Sets the text color based on luminosity.
  final textColor = luminance < 0.2 ? Colors.black : Colors.white;

  return textColor;
}

/// ## getFocusBorderColor
/// Gets the focus border color based on the platform (Web, Android, iOS).
///
/// Optionally takes a [context] to provide platform-specific colors.
Color getFocusBorderColor([BuildContext? context]) {
  if (kIsWeb) {
    return const WebFactoryColors().focusedBorderColor;
  } else if (Platform.isAndroid) {
    return const AndroidFactoryColors().focusedBorderColor;
  } else if (Platform.isIOS) {
    return const IosFactoryColors().focusedBorderColor;
  } else {
    return Colors.blue;
  }
}