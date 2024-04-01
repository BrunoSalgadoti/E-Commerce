import 'package:credit_card_type_detector/models.dart';
import 'package:flutter/material.dart';

class CardIconColors {
  static final Map<CreditCardType, Color> _cardTypeColors = {
    CreditCardType.visa(): const Color(0xfff4ff00),
    CreditCardType.mastercard(): const Color(0xfff4ff00),
    CreditCardType.elo(): const Color(0xfff4ff00),
    CreditCardType.americanExpress(): const Color(0xfff4ff00),
    CreditCardType.discover(): const Color(0xfff4ff00),
    CreditCardType.hipercard(): const Color(0xfff4ff00),
  };

  static const Color defaultColor = Color(0xff656464);

  static Color getIconColor(CreditCardType type) {
    return _cardTypeColors[type] ?? defaultColor;
  }
}
