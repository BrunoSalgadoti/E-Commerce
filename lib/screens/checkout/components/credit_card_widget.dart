import 'package:brn_ecommerce/common/button/custom_text_button.dart';
import 'package:brn_ecommerce/screens/checkout/components/card_back.dart';
import 'package:brn_ecommerce/screens/checkout/components/card_front.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

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
            front: const CardFront(),
            back: const CardBack()
          ),
          const SizedBox(height: 5,),
          CustomTextButton(
              icon: const Icon(Icons.trending_flat_outlined,
              ),
              text: 'Virar Cartão',
              fontSize: 16,
              onPressed: (){
                cardKey.currentState?.toggleCard();
              },
          )
        ],
      ),
    );
  }
}
