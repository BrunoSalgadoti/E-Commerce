import 'package:flutter/material.dart';

/// ## Colors for Web Platform (Folder: helpers/themes/factory_colors)
/// ### WebFactoryColors
/// A class that defines colors specific to the Web platform.
///
/// This class contains color constants that are used in the Web version of the application's user interface.
class WebFactoryColors {
  /// The primary color used in the Web platform's user interface.
  final Color primaryColor;

  /// The background color used in scaffold components in the Web platform.
  final Color scaffoldBackgroundColor;

  /// The background color used in app bars in the Web platform.
  final Color appBarBackgroundColor;

  /// The color used for medium-sized titles in the Web platform.
  final Color titleMediumColor;

  /// The text color used in app bars in the Web platform.
  final Color appBarTextColor;

  /// The color used for icons in the Web platform.
  final Color iconColor;

  /// The color used for drawer icons in the Web platform.
  final Color iconDrawerColor;

  /// The color used for large-sized text in the Web platform.
  final Color titleLargeColor;

  final Color textSmall;

  /// The color used for labels in the Web platform.
  final Color labelStyleColor;

  /// The color used for focused borders in the Web platform.
  final Color focusedBorderColor;

  /// The color used for disabled borders in the Web platform.
  final Color disabledBorderColor;

  /// The color used for error styles in the Web platform.
  final Color errorStyleColor;

  /// The color used for buttons in the Web platform.
  final Color buttonColor;

  /// The color used for disabled buttons in the Web platform.
  final Color disabledButtonColor;

  /// The color used for cards in the Web platform.
  final Color cardColor;

  /// The shadow color used for cards in the Web platform.
  final Color cardShadowColor;

  /// Creates a [WebFactoryColors] instance with the specified parameters.
  ///
  /// The [primaryColor] parameter represents the primary color used in the app.
  ///
  /// The [scaffoldBackgroundColor] parameter represents the background color of scaffold components.
  ///
  /// The [appBarBackgroundColor] parameter represents the background color of app bars.
  ///
  /// The [appBarTextColor] parameter represents the text color used in app bars.
  ///
  /// The [titleMediumColor] parameter represents the medium-sized title text color.
  ///
  /// The [iconColor] parameter represents the color of icons in the app.
  ///
  /// The [iconDrawerColor] parameter represents the color of icons in the drawer.
  ///
  /// The [titleLargeColor] parameter represents the color of large-sized body text.
  ///
  /// The [labelStyleColor] parameter represents the color of label text styles.
  ///
  /// The [focusedBorderColor] parameter represents the color of focused border elements.
  ///
  /// The [disabledBorderColor] parameter represents the color of disabled border elements.
  ///
  /// The [errorStyleColor] parameter represents the color of error style elements.
  ///
  /// The [buttonColor] parameter represents the color of buttons in the app.
  ///
  /// The [disabledButtonColor] parameter represents the color of disabled buttons.
  ///
  /// The [cardColor] parameter represents the color of cards in the app.
  ///
  /// The [cardShadowColor] parameter represents the color of shadows on cards.
  const WebFactoryColors({
    Key? key,
    this.primaryColor = const Color.fromARGB(255, 255, 98, 0),
    this.scaffoldBackgroundColor = const Color.fromARGB(255, 237, 236, 236),
    this.appBarBackgroundColor = const Color.fromARGB(255, 255, 234, 0),
    this.titleMediumColor = const Color.fromARGB(255, 0, 0, 0),
    this.titleLargeColor = const Color.fromARGB(255, 0, 0, 0),
    this.textSmall = const Color.fromARGB(255, 243, 116, 116),
    this.appBarTextColor = const Color.fromARGB(255, 255, 0, 0),
    this.iconColor = const Color.fromARGB(255, 255, 0, 0),
    this.iconDrawerColor = const Color.fromARGB(255, 168, 4, 4),
    this.labelStyleColor = const Color.fromARGB(255, 9, 9, 9),
    this.focusedBorderColor = const Color.fromARGB(255, 255, 0, 0),
    this.disabledBorderColor = const Color.fromARGB(0, 237, 150, 150),
    this.errorStyleColor = const Color.fromARGB(255, 255, 2, 2),
    this.buttonColor = const Color.fromARGB(255, 255, 148, 78),
    this.disabledButtonColor = const Color.fromARGB(255, 159, 153, 153),
    this.cardColor = const Color.fromARGB(255, 255, 232, 155),
    this.cardShadowColor = const Color.fromARGB(255, 255, 113, 21),
  });
}
