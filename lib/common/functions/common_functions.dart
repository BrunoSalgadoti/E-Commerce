import 'package:flutter/material.dart';

Color getColorFromString(String color) {
  if (color.length != 7 || color[0] != "#") {
    // Check if the color string is not the expected length (7 characters)
    // or if it doesn't start with '#'. In this case, return a default color or null.
    return Colors.transparent;
  }

  try {
    final int value = int.parse(color.substring(1, 7), radix: 16);
    return Color(value).withOpacity(1.0);
  } catch (error) {
    // If an exception occurs when trying to parse the color, return a default color or null.
    return Colors.transparent;
  }
}
