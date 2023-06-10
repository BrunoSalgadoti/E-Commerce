import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {Key? key, required this.iconData, this.onTap, this.color, this.size})
      : super(key: key);

  final IconData iconData;
  final VoidCallback? onTap;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5),
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
