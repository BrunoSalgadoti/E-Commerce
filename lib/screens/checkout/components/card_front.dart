import 'package:brasil_fields/brasil_fields.dart';
import 'package:brn_ecommerce/common/custom_text_form_field.dart';
import 'package:brn_ecommerce/helpers/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardFront extends StatelessWidget {
 const CardFront({super.key,
    required this.numberFocus,
    required this.dateFocus,
    required this.nameFocus
  });

  final FocusNode numberFocus;
  final FocusNode dateFocus;
  final FocusNode nameFocus;

  @override
  Widget build(BuildContext context) {
    const spaceTextFormFieldHeight = SizedBox(height: 3);
    const double ccIconSize = 35;
    const Color ccColor = Color(0xffbdf8f6);

    return Stack(alignment: Alignment.topRight, children: [
      Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                        focusNode: numberFocus,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CartaoBancarioInputFormatter()
                        ],
                        validator: (number) {
                          if (number?.length != 19) {
                            return 'I N V Á L I D O!';
                          } else if (detectCCType(number!) == null) {
                            return 'Cartão Desconhecido';
                          }
                          return null;
                        },
                        onSubmitted: (_){},
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
                        focusNode: dateFocus,
                        contentPadding: const EdgeInsets.symmetric(vertical: 6),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          ValidadeCartaoInputFormatter()
                        ],
                        validator: (date) {
                          if (date?.length != 5) return 'I N V Á L I D O!';
                          return null;
                        },
                        onSubmitted: (_){},
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
                        focusNode: nameFocus,
                        contentPadding: const EdgeInsets.symmetric(vertical: 6),
                        inputFormatters: [],
                        validator: (name) => emptyValidator(name),
                        onSubmitted: (_){},
                        onSaved: (value) {},
                      )
                    ],
                  ),
                )
              ]),
            ),
          ),
      const Positioned(
          top: 10,
          right: 10,
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.ccVisa,
                size: ccIconSize,
                color: ccColor,
              ),
              SizedBox(width: 10),
              Icon(
                FontAwesomeIcons.ccMastercard,
                size: ccIconSize,
                color: ccColor,
              ),
              SizedBox(width: 10),
              Icon(
                FontAwesomeIcons.ccAmex,
                size: ccIconSize,
                color: ccColor,
              ),
              SizedBox(width: 10),
              Icon(
                FontAwesomeIcons.ccDiscover,
                size: ccIconSize,
                color: ccColor,
              ),
              SizedBox(width: 10),
              // Icon(
              //   FontAwesomeIcons.cc,
              //   size: ccIconSize,
              //   color:  Color(0xffffffff),
              // )
            ],
          )),
    ]);
  }
}
