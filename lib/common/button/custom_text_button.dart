import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextButton extends StatelessWidget {
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
          : Row(
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
                  text ?? '',
                  style: TextStyle(
                    color: fontColor,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ),
                ),
              ],
            ),
    );
  }
}
