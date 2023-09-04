import 'package:brn_ecommerce/common/button/custom_text_button.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FreightLogo extends StatelessWidget {
  const FreightLogo({
    super.key,
    required this.product,
    this.positionedBottom = 0,
    this.positionedRight = 0,
    this.containerHeight = 35,
    this.fontSize = 12,
    this.iconSize =  23,
    this.text = "Frete Gratis",
    this.containerWidth,
  });

  final Product product;

  final double? positionedBottom;
  final double? positionedRight;
  final double? containerHeight;
  final double? containerWidth;
  final double? fontSize;
  final double? iconSize;
  final String? text;

  @override
  Widget build(BuildContext context) {
    if (product.freight == false) {
      return Positioned(
        bottom: positionedBottom,
        right: positionedRight,
        child: Container(
          height: containerHeight,
            width: containerWidth,
          decoration: const BoxDecoration(
            color: Color.fromARGB(247, 151, 250, 194),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9),
            ),
          ),
          padding: const EdgeInsets.all(5),
          child: CustomTextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.all(2),
              ),
              textStyle: MaterialStateProperty.all<TextStyle>(
               TextStyle(fontSize: fontSize),
              ),
            ),
            text: text,
            icon: Icon(
              FontAwesomeIcons.truckFast,
              opticalSize: iconSize,
            ),
            onPressed: null,
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
