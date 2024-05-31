import 'package:flutter/material.dart';

/// ## CustomTextButtonStyles
/// Class that defines custom styles for social media buttons.
class CustomTextButtonStyles {
  /// Button style for Facebook login.
  static final ButtonStyle buttonStyleFacebook = ButtonStyle(
    shadowColor: WidgetStateProperty.all<Color>(Colors.black),
    backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 24, 118, 241)),
    elevation: WidgetStateProperty.all<double>(2),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  );

  /// Button style for Facebook login.
  static final ButtonStyle buttonStyleGoogle = ButtonStyle(
    shadowColor: WidgetStateProperty.all<Color>(Colors.black),
    backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
    elevation: WidgetStateProperty.all<double>(2),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  );
}
