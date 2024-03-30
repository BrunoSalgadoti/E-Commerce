import 'package:flutter/material.dart';

/// ## CustomTextButtonStyles
/// Class that defines custom styles for social media buttons.
class CustomTextButtonStyles {
  /// Button style for Facebook login.
  static final ButtonStyle buttonStyleFacebook = ButtonStyle(
    shadowColor: MaterialStateProperty.all<Color>(Colors.black),
    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 24, 118, 241)),
    elevation: MaterialStateProperty.all<double>(2),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  );

  /// Button style for Facebook login.
  static final ButtonStyle buttonStyleGoogle = ButtonStyle(
    shadowColor: MaterialStateProperty.all<Color>(Colors.black),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    elevation: MaterialStateProperty.all<double>(2),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  );
}
