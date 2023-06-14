import 'package:flutter/material.dart';

final ThemeData themeAndroid = ThemeData(
    primaryColor: const Color.fromARGB(255, 4, 125, 141),
    scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 4, 125, 141),
      elevation: 0,
    ));

final ThemeData themeiOS = ThemeData(
  primaryColor: const Color.fromARGB(255, 20, 209, 236),
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 77, 127, 136),
    elevation: 0,
  ),
);

final ThemeData themeWeb = ThemeData(
  primaryColor: const Color.fromARGB(255, 23, 56, 68),
  scaffoldBackgroundColor: const Color.fromARGB(255, 88, 115, 124),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 23, 56, 68),
    elevation: 0,
    iconTheme: IconThemeData(
      color: Color.fromARGB(255, 255, 255, 255),
    ),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      color: Colors.black87,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    // Estilo padrão para caixas de texto
    labelStyle: TextStyle(
      color: Colors.black,
    ),
    // Estilo para o texto dentro da caixa de texto quando está com foco
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
      ),
    ),
    // Estilo para o texto dentro da caixa de texto quando está desabilitada
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    // Estilo para o texto dentro da caixa de texto quando ocorre um erro
    errorStyle: TextStyle(
      color: Colors.red,
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: const Color.fromARGB(255, 185, 174, 174),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
);
