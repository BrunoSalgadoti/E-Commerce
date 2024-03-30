import 'package:flutter/material.dart';

/// ## CustomScaffoldMessenger (Folder: common/messengers)
/// Widget that encapsulates the logic for showing a custom Snackbar message using ScaffoldMessenger.
class CustomScaffoldMessenger extends StatelessWidget {
  /// Create a CustomScaffoldMessenger widget.
  ///
  /// The parameters [context] and [message] are required.
  ///
  /// The parameter [backgroundColor] sets the background color of the Snackbar.
  ///
  /// The parameter [duration] sets the duration for which the Snackbar is displayed.
  ///
  /// The parameter [behavior] sets the behavior of the Snackbar.
  ///
  /// The parameter [borderRadius] sets the border radius for the Snackbar.
  ///
  /// The parameter [margin] sets the margin around the Snackbar.
  ///
  /// The parameter [textStyle] sets the style of the text in the Snackbar.
  ///
  /// The parameter [iconColor] sets the color of the icon in the Snackbar.

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

  /// Method to show the Snackbar message.
  ///
  /// This method checks if the message is not empty and then shows a Snackbar using ScaffoldMessenger.
  dynamic alertScaffold() {
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
