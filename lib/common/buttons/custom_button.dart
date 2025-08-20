import 'package:auto_size_text/auto_size_text.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/sales/cart_manager.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

/// # Widgets of the buttons reused in the project (Folder: common/buttons)
/// ## CustomButton
/// A custom buttons that offers flexibility in terms of color, style, and action when pressed.
class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed; // Function called when the buttons is pressed
  final String text;
  final Color? buttonColor;
  final Color? textColor;
  final Color? buttonDisabledColor;
  final Color shadowColor;
  final double elevation;
  final double? heightButton;
  final double? widthButton;

  /// Create one [CustomButton].
  ///
  /// The parameter [text] is required and represents the text displayed on the buttons.
  ///
  /// The parameter [onPressed] it is a function called when the buttons is pressed.
  ///
  /// The parameter [textColor] sets the color of the buttons text.
  ///
  /// The parameter [buttonDisabledColor] sets the background color of the buttons when it is disabled.
  ///
  /// The parameter [shadowColor] sets the color of the buttons's shadow
  ///
  /// The parameter [elevation] sets the elevation of the buttons.
  ///
  /// The parameter [buttonColor] sets the background color of the buttons.
  ///
  ///  The parameter [heightButton] defines the height of the button, if not
  ///  declared its height will be the default of 45.
  ///
  ///  The parameter [widthButton] defines the width
  ///  of the button, if not declared its height will be the default of
  ///  double.infinity.
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.buttonDisabledColor,
    this.shadowColor = Colors.white24,
    this.elevation = 08,
    this.buttonColor,
    this.heightButton,
    this.widthButton,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: heightButton ?? 45,
        width: widthButton ?? double.infinity,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                disabledBackgroundColor: buttonDisabledColor,
                backgroundColor: buttonColor ?? getButtonColor(),
                shadowColor: shadowColor,
                elevation: elevation,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
            child: Consumer3<UserManager, Product, CartManager>(
              builder: (_, userManager, product, cartManager, __) {
                return userManager.loading || product.loading || cartManager.loading
                    ? FittedBox(
                        child: SpinKitThreeInOut(
                          color: getEspecialColor(),
                          size: 25,
                        ),
                      )
                    : AutoSizeText(
                        overflow: TextOverflow.ellipsis,
                        text,
                        style: TextStyle(color: textColor ?? getTextColor(), fontSize: 17),
                        maxFontSize: 20,
                        maxLines: 2,
                        minFontSize: 12,
                      );
              },
            )));
  }
}
