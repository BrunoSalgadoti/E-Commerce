import 'package:brn_ecommerce/common/button/custom_text_button.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FreightLogo extends StatelessWidget {
  const FreightLogo({
    super.key,
    required this.product,
    this.positionedBottom = 0,
    this.positionedRight,
    this.positionedTop,
    this.positionedLeft,
    this.containerHeight = 35,
    this.fontSize = 12,
    this.iconSize = 23,
    this.text = "Frete Gratis",
    this.containerWidth,
    this.radiusTopLeft,
    this.radiusTopRight,
    this.radiusBottomRight,
    this.radiusBottomLeft,
  });

  final Product product;

  final double? positionedBottom;
  final double? positionedRight;
  final double? positionedLeft;
  final double? positionedTop;
  final double? containerHeight;
  final double? containerWidth;
  final Radius? radiusTopLeft;
  final Radius? radiusTopRight;
  final Radius? radiusBottomRight;
  final Radius? radiusBottomLeft;
  final double? fontSize;
  final double? iconSize;
  final String? text;

  @override
  Widget build(BuildContext context) {
    if (product.freight == false) {
      return Positioned(
        bottom: positionedBottom,
        right: positionedRight,
        left: positionedLeft,
        top: positionedTop,
        child: Container(
          height: containerHeight,
          width: containerWidth,
          decoration: BoxDecoration(
            color: const Color.fromARGB(247, 151, 250, 194),
            borderRadius: BorderRadius.only(
              topLeft: radiusTopLeft ?? const Radius.circular(9),
              topRight: radiusTopRight ?? Radius.zero,
              bottomRight: radiusBottomRight ?? Radius.zero,
              bottomLeft: radiusBottomLeft ?? Radius.zero,
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
