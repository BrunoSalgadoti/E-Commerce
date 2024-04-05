import 'dart:io';

import 'package:brn_ecommerce/helpers/themes/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// # Theme Data Helper (Folder: helpers/themes)
/// A helper method for obtaining the appropriate theme data based on the platform.
///
/// This method retrieves the theme data based on the current platform (Web, Android, iOS, or fallback).
ThemeData getThemeData(BuildContext context) {
  final themes = Themes(context);

  if (kIsWeb) {
    // Returns the theme data specific to the Web platform.
    return themes.themeWeb;
  } else if (Platform.isAndroid) {
    // Returns the theme data specific to the Android platform.
    return themes.themeAndroid;
    // Returns the theme data specific to the iOS platform.
  } else if (Platform.isIOS) {
    return themes.themeIos;
  } else {
    // Fallback theme data for other platforms.
    return ThemeData.light();
  }
}
