import 'dart:io';

import 'package:brn_ecommerce/helpers/themes/factory_colors/android_factory_colors.dart';
import 'package:brn_ecommerce/helpers/themes/factory_colors/another_colors.dart';
import 'package:brn_ecommerce/helpers/themes/factory_colors/ios_factory_colos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'factory_colors/web_factory_colors.dart';

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
