import 'package:flutter/material.dart';

/// # Time extension for class [TimeOfDay] (Folder: helpers).
///
/// This extension adds functionality to format the time in HH:mm format
/// and convert the hour to minutes.
extension Hour on TimeOfDay {
  /// Formats the time in HH:mm format.
  String formatted() {
    return '$hour:${minute.toString().padLeft(2, '0')}';
  }

  /// Converts the hour to minutes.
  int toMinutes() => hour * 60 + minute;
}

/// Day and time extension for class [DateTime] (Folder: helpers).
///
/// This extension adds functionality to format the date and time in the format
/// dd/MM/yyyy HH:mm.
extension DayAndHour on DateTime {
  /// Formats the date and time in dd/MM/yyyy HH:mm format.
  String formatted() {
    final day = this.day.toString().padLeft(2, '0');
    final month = this.month.toString().padLeft(2, '0');
    final year = this.year.toString();
    final hour = this.hour.toString().padLeft(2, '0');
    final minute = this.minute.toString().padLeft(2, '0');
    return '$day/$month/$year $hour:$minute';
  }
}
