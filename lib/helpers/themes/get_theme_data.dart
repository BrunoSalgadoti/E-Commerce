import 'dart:io';

import 'package:brn_ecommerce/helpers/themes/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

ThemeData getThemeData(BuildContext context) {
  final themes = Themes();

  if (kIsWeb) {
    return themes.themeWeb;
  } else if (Platform.isAndroid) {
    return themes.themeAndroid;
  } else if (Platform.isIOS) {
    return themes.themeIos;
  } else {
    // Fallback theme
    return ThemeData.light();
  }
}