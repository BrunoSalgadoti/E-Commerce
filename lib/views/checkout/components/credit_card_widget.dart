import 'package:brn_ecommerce/common/buttons/custom_text_button.dart';
import 'package:brn_ecommerce/views/checkout/components/card_back.dart';
import 'package:brn_ecommerce/views/checkout/components/card_front.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class CreditCardWidget extends StatefulWidget {
  const CreditCardWidget({super.key});

  @override
  State<CreditCardWidget> createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  dynamic toggleCard() {
    cardKey.currentState?.toggleCard();
    cvvFocus.requestFocus();
  }

  final FocusNode numberFocus = FocusNode();
  final FocusNode dateFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode cvvFocus = FocusNode();

  //Actions for Ios keyboard
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        keyboardBarColor: Colors.grey[200],
        actions: [
          KeyboardActionsItem(focusNode: numberFocus, displayDoneButton: false),
          KeyboardActionsItem(focusNode: dateFocus, displayDoneButton: false),
          KeyboardActionsItem(focusNode: nameFocus, toolbarButtons: [
            (_) {
              return GestureDetector(
                onTap: () {
                  toggleCard();
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: Text('CONTINUAR'),
                ),
              );
            }
          ]),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: _buildConfig(context),
      autoScroll: false,
      child: Padding(
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
                  finishedFront: () {
                    toggleCard();
                  },
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
      ),
    );
  }
}
