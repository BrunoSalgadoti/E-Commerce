import 'package:flutter/material.dart';

/// ## Colors for iOS Platform (Folder: helpers/themes/factory_colors)
/// ### IosFactoryColors
/// A class that defines colors specific to the iOS platform.
///
/// This class contains color constants that are used in the iOS version of the application's user interface.
class IosFactoryColors {
  /// The primary color used in the iOS platform's user interface.
  final Color primaryColor;

  /// The background color used in scaffold components in the iOS platform.
  final Color scaffoldBackgroundColor;

  /// The background color used in app bars in the iOS platform.
  final Color appBarBackgroundColor;

  /// The color used for medium-sized titles in the iOS platform.
  final Color titleMediumColor;

  /// The text color used in app bars in the iOS platform.
  final Color appBarTextColor;

  /// The color used for icons in the iOS platform.
  final Color iconColor;

  /// The color used for drawer icons in the iOS platform.
  final Color iconDrawerColor;

  /// The color used for large-sized text in the iOS platform.
  final Color titleLargeColor;

  final Color textSmall;

  /// The color used for labels in the iOS platform.
  final Color labelStyleColor;

  /// The color used for focused borders in the iOS platform.
  final Color focusedBorderColor;

  /// The color used for disabled borders in the iOS platform.
  final Color disabledBorderColor;

  /// The color used for error styles in the iOS platform.
  final Color errorStyleColor;

  /// The color used for buttons in the iOS platform.
  final Color buttonColor;

  /// The color used for disabled buttons in the iOS platform.
  final Color disabledButtonColor;

  /// The color used for cards in the iOS platform.
  final Color cardColor;

  /// The shadow color used for cards in the iOS platform.
  final Color cardShadowColor;

  /// Creates an [IosFactoryColors] instance with the specified parameters.
  ///
  /// Creates an [AndroidFactoryColors] object with the specified color values.
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
  /// The [bodyLargeColor] parameter represents the color of large-sized body text.
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
  const IosFactoryColors({
    Key? key,
    this.primaryColor = const Color.fromARGB(255, 178, 103, 151),
    this.scaffoldBackgroundColor = const Color.fromARGB(255, 211, 119, 206),
    this.appBarBackgroundColor = const Color.fromARGB(255, 169, 40, 175),
    this.titleMediumColor = const Color.fromARGB(255, 23, 56, 68),
    this.titleLargeColor = const Color.fromARGB(255, 23, 56, 68),
    this.textSmall = const Color.fromARGB(255, 243, 116, 116),
    this.appBarTextColor = const Color.fromARGB(255, 23, 56, 68),
    this.iconColor = const Color.fromARGB(255, 231, 180, 243),
    this.iconDrawerColor = const Color.fromARGB(255, 178, 103, 151),
    this.labelStyleColor = const Color.fromARGB(255, 23, 56, 68),
    this.focusedBorderColor = const Color.fromARGB(255, 245, 183, 219),
    this.disabledBorderColor = const Color.fromARGB(0, 121, 121, 121),
    this.errorStyleColor = const Color.fromARGB(255, 255, 2, 2),
    this.buttonColor = const Color.fromARGB(255, 231, 180, 243),
    this.disabledButtonColor = const Color.fromARGB(255, 112, 107, 107),
    this.cardColor = const Color.fromARGB(255, 255, 255, 255),
    this.cardShadowColor = const Color.fromARGB(255, 112, 107, 107),
  });
}
