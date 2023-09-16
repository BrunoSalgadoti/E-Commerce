import 'package:flutter/material.dart';

extension Hour on TimeOfDay {
  String formatted() {
    return '$hour:${minute.toString().padLeft(2, '0')}';
  }

  int toMinutes() => hour * 60 + minute;
}

extension DayAndHour on DateTime {
  String formatted() {
    final day = this.day.toString().padLeft(2, '0');
    final month = this.month.toString().padLeft(2, '0');
    final year = this.year.toString();
    final hour = this.hour.toString().padLeft(2, '0');
    final minute = this.minute.toString().padLeft(2, '0');
    return '$day/$month/$year $hour:$minute';
  }
}
