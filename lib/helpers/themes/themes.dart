import 'package:flutter/material.dart';
import 'factory_colors/android_factory_colors.dart';
import 'factory_colors/ios_factory_colos.dart';
import 'factory_colors/web_factory_colors.dart';

class Themes with ChangeNotifier {
  AndroidFactoryColors androidFactoryColors = AndroidFactoryColors();
  IosFactoryColors iosFactoryColors = IosFactoryColors();
  WebFactoryColors webFactoryColors = WebFactoryColors();

  late ThemeData themeAndroid;
  late ThemeData themeIos;
  late ThemeData themeWeb;

  Themes() {
    _initializeThemes();
  }

  void _initializeThemes() {
    themeAndroid = ThemeData(
      primaryColor: androidFactoryColors.primaryColor,
      scaffoldBackgroundColor: androidFactoryColors.scaffoldBackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        backgroundColor: androidFactoryColors.appBarBackgroundColor,
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
            color: androidFactoryColors.focusedBorderColor!,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: androidFactoryColors.disabledBorderColor!,
          ),
        ),
        errorStyle: TextStyle(
          color: androidFactoryColors.errorStyleColor,
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: androidFactoryColors.buttonColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );

    themeIos = ThemeData(
      primaryColor: iosFactoryColors.primaryColor,
      scaffoldBackgroundColor: iosFactoryColors.scaffoldBackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        backgroundColor: iosFactoryColors.appBarBackgroundColor,
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
            color: iosFactoryColors.focusedBorderColor!,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: iosFactoryColors.disabledBorderColor!,
          ),
        ),
        errorStyle: TextStyle(
          color: iosFactoryColors.errorStyleColor,
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: iosFactoryColors.buttonColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );

    themeWeb = ThemeData(
      primaryColor: webFactoryColors.primaryColor,
      scaffoldBackgroundColor: webFactoryColors.scaffoldBackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        backgroundColor: webFactoryColors.appBarBackgroundColor,
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
            color: webFactoryColors.focusedBorderColor!,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: webFactoryColors.disabledBorderColor!,
          ),
        ),
        errorStyle: TextStyle(
          color: webFactoryColors.errorStyleColor,
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: webFactoryColors.buttonColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
