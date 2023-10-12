import 'package:flutter/material.dart';

class AndroidFactoryColors {
  const AndroidFactoryColors({
    Key? key,
    this.primaryColor = const Color.fromARGB(255, 255, 242, 0),
    this.scaffoldBackgroundColor = const Color.fromARGB(255, 255, 231, 231),
    this.appBarBackgroundColor = const Color.fromARGB(255, 245, 250, 82),
    this.appBarTextColor = const Color.fromARGB(255, 23, 56, 68),
    this.titleMediumColor = const Color.fromARGB(255, 23, 56, 68),
    this.iconColor = const Color.fromARGB(255, 255, 136, 0),
    this.iconDrawerColor = const Color.fromARGB(255, 255, 136, 0),
    this.bodyLargeColor = const Color.fromARGB(255, 23, 56, 68),
    this.labelStyleColor = const Color.fromARGB(255, 23, 56, 68),
    this.focusedBorderColor = const Color.fromARGB(255, 255, 212, 212),
    this.disabledBorderColor = const Color.fromARGB(0, 121, 121, 121),
    this.errorStyleColor = const Color.fromARGB(255, 255, 2, 2),
    this.buttonColor = const Color.fromARGB(255, 255, 225, 75),
    this.disabledButtonColor = const Color.fromARGB(255, 112, 107, 107),
    this.cardColor = const Color.fromARGB(255, 255, 255, 255),
    this.cardShadowColor = const Color.fromARGB(255, 112, 107, 107),
  });

  final Color primaryColor;
  final Color scaffoldBackgroundColor;
  final Color appBarBackgroundColor;
  final Color titleMediumColor;
  final Color iconColor;
  final Color bodyLargeColor;
  final Color labelStyleColor;
  final Color focusedBorderColor;
  final Color disabledBorderColor;
  final Color errorStyleColor;
  final Color buttonColor;
  final Color disabledButtonColor;
  final Color cardColor;
  final Color cardShadowColor;
  final Color iconDrawerColor;
  final Color appBarTextColor;
}
