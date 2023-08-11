import 'package:flutter/services.dart';

class TimeInputFormatter extends TextInputFormatter {
  // Personal Time Formatter -> (00:00-00:00)
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final formattedValue = _formatTime(newValue.text);

    return newValue.copyWith(
      text: formattedValue,
      selection: _updateCursorPosition(formattedValue, newValue.selection),
    );
  }

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

  TextSelection _updateCursorPosition(
      String value, TextSelection oldSelection) {
    final int newPosition =
        oldSelection.baseOffset + value.length - oldSelection.extentOffset;

    return TextSelection.collapsed(offset: newPosition);
  }
}
