import 'package:brn_ecommerce/common/buttons/custom_text_button.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// # Widget for displaying a Freight Logo based on product freight status (Folder: common/miscellaneous)
/// ## FreightLogo
/// A widget that displays a "Frete Gratis" logo if the product has free shipping.
///
/// This widget conditionally displays the logo based on the freight status of the product.
class FreightLogo extends StatelessWidget {
  final double? positionedBottom;
  final double? positionedRight;
  final double? positionedLeft;
  final double? positionedTop;
  final double? containerHeight;
  final double? containerWidth;
  final double? fontSize;
  final double? iconSize;
  final Radius? radiusTopLeft;
  final Radius? radiusTopRight;
  final Radius? radiusBottomRight;
  final Radius? radiusBottomLeft;
  final String? text;
  final Product product;

  /// Creates a [FreightLogo] widget with the specified parameters.
  ///
  /// The [product] parameter is required and represents the product associated with the logo.
  ///
  /// The [positionedBottom] parameter sets the bottom position of the logo.
  ///
  /// The [positionedRight] parameter sets the right position of the logo.
  ///
  /// The [positionedLeft] parameter sets the left position of the logo.
  ///
  /// The [positionedTop] parameter sets the top position of the logo.
  ///
  /// The [containerHeight] parameter sets the height of the logo container.
  ///
  /// The [containerWidth] parameter sets the width of the logo container.
  ///
  /// The [radiusTopLeft] parameter sets the top left radius of the logo container.
  ///
  /// The [radiusTopRight] parameter sets the top right radius of the logo container.
  ///
  /// The [radiusBottomRight] parameter sets the bottom right radius of the logo container.
  ///
  /// The [radiusBottomLeft] parameter sets the bottom left radius of the logo container.
  ///
  /// The [fontSize] parameter sets the font size of the text inside the logo.
  ///
  /// The [iconSize] parameter sets the size of the icon inside the logo.
  ///
  /// The [text] parameter sets the text to be displayed inside the logo.
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
