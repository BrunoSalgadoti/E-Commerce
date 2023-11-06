import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.iconData,
    this.onTap,
    this.color,
    this.size,
    this.padding = const EdgeInsets.fromLTRB(8, 8, 10, 8),
  });

  final IconData iconData;
  final VoidCallback? onTap;
  final Color? color;
  final double? size;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Icon(
              size: size,
              iconData,
              color: onTap != null ? color : Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }
}
