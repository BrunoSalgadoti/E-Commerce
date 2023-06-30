import 'package:flutter/material.dart';

class ColorsProducts {
  ColorsProducts({
    this.color,
    required this.amount,
    this.realColor,
  });


  ColorsProducts.fromMap(Map<String, dynamic> map) {
    color = map['color'] as String;
    amount = map['amount'] as int;
    realColor = _getColorFromString(color);
  }

  String? color;
  int amount = 0;
  Color? realColor;
  bool isActive = false;

  bool get hasAmount => amount > 0;

  ColorsProducts clone() {
    return ColorsProducts(
      color: color,
      amount: amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'color': color ?? '',
      'amount': amount,
    };
  }

  Color _getColorFromString(String? colorString) {
    if (colorString != null) {
      final colorHex = colorString.replaceAll("#", "");
      return Color(int.parse(colorHex, radix: 16));
    } else {
      return Colors.transparent;
    }
  }

  @override
  String toString() {
    return 'ColorsProducts{color: $color, amount: $amount}';
  }
}
