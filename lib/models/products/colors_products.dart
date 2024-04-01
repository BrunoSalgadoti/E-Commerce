import 'package:flutter/material.dart';

import '../../common/functions/common_functions.dart';

class ColorsProducts extends ChangeNotifier {
  ColorsProducts({
    this.color,
    required this.amount,
    this.realColor,
  });

  ColorsProducts.fromMap(Map<String, dynamic> map) {
    color = map["color"] as String;
    amount = map["amount"] as int;
    realColor = getColorFromString(color!);
    notifyListeners();
  }

  String? color;
  int amount = 0;
  Color? realColor;

  bool get hasAmount => amount > 0;

  ColorsProducts clone() {
    return ColorsProducts(
      realColor: realColor,
      color: color,
      amount: amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "color": color ?? "",
      "amount": amount,
    };
  }

  @override
  String toString() {
    return 'ColorsProducts{color: $color, amount: $amount, '
        'realColor: $realColor}';
  }
}
