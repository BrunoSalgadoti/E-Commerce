import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// ## CustomTextButton
/// A custom text button that offers flexibility in terms of text, icon, image, and action when pressed.
class CustomTextButton extends StatelessWidget {
  /// Create a [CustomTextButton].
  ///
  /// The parameter [text] is optional and represents the text displayed on the button.
  ///
  /// The parameter [imageAssetsTarget] is optional and represents the image asset path for the button.
  ///
  /// The parameter [onPressed] is required and is a function called when the button is pressed.
  ///
  /// The parameter [style] sets the style of the button.
  ///
  /// The parameter [fontColor] sets the color of the button's text.
  ///
  /// The parameter [fontSize] sets the font size of the button's text.
  ///
  /// The parameter [fontWeight] sets the font weight of the button's text.
  ///
  /// The parameter [icon] is optional and represents the icon displayed on the button.
  ///
  /// The parameter [imageWidth] sets the width of the image displayed on the button.
  ///
  /// The parameter [imageHeight] sets the height of the image displayed on the button.
  ///
  /// The parameter [isSvg] specifies whether the image is an SVG type.
  ///
  /// The parameter [imageColor] sets the color of the image displayed on the button.
  const CustomTextButton({
    super.key,
    this.fontColor,
    required this.onPressed,
    this.text,
    this.fontSize = 14,
    this.fontWeight,
    this.icon,
    this.style,
    this.imageAssetsTarget,
    this.imageWidth = 28,
    this.imageHeight = 28,
    this.isSvg = false,
    this.imageColor,
  });

  final String? text;
  final String? imageAssetsTarget;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final Color? fontColor;
  final double fontSize;
  final Icon? icon;
  final FontWeight? fontWeight;
  final double imageWidth;
  final double imageHeight;
  final bool? isSvg;
  final Color? imageColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: style,
      child: text == null && icon != null
          ? icon!
          : FittedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon != null
                      ? icon!
                      : imageAssetsTarget != null
                          ? isSvg! // Checks if the image is of SVG type
                              ? SvgPicture.asset(
                                  imageAssetsTarget!,
                                  width: imageWidth,
                                  height: imageHeight,
                                )
                              : Image.asset(
                                  imageAssetsTarget!,
                                  width: imageWidth,
                                  height: imageHeight,
                                  color: imageColor,
                                )
                          : const SizedBox(height: 20),
                  const SizedBox(width: 10),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    text ?? '',
                    style: TextStyle(
                      color: fontColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
