import 'package:decorated_text/decorated_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textForGoogleDecorations(
    {required String titleForDecorations,
      double? fontSize,
      double? borderWidth,
      dynamic fontMethod,
      dynamic fontWeight,
      Color? fillColor,
      Color? borderColor}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 1, 8, 0),
    child: DecoratedGoogleFontText(
      titleForDecorations,
      fontMethod: fontMethod ?? GoogleFonts.bungeeSpice,
      fillColor: fillColor ?? Colors.transparent,
      borderColor: borderColor ?? Colors.transparent,
      fontSize: fontSize ?? 22,
      fontWeight: fontWeight ?? FontWeight.w800,
      borderWidth: borderWidth ?? 0.8,
    ),
  );
}