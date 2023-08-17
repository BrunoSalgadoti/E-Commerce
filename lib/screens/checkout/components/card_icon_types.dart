import 'package:credit_card_type_detector/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'card_icon_colors.dart';

class CardIconTypes extends StatefulWidget {
  const CardIconTypes({super.key, required this.detectedCardType});

  final CreditCardType? detectedCardType;

  @override
  State<CardIconTypes> createState() => _CardIconTypesState();
}

class _CardIconTypesState extends State<CardIconTypes> {
  @override
  Widget build(BuildContext context) {
    const double containerSizeWidth = 39;
    const double containerSizeHeight = 35;
    const spaceBetweenCardsWidth = SizedBox(width: 4);

    return Positioned(
      top: 10,
      right: 10,
      child: Row(
        children: [
          spaceBetweenCardsWidth,
          _buildIconContainer(
            'assets/icons/visa.svg',
            containerSizeWidth,
            containerSizeHeight,
            CreditCardType.visa(),
            widget.detectedCardType,
          ),
          spaceBetweenCardsWidth,
          _buildIconContainer(
            'assets/icons/mastercard.svg',
            containerSizeWidth,
            containerSizeHeight,
            CreditCardType.mastercard(),
            widget.detectedCardType,
          ),
          spaceBetweenCardsWidth,
          _buildIconContainer(
            'assets/icons/elo.svg',
            containerSizeWidth,
            containerSizeHeight,
            CreditCardType.elo(),
            widget.detectedCardType,
          ),
          spaceBetweenCardsWidth,
          _buildIconContainer(
            'assets/icons/amex.svg',
            containerSizeWidth,
            containerSizeHeight,
            CreditCardType.americanExpress(),
            widget.detectedCardType,
          ),
          spaceBetweenCardsWidth,
          _buildIconContainer(
            'assets/icons/discover.svg',
            containerSizeWidth,
            containerSizeHeight,
            CreditCardType.discover(),
            widget.detectedCardType,
          ),
          spaceBetweenCardsWidth,
          _buildIconContainer(
            'assets/icons/hipercard.svg',
            containerSizeWidth,
            containerSizeHeight,
            CreditCardType.hipercard(),
            widget.detectedCardType,
          ),
        ],
      ),
    );
  }

  Widget _buildIconContainer(
    String iconAsset,
    double containerSizeWidth,
    double containerSizeHeight,
    CreditCardType cardType,
    CreditCardType? detectedCardType,
  ) {
    final Color color = detectedCardType == cardType
        ? CardIconColors.getIconColor(cardType)
        : CardIconColors.defaultColor;

    return Container(
      width: containerSizeWidth,
      height: containerSizeHeight,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Center(
        child: SvgPicture.asset(
          iconAsset,
        ),
      ),
    );
  }
}
