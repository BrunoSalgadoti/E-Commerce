import 'package:flutter/material.dart';

class CustomTextButtonStyles {
  static final ButtonStyle buttonStyleFacebook = ButtonStyle(
    shadowColor: MaterialStateProperty.all<Color>(Colors.black),
    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 24, 118, 241)),
    elevation: MaterialStateProperty.all<double>(2),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );

  static final ButtonStyle buttonStyleGoogle = ButtonStyle(
    shadowColor: MaterialStateProperty.all<Color>(Colors.black),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    elevation: MaterialStateProperty.all<double>(2),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}
