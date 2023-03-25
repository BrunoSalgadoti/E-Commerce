import 'package:ecommerce/models/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.texto,
    required this.onPressed,
    this.corTexto = Colors.white,
    this.corBotao = const Color.fromARGB(255, 4, 125, 141,),
    this.corBotaoDesativado = const Color.fromRGBO(4, 125, 141, 0.4),
    this.corShadow = Colors.white24,
    this.fontSize = 18,
    this.elevation = 08,
  }) : super(key: key);

  final String texto;
  final VoidCallback? onPressed;
  final Color corTexto;
  final Color corBotao;
  final Color corBotaoDesativado;
  final Color corShadow;
  final double fontSize;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            disabledBackgroundColor: corBotaoDesativado,
            backgroundColor: corBotao,
            shadowColor: corShadow,
            elevation: elevation,
            padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
            shape:
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)
                )),
        child: Consumer<UserManager>(
          builder: (_, userManager, __) {
            return userManager.loading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  )
                : Text(
                    texto,
                    style: TextStyle(color: corTexto, fontSize: fontSize),
                  );
          },
        ));
  }
}
