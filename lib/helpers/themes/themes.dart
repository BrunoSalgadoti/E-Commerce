import 'package:flutter/material.dart';

import 'factory_colors/android_factory_colors.dart';
import 'factory_colors/ios_factory_colos.dart';
import 'factory_colors/web_factory_colors.dart';

class Themes with ChangeNotifier {
  AndroidFactoryColors androidFactoryColors = const AndroidFactoryColors();
  IosFactoryColors iosFactoryColors = const IosFactoryColors();
  WebFactoryColors webFactoryColors = const WebFactoryColors();

  late ThemeData themeAndroid;
  late ThemeData themeIos;
  late ThemeData themeWeb;

  Themes(BuildContext context) {
    _initializeThemes(context);
  }

  void _initializeThemes(BuildContext context) {
    themeAndroid = ThemeData(
      ///Material Data Theme Flutter 3
      useMaterial3: true,
      primaryColor: androidFactoryColors.primaryColor,
      scaffoldBackgroundColor: androidFactoryColors.scaffoldBackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        backgroundColor: androidFactoryColors.appBarBackgroundColor,
        titleTextStyle: TextStyle(
            color: androidFactoryColors.appBarTextColor, fontSize: 18, fontWeight: FontWeight.w600),
        elevation: 0,
        iconTheme: IconThemeData(
          color: androidFactoryColors.iconColor,
        ),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: androidFactoryColors.titleMediumColor,
        ),
        bodyMedium: TextStyle(
          color: androidFactoryColors.bodyLargeColor,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: androidFactoryColors.labelStyleColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: androidFactoryColors.focusedBorderColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: androidFactoryColors.disabledBorderColor,
          ),
        ),
        errorStyle: TextStyle(
          color: androidFactoryColors.errorStyleColor,
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: androidFactoryColors.buttonColor,
        disabledColor: androidFactoryColors.disabledButtonColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      cardTheme: CardTheme(
        color: androidFactoryColors.cardColor,
        shadowColor: androidFactoryColors.cardShadowColor,
      ),
    );

    themeIos = ThemeData(
      ///Material Data Theme Flutter 3
      useMaterial3: true,
      primaryColor: iosFactoryColors.primaryColor,
      scaffoldBackgroundColor: iosFactoryColors.scaffoldBackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        backgroundColor: iosFactoryColors.appBarBackgroundColor,
        titleTextStyle: TextStyle(
            color: webFactoryColors.appBarTextColor, fontSize: 18, fontWeight: FontWeight.w600),
        elevation: 0,
        iconTheme: IconThemeData(
          color: iosFactoryColors.iconColor,
        ),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: iosFactoryColors.titleMediumColor,
        ),
        bodyMedium: TextStyle(
          color: iosFactoryColors.bodyLargeColor,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: iosFactoryColors.labelStyleColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: iosFactoryColors.focusedBorderColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: iosFactoryColors.disabledBorderColor,
          ),
        ),
        errorStyle: TextStyle(
          color: iosFactoryColors.errorStyleColor,
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: iosFactoryColors.buttonColor,
        disabledColor: iosFactoryColors.disabledButtonColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      cardTheme: CardTheme(
        color: iosFactoryColors.cardColor,
        shadowColor: iosFactoryColors.cardShadowColor,
      ),
    );

    themeWeb = ThemeData(
      ///Material Data Theme Flutter 3
      useMaterial3: true,
      primaryColor: webFactoryColors.primaryColor,
      scaffoldBackgroundColor: webFactoryColors.scaffoldBackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        backgroundColor: webFactoryColors.appBarBackgroundColor,
        titleTextStyle: TextStyle(
            color: webFactoryColors.appBarTextColor, fontSize: 18, fontWeight: FontWeight.w600),
        elevation: 0,
        iconTheme: IconThemeData(
          color: webFactoryColors.iconColor,
        ),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: webFactoryColors.titleMediumColor,
        ),
        bodyMedium: TextStyle(
          color: webFactoryColors.bodyLargeColor,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: webFactoryColors.labelStyleColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: webFactoryColors.focusedBorderColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: webFactoryColors.disabledBorderColor,
          ),
        ),
        errorStyle: TextStyle(
          color: webFactoryColors.errorStyleColor,
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: webFactoryColors.buttonColor,
        disabledColor: webFactoryColors.disabledButtonColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      cardTheme: CardTheme(
        color: webFactoryColors.cardColor,
        shadowColor: webFactoryColors.cardShadowColor,
      ),
    );
  }
}
