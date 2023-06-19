import 'package:flutter/material.dart';

class AndroidFactoryColors {
  const AndroidFactoryColors({
    Key? key,
    this.primaryColor = const Color.fromARGB(255, 180, 142, 102),
    this.scaffoldBackgroundColor = const Color.fromARGB(255, 211, 195, 175),
    this.appBarBackgroundColor = const Color.fromARGB(255, 141, 132, 91),
    this.titleMediumColor = const Color.fromARGB(255, 23, 56, 68),
    this.iconColor = const Color.fromARGB(255, 252, 225, 151),
    this.bodyLargeColor = const Color.fromARGB(255, 23, 56, 68),
    this.labelStyleColor = const Color.fromARGB(255, 23, 56, 68),
    this.focusedBorderColor = const Color.fromARGB(255, 255, 229, 105),
    this.disabledBorderColor = const Color.fromARGB(0, 121, 121, 121),
    this.errorStyleColor = const Color.fromARGB(255, 255, 2, 2),
    this.buttonColor = const Color.fromARGB(255, 252, 225, 151),
    this.disabledButtonColor = const Color.fromARGB(255, 112, 107, 107),
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
}
