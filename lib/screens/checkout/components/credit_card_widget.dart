import 'package:brn_ecommerce/common/button/custom_text_button.dart';
import 'package:brn_ecommerce/screens/checkout/components/card_back.dart';
import 'package:brn_ecommerce/screens/checkout/components/card_front.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class CreditCardWidget extends StatelessWidget {
   CreditCardWidget({super.key});

    final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

    final FocusNode numberFocus = FocusNode();
    final FocusNode dateFocus = FocusNode();
    final FocusNode nameFocus = FocusNode();
    final FocusNode cvvFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FlipCard(
              key: cardKey,
              direction: FlipDirection.HORIZONTAL,
              speed: 700,
              flipOnTouch: false,
              front: CardFront(
                  numberFocus: numberFocus,
                  dateFocus: dateFocus,
                  nameFocus: nameFocus,
              ),
              back: CardBack(
                cvvFocus: cvvFocus,
              )),
          const SizedBox(
            height: 5,
          ),
          CustomTextButton(
            icon: const Icon(
              Icons.trending_flat_outlined,
            ),
            text: 'Virar Cartão',
            fontSize: 16,
            onPressed: () {
              cardKey.currentState?.toggleCard();
            },
          )
        ],
      ),
    );
  }
}
