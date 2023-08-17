import 'package:brasil_fields/brasil_fields.dart';
import 'package:brn_ecommerce/common/custom_text_form_field.dart';
import 'package:brn_ecommerce/helpers/validators.dart';
import 'package:brn_ecommerce/screens/checkout/components/card_icon_colors.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:credit_card_type_detector/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  @override
  Widget build(BuildContext context) {
    const spaceTextFormFieldHeight = SizedBox(height: 3);
    const double containerSizeWidth = 45;
    const spaceBetweenCardsWidth = SizedBox(width: 4);
    Color containerColor;

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
                    onChanged: (number) {
                      setState(() {
                        if (number!.length < 4) {
                          containerColor = const Color(0xff727881);
                        } else {
                          List<CreditCardType> types = detectCCType(number);
                          if (types.isNotEmpty) {
                            CreditCardType primaryType = types.first;
                            debugPrint(primaryType.toString());
                            containerColor =
                                CardIconColors.getIconColor(primaryType);
                          } else {
                            containerColor = const Color(0xffa1dbef);
                          }
                        }
                      });
                    },
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
      Positioned(
        top: 10,
        right: 10,
        child: Row(
          children: [
            spaceBetweenCardsWidth,
            _buildIconContainer('assets/icons/visa.svg', containerSizeWidth,
                CardIconColors.getIconColor(CreditCardType.visa())),
            spaceBetweenCardsWidth,
            _buildIconContainer(
                'assets/icons/mastercard.svg',
                containerSizeWidth,
                CardIconColors.getIconColor(CreditCardType.mastercard())),
            spaceBetweenCardsWidth,
            _buildIconContainer('assets/icons/elo.svg', containerSizeWidth,
                CardIconColors.getIconColor(CreditCardType.elo())),
            spaceBetweenCardsWidth,
            _buildIconContainer('assets/icons/amex.svg', containerSizeWidth,
                CardIconColors.getIconColor(CreditCardType.americanExpress())),
            spaceBetweenCardsWidth,
            _buildIconContainer('assets/icons/discover.svg', containerSizeWidth,
                CardIconColors.getIconColor(CreditCardType.discover())),
            spaceBetweenCardsWidth,
            _buildIconContainer(
                'assets/icons/hipercard.svg',
                containerSizeWidth,
                CardIconColors.getIconColor(CreditCardType.hipercard())),
          ],
        ),
      ),
    ]);
  }

  Widget _buildIconContainer(
      String iconAsset, double containerSizeWidth, Color color) {
    const double containerSizeHeight = 35;

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
