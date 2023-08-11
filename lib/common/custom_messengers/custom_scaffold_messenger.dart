import 'package:flutter/material.dart';

class CustomScaffoldMessenger extends StatelessWidget {
  const CustomScaffoldMessenger({
    super.key,
    required this.context,
    required this.message,
    this.backgroundColor = Colors.red,
    this.duration = const Duration(seconds: 8),
    this.behavior = SnackBarBehavior.floating,
    this.borderRadius = 10,
    this.margin = const EdgeInsets.all(15),
    this.textStyle = const TextStyle(fontSize: 18),
    this.iconColor = Colors.yellow,
  });

  final BuildContext context;
  final String message;
  final Color backgroundColor;
  final Duration duration;
  final SnackBarBehavior behavior;
  final double borderRadius;
  final EdgeInsetsGeometry margin;
  final TextStyle textStyle;
  final Color iconColor;

  void msn() {
    if (message.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline_outlined, color: iconColor, size: 34),
              const SizedBox(width: 7),
              Flexible(
                child: Text(
                  message,
                  style: textStyle,
                ),
              ),
            ],
          ),
          backgroundColor: backgroundColor,
          duration: duration,
          behavior: behavior,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          margin: margin,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
