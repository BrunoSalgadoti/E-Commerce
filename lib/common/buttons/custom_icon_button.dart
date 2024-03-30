import 'package:flutter/material.dart';

/// ## CustomIconButton
/// A custom icon with buttons functionality.
///
/// This widget is used to display an icon that can be clicked by the user.
/// It provides visual feedback when pressed and performs a function
/// when the buttons is pressed.
class CustomIconButton extends StatelessWidget {
  /// Cria um [CustomIconButton].
  ///
  /// The parameter [iconData] is mandatory and represents the icon to be displayed.
  ///
  /// The parameter [onTap] it is a function called when the buttons is pressed.
  ///
  /// The parameter [color] sets the color of the icon.
  ///
  /// The parameter [size] sets the size of the icon.
  ///
  /// The parameter [padding] sets the internal padding of the buttons.
  const CustomIconButton({
    super.key,
    required this.iconData,
    this.onTap,
    this.color,
    this.size,
    this.padding = const EdgeInsets.fromLTRB(8, 8, 10, 8),
  });

  final VoidCallback? onTap; // Function called when the buttons is pressed.
  final IconData iconData;
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
