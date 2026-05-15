import 'package:flutter/services.dart';

/// # Formatters for input fields of time and date (Folder: common/formatted_fields)
/// ## TimeInputFormatter
/// A custom input formatter for formatting time input in the format (00:00-00:00) to represent the
/// opening and closing times of the Store.
class TimeInputFormatter extends TextInputFormatter {
  // Personal Time Formatter -> (00:00-00:00)
  /// Takes the [oldValue] and [newValue] as input and returns the formatted value.
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final formattedValue = _formatTime(newValue.text);

    return newValue.copyWith(
      text: formattedValue,
      selection: _updateCursorPosition(formattedValue, newValue.selection),
    );
  }

  /// Formats the time value to match the format (00:00-00:00).
  ///
  /// Takes a [value] as input and returns the formatted time string.
  String _formatTime(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'\D'), ''); // Remove non-digits

    if (digitsOnly.isEmpty) {
      return '';
    } else if (digitsOnly.length <= 2) {
      return digitsOnly;
    } else if (digitsOnly.length <= 4) {
      return '${digitsOnly.substring(0, 2)}:${digitsOnly.substring(2)}';
    } else {
      return '${digitsOnly.substring(0, 2)}:${digitsOnly.substring(2, 4)}-${digitsOnly.substring(4, 6)}:${digitsOnly.substring(6, 8)}';
    }
  }

  /// Updates the cursor position after formatting.
  ///
  /// Takes the formatted [value] and [oldSelection] as input and returns the updated cursor position.
  TextSelection _updateCursorPosition(String value, TextSelection oldSelection) {
    final int newPosition = oldSelection.baseOffset + value.length - oldSelection.extentOffset;

    return TextSelection.collapsed(offset: newPosition);
  }
}
