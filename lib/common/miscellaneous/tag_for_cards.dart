import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:decorated_text/decorated_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagForCard<T> extends StatelessWidget {
  const TagForCard({
    super.key,
    required this.data,
    required this.alignment,
    required this.backgroundColor,
    this.containerWidth = 130,
    this.containerHeight,
    this.alphaBackgroundColor = 90,
    this.textFontSize,
    this.googleFonts = GoogleFonts.rancho,
  });

  final T data;
  final AlignmentGeometry alignment;
  final Color backgroundColor;
  final double? containerWidth;
  final double? containerHeight;
  final int? alphaBackgroundColor;
  final double? textFontSize;
  final GoogleFontStaticMethod googleFonts;

  @override
  Widget build(BuildContext context) {
    final Color textColor = getTextColorBasedOnBackground(backgroundColor);
    final Color borderColor = getBorderColorInvertedTextColor(backgroundColor);

    return Align(
      alignment: alignment,
      child: Container(
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          color: backgroundColor.withAlpha(alphaBackgroundColor ?? 90),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(9.0),
            bottomRight: Radius.circular(9.0),
          ),
        ),
        padding: const EdgeInsets.all(7),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: DecoratedGoogleFontText(
            data.toString(),
            fontMethod: googleFonts,
            fillColor: textColor,
            fontSize: textFontSize,
            fontWeight: FontWeight.w800,
            borderWidth: 0.8,
            borderColor: borderColor,
          ),
        ),
      ),
    );
  }
}
