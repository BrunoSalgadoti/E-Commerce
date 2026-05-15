import 'package:flutter/material.dart';

/// # Utility functions and methods (Folder: common/functions)
/// ## getColorFromString
/// Converts a hexadecimal color string to a Color object.
///
/// Takes a [color] string in the format "#RRGGBB" and returns the corresponding Color object.
/// If the input string is not in the correct format, returns Colors.transparent.

Color getColorFromString(String color) {
  if (color.length != 7 || color[0] != "#") {
    // Check if the color string is not the expected length (7 characters)
    // or if it doesn't start with '#'. In this case, return a default color or null.
    return Colors.transparent;
  }

  try {
    final int value = int.parse(color.substring(1, 7), radix: 16);
    return Color(value).withAlpha(255);
  } catch (error) {
    // If an exception occurs when trying to parse the color, return a default color or null.
    return Colors.transparent;
  }
}

/// ## getHexColor
/// Converts a Color object to a hexadecimal color string.
///
/// Takes a [color] object and returns the corresponding hexadecimal color string.
String getHexColor(Color color) {
  String hexColor = '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
  return hexColor;
}