import 'package:flutter/material.dart';

class BotaoCustomizado extends StatelessWidget {


  final dynamic texto;
  final Color corTexto;
  final Color corBotao;
  final Color corShadow;
  final VoidCallback? onPressed;
  final double fontSize;
  final double elevation;


  const BotaoCustomizado({super.key,
    @required this.texto,
    this.onPressed,
    this.corTexto = Colors.white,
    this.corBotao = const Color.fromARGB(255, 4, 125, 141),
    this.corShadow = Colors.white24,
    this.fontSize = 18,
    this.elevation = 08
  });

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: corBotao,
            shadowColor: corShadow,
            elevation: elevation,
            padding:  const EdgeInsets.fromLTRB(32, 10, 32, 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7)
            )),

        child: Text(
          texto,
          style: TextStyle(
              color: corTexto,
              fontSize: fontSize
          ),
        )
    );
  }
}
