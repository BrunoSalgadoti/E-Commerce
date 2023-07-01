import 'package:flutter/material.dart';

class ColorsProducts extends ChangeNotifier{
  ColorsProducts({
    this.color,
    required this.amount,
    this.realColor,
  });

  ColorsProducts.fromMap(Map<String, dynamic> map) {
    color = map['color'] as String;
    amount = map['amount'] as int;
    realColor = _getColorFromString(color!);
    notifyListeners();
  }

  String? color;
  int amount = 0;
  Color? realColor;
  bool isColorSelected = false;

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
      'color': color ?? '',
      'amount': amount,
    };
  }

  Color _getColorFromString(String color) {
    if (color.length != 7 || color[0] != '#') {
      // Verificar se a string de cor não tem o tamanho esperado (7 caracteres)
      // ou se não começa com '#'. Nesse caso, retornar uma cor padrão ou null.
      return Colors.transparent; // ou retorne null se preferir
    }

    try {
      final int value = int.parse(color.substring(1, 7), radix: 16);
      return Color(value).withOpacity(1.0);
    } catch (e) {
      // Se ocorrer uma exceção ao tentar analisar a cor, retorne uma cor padrão ou null.
      return Colors.transparent; // ou retorne null se preferir
    }
  }

  @override
  String toString() {
    return 'ColorsProducts{color: $color, amount: $amount, '
        'realColor: $realColor, isColorSelected: $isColorSelected}';
  }
}
