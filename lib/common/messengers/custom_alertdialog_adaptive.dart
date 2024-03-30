import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// ## CustomAlertDialogAdaptive
/// A custom adaptive alert dialog that adapts its appearance based on the platform.
///
/// This class provides a consistent way to create alert dialogs that are visually
/// adapted for both Android and iOS platforms.
class CustomAlertDialogAdaptive {
  /// Create a [CustomAlertDialogAdaptive].
  ///
  /// The parameter [titleText] is required and represents the title text of the alert dialog.
  ///
  /// The parameter [bodyText] is required and represents the body text of the alert dialog.
  ///
  /// The parameter [actions] is required and represents the list of actions (buttons) for the alert dialog.
  ///
  /// The parameter [content] is optional and represents additional content for the alert dialog.
  ///
  /// The parameter [titleColor] sets the color of the title text.
  ///
  /// The parameter [titleSize] sets the font size of the title text.
  ///
  /// The parameter [titleAlign] sets the alignment of the title text.
  ///
  /// The parameter [titleWeight] sets the font weight of the title text.
  ///
  /// The parameter [bodyColor] sets the color of the body text.
  ///
  /// The parameter [bodySize] sets the font size of the body text.
  ///
  /// The parameter [bodyAlign] sets the alignment of the body text.
  ///
  /// The parameter [bodyWeight] sets the font weight of the body text.
  ///
  /// The parameter [contentPadding] sets the padding for the content area of the alert dialog.
  const CustomAlertDialogAdaptive({
    required this.titleText,
    required this.bodyText,
    required this.actions,
    this.content,
    this.titleColor = Colors.red,
    this.titleSize = 22,
    this.titleWeight = FontWeight.w400,
    this.bodyColor = Colors.black,
    this.bodySize = 14,
    this.bodyWeight = FontWeight.w600,
    this.titleAlign = TextAlign.center,
    this.bodyAlign = TextAlign.center,
    this.contentPadding,
  });

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

  /// Creates an adaptive action based on the current platform.
  ///
  /// The parameter [context] is required and represents the BuildContext.
  ///
  /// The parameter [onPressed] is required and is a callback function called when the action is pressed.
  ///
  /// The parameter [child] is required and represents the widget for the action.
  ///
  /// Returns an adaptive action widget based on the platform (TextButton for Android and CupertinoDialogAction for iOS).
  //TODO: Verificar uso...
  Widget adaptiveAction(
      {required BuildContext context, required VoidCallback onPressed, required Widget child}) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(onPressed: onPressed, child: child);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
    }
  }

  /// Displays the alert dialog with adaptive styling based on the platform.
  ///
  /// The parameter [context] is required and represents the BuildContext.
  ///
  /// Shows an adaptive alert dialog using [showAdaptiveDialog] with an [AlertDialog.adaptive].
  dynamic alertContent(BuildContext context) {
    showAdaptiveDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog.adaptive(
        title: Text(
          titleText ?? '',
          style: TextStyle(
            color: titleColor,
            fontWeight: titleWeight,
            fontSize: titleSize,
          ),
          textAlign: titleAlign,
        ),
        content: content ??
            Text(bodyText ?? '',
                style: TextStyle(
                  color: bodyColor,
                  fontWeight: bodyWeight,
                  fontSize: bodySize,
                ),
                textAlign: bodyAlign),
        contentPadding: contentPadding,
        actions: actions,
      ),
    );
  }
}
