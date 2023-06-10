import 'package:brn_ecommerce/models/cart_manager.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.white,
    this.buttonColor = const Color.fromARGB(255, 4, 125, 141),
    this.buttonDisabledColor = const Color.fromRGBO(4, 125, 141, 0.4),
    this.shadowColor = Colors.white24,
    this.fontSize = 18,
    this.elevation = 08,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final Color textColor;
  final Color buttonColor;
  final Color buttonDisabledColor;
  final Color shadowColor;
  final double fontSize;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              disabledBackgroundColor: buttonDisabledColor,
              backgroundColor: buttonColor,
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
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                  : Text(
                      text,
                      style: TextStyle(color: textColor, fontSize: fontSize),
                    );
            },
          )),
    );
  }
}
