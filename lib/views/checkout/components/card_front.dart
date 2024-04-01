import 'package:brasil_fields/brasil_fields.dart';
import 'package:brn_ecommerce/common/formatted_fields/custom_text_form_field.dart';
import 'package:brn_ecommerce/helpers/validators.dart';
import 'package:brn_ecommerce/views/checkout/components/card_icon_colors.dart';
import 'package:brn_ecommerce/views/checkout/components/card_icon_types.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:credit_card_type_detector/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardFront extends StatefulWidget {
  const CardFront(
      {super.key,
      required this.numberFocus,
      required this.dateFocus,
      required this.nameFocus,
      required this.finishedFront});

  final VoidCallback finishedFront;
  final FocusNode numberFocus;
  final FocusNode dateFocus;
  final FocusNode nameFocus;

  @override
  State<CardFront> createState() => _CardFrontState();
}

class _CardFrontState extends State<CardFront> {
  Color containerColor = const Color(0xff727881);

  CreditCardType? detectedCardType;

  void onNumberChanged(String number) {
    setState(() {
      if (number.length < 4) {
        containerColor = const Color(0xff727881); // Default color when invalid
        detectedCardType = null; // Clears the detected card type when the number is invalid
      } else {
        List<CreditCardType> cardTypes = detectCCType(number);
        if (cardTypes.isNotEmpty) {
          detectedCardType = cardTypes[0]; // Store detected card type
          containerColor = CardIconColors.getIconColor(detectedCardType!);
        } else {
          // unknown card
          containerColor = CardIconColors.defaultColor;
          detectedCardType = null; // Clear card detected when invalid
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const spaceTextFormFieldHeight = SizedBox(height: 3);

    return Stack(alignment: Alignment.topRight, children: [
      Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 16,
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 250,
          color: const Color(0xFF343131),
          child: Row(children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextFormField(
                    title: 'Número',
                    titleBold: true,
                    textFormFieldColor: Colors.white,
                    hintText: '0000 0000 0000 0000',
                    hintColor: Colors.white.withAlpha(100),
                    textInputType: TextInputType.number,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusNode: widget.numberFocus,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CartaoBancarioInputFormatter()
                    ],
                    onChanged: (number) => onNumberChanged(number!),
                    validator: (number) {
                      if (number?.length != 19) {
                        return 'I N V Á L I D O!';
                      } else {
                        return null;
                      }
                    },
                    onSubmitted: (_) => widget.dateFocus.requestFocus(),
                    onSaved: (value) {},
                  ),
                  CustomTextFormField(
                    title: 'Validade',
                    titleBold: true,
                    textFormFieldColor: Colors.white,
                    hintText: 'XX/XX',
                    hintColor: Colors.white.withAlpha(100),
                    textInputType: TextInputType.number,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusNode: widget.dateFocus,
                    contentPadding: const EdgeInsets.symmetric(vertical: 6),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      ValidadeCartaoInputFormatter()
                    ],
                    validator: (date) {
                      if (date?.length != 5) return 'I N V Á L I D O!';
                      return null;
                    },
                    onSubmitted: (_) => widget.nameFocus.requestFocus(),
                    onSaved: (value) {},
                  ),
                  spaceTextFormFieldHeight,
                  CustomTextFormField(
                    title: 'Titular',
                    titleBold: true,
                    textFormFieldColor: Colors.white,
                    hintText: 'Nome impresso no Cartão',
                    hintColor: Colors.white.withAlpha(100),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusNode: widget.nameFocus,
                    contentPadding: const EdgeInsets.symmetric(vertical: 6),
                    validator: (name) => emptyValidator(name),
                    onSubmitted: (_) => widget.finishedFront(),
                    onSaved: (value) {},
                  )
                ],
              ),
            )
          ]),
        ),
      ),
      CardIconTypes(detectedCardType: detectedCardType)
    ]);
  }
}
