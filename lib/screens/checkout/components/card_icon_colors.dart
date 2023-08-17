import 'package:flutter/material.dart';
import 'package:credit_card_type_detector/models.dart';

class CardIconColors {
  static final Map<CreditCardType, Color> _cardTypeColors = {
    CreditCardType.visa(): const Color(0xffa1dbef),
    CreditCardType.mastercard(): const Color(0xffa1dbef),
    CreditCardType.elo(): const Color(0xffa1dbef),
    CreditCardType.americanExpress(): const Color(0xffa1dbef),
    CreditCardType.discover(): const Color(0xffa1dbef),
    CreditCardType.hipercard(): const Color(0xffa1dbef),
  };

  static Color getIconColor(CreditCardType type) {
    return _cardTypeColors[type] ?? const Color(0xff727881);
  }
}
