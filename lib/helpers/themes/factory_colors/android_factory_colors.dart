import 'package:flutter/material.dart';

/// # Theme Factory Colors (Folder: helpers/themes/factory_colors)
/// ## Android Factory Colors
/// ### AndroidFactoryColors
/// A class that defines the color scheme for Android Factory's app.
///
/// This class encapsulates the color palette used throughout the Android Factory app,
/// including primary colors, background colors, text colors, button colors, and more.
class AndroidFactoryColors {
  /// The primary color used in the app.
  final Color primaryColor;

  /// The background color of scaffold components.
  final Color scaffoldBackgroundColor;

  /// The background color of app bars.
  final Color appBarBackgroundColor;

  /// The text color used in app bars.
  final Color appBarTextColor;

  /// The medium-sized title text color.
  final Color titleMediumColor;

  /// The color of icons in the app.
  final Color iconColor;

  /// The color of icons in the drawer.
  final Color iconDrawerColor;

  /// The color of large-sized body text.
  final Color bodyLargeColor;

  /// The color of label text styles.
  final Color labelStyleColor;

  /// The color of focused border elements.
  final Color focusedBorderColor;

  /// The color of disabled border elements.
  final Color disabledBorderColor;

  /// The color of error style elements.
  final Color errorStyleColor;

  /// The color of buttons in the app.
  final Color buttonColor;

  /// The color of disabled buttons.
  final Color disabledButtonColor;

  /// The color of cards in the app.
  final Color cardColor;

  /// The color of shadows on cards.
  final Color cardShadowColor;

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
  const AndroidFactoryColors({
    Key? key,
    this.primaryColor = const Color.fromARGB(255, 255, 0, 0),
    this.scaffoldBackgroundColor = const Color.fromARGB(255, 255, 180, 180),
    this.appBarBackgroundColor = const Color.fromARGB(255, 0, 0, 0),
    this.appBarTextColor = const Color.fromARGB(255, 255, 134, 134),
    this.titleMediumColor = const Color.fromARGB(255, 255, 89, 89),
    this.iconColor = const Color.fromARGB(255, 255, 89, 89),
    this.iconDrawerColor = const Color.fromARGB(255, 255, 0, 0),
    this.bodyLargeColor = const Color.fromARGB(255, 255, 180, 180),
    this.labelStyleColor = const Color.fromARGB(255, 141, 0, 0),
    this.focusedBorderColor = const Color.fromARGB(255, 255, 134, 134),
    this.disabledBorderColor = const Color.fromARGB(82, 243, 216, 216),
    this.errorStyleColor = const Color.fromARGB(255, 238, 255, 0),
    this.buttonColor = const Color.fromARGB(255, 82, 0, 0),
    this.disabledButtonColor = const Color.fromARGB(255, 100, 62, 62),
    this.cardColor = const Color.fromARGB(255, 255, 255, 255),
    this.cardShadowColor = const Color.fromARGB(255, 112, 107, 107),
  });
}
