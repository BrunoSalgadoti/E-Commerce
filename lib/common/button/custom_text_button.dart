import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    this.fontColor,
    required this.onPressed,
    required this.text,
    this.fontSize = 14,
    this.fontWeight,
    this.icon,
    this.style,
    this.imageAssetsTarget,
  }) : super(key: key);

  final String? text;
  final String? imageAssetsTarget;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final Color? fontColor;
  final double fontSize;
  final Icon? icon;
  final FontWeight? fontWeight;

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
                        ? Image.asset(
                            imageAssetsTarget!,
                            width: 28,
                            height: 28,
                          )
                        : const SizedBox(
                            height: 20,
                          ),
                Text(
                  text!,
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
