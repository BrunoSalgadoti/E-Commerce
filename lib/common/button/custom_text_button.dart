import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    this.color,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.fontSize = 14,
  }) : super(key: key);


  final String? text;
  final VoidCallback? onPressed;
  final Color? color;
  final double fontSize;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: text == null
          ? icon!
          : Text(
        text!,
        style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
