import 'package:flutter/material.dart';

class ShowAlertDialog extends StatelessWidget {
  const ShowAlertDialog({
    Key? key,
    required this.titleText,
    required this.bodyText,
    required this.actions,
    this.content,
    this.titleColor = Colors.red,
    this.titleSize = 22,
    this.titleWeight = FontWeight.w600,
    this.bodyColor = Colors.black,
    this.bodySize = 14,
    this.bodyWeight = FontWeight.w600,
    this.titleAlign = TextAlign.center,
    this.bodyAlign = TextAlign.center,
    this.contentPadding,
  }) : super(key: key);

  final String? titleText;
  final String? bodyText;
  final List<Widget> actions;
  final Widget? content;
  final Color? titleColor;
  final double? titleSize;
  final TextAlign? titleAlign;
  final FontWeight? titleWeight;
  final Color? bodyColor;
  final double? bodySize;
  final TextAlign? bodyAlign;
  final FontWeight? bodyWeight;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        titleText!,
        style: TextStyle(
          color: titleColor,
          fontWeight: titleWeight,
          fontSize: titleSize,
        ),
        textAlign: titleAlign,
      ),
      content: content ??
          SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  bodyText ?? '',
                  style: TextStyle(
                    color: bodyColor,
                    fontWeight: bodyWeight,
                    fontSize: bodySize,
                  ),
                  textAlign: bodyAlign,
                ),
              ],
            ),
          ),
      contentPadding: contentPadding,
      actions: actions,
    );
  }
}
