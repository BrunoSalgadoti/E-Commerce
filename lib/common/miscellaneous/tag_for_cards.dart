import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:decorated_text/decorated_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// # Widget for displaying a tag on a card or container (Folder: common/miscellaneous)
/// ## TagForCard
/// A widget that displays a tag with specified data and styling on a card or container.
///
/// This widget is customizable in terms of alignment, background color, size, and text style.
class TagForCard<T> extends StatelessWidget {
  final T data;
  final AlignmentGeometry alignment;
  final Color backgroundColor;
  final double? containerWidth;
  final double? containerHeight;
  final int? alphaBackgroundColor;
  final double? textFontSize;
  final GoogleFontStaticMethod googleFonts;

  /// Creates a [TagForCard] widget with the specified parameters.
  ///
  /// The [data] parameter is required and represents the data to be displayed in the tag.
  ///
  /// The [alignment] parameter sets the alignment of the tag within its parent widget.
  ///
  /// The [backgroundColor] parameter sets the background color of the tag.
  ///
  /// The [containerWidth] parameter sets the width of the container that holds the tag.
  ///
  /// The [containerHeight] parameter sets the height of the container that holds the tag.
  ///
  /// The [alphaBackgroundColor] parameter sets the alpha value for the background color.
  ///
  /// The [textFontSize] parameter sets the font size of the tag text.
  ///
  /// The [googleFonts] parameter sets the Google Font style for the tag text.
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
