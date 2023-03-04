import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {

  final IconData iconData;
  final VoidCallback onTap;
  final Color? color;

  const CustomIconButton({Key? key,
    required this.iconData,
    required this.onTap,
    this.color
  }) : super(key: key);

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
              iconData,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
