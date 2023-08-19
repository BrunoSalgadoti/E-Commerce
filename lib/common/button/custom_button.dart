import 'dart:io';

import 'package:brn_ecommerce/helpers/themes/factory_colors/android_factory_colors.dart';
import 'package:brn_ecommerce/helpers/themes/factory_colors/ios_factory_colos.dart';
import 'package:brn_ecommerce/helpers/themes/factory_colors/web_factory_colors.dart';
import 'package:brn_ecommerce/models/cart_manager.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.buttonDisabledColor,
    this.shadowColor = Colors.white24,
    this.elevation = 08,
    this.buttonColor,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final Color? buttonDisabledColor;
  final Color shadowColor;
  final double elevation;

  Color getButtonColor([BuildContext? context]) {
    if (kIsWeb) {
      return const WebFactoryColors().buttonColor;
    } else if (Platform.isAndroid) {
      return const AndroidFactoryColors().buttonColor;
    } else if (Platform.isIOS) {
      return const IosFactoryColors().buttonColor;
    } else {
      return Colors.blue;
    }
  }

  Color getTextColor([BuildContext? context]) {
    if (kIsWeb) {
      return const WebFactoryColors().titleMediumColor;
    } else if (Platform.isAndroid) {
      return const AndroidFactoryColors().titleMediumColor;
    } else if (Platform.isIOS) {
      return const IosFactoryColors().titleMediumColor;
    } else {
      return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    const buttonHeight = 38;
    const maxFontSize = 14.0;

    double adjustedFontSize = maxFontSize;
    if (screenHeight < buttonHeight) {
      adjustedFontSize = maxFontSize * (screenHeight / buttonHeight);
    }

    return SizedBox(
        height: 38,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                disabledBackgroundColor: buttonDisabledColor,
                backgroundColor: buttonColor ?? getButtonColor(),
                shadowColor: shadowColor,
                elevation: elevation,
                padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7))),
            child: Consumer3<UserManager, Product, CartManager>(
              builder: (_, userManager, product, cartManager, __) {
                return userManager.loading ||
                        product.loading ||
                        cartManager.loading
                    ? SpinKitThreeInOut(
                        color: Theme.of(context).primaryColor,
                        size: 25.0,
                      )
                    : Text(
                        text,
                        style: TextStyle(
                            color: textColor ?? getTextColor(),
                            fontSize: adjustedFontSize),
                      );
              },
            )));
  }
}
