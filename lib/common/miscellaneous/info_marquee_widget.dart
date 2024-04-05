import 'package:brn_ecommerce/helpers/themes/factory_colors/get_another_colors.dart';
import 'package:decorated_text/decorated_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// # Widget that displays an animated, clickable text marquee to display information in...
/// an eye-catching way. (Folder: common/miscellaneous)
///
/// Used to highlight important information in the application.
///
/// ## InfoMarqueeWidget
///
/// [Parameters] :
/// - [text] : Text to be displayed on the sign.
/// - [color] : Background color of the sign.
/// - [glowColor] : Animated glow color of the sign.
/// - [fontColor] : Color of the text on the sign.
/// - [borderRadius] : Marquee corner radius (optional, default is 20.0).
/// - [fontSize] : Text font size (optional, default is 16.0).
/// - [fontWeight] : Font weight of the text (optional, default is FontWeight.normal).
/// - [onPressed] : Callback function to be executed when the marquee is pressed (optional).
///
/// [Example_of_use] :
/// ```dart
/// InfoMarqueeWidget(
/// text: 'Important notice!',
/// color: Colors.yellow,
/// glowColor: Colors.orange,
/// fontColor: Colors.black,
/// borderRadius: 10.0,
/// fontSize: 18.0,
/// onPressed: () {
/// // Action when pressing the sign
/// },
/// )
/// ```
class InfoMarqueeWidget extends StatefulWidget {
  final String text;
  final Color color;
  final Color glowColor;
  final Color? fontColor;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback? onPressed;

  const InfoMarqueeWidget({
    super.key,
    required this.text,
    required this.color,
    required this.glowColor,
    this.borderRadius = 20.0,
    this.fontSize = 15.0,
    this.fontColor,
    this.fontWeight = FontWeight.normal,
    this.onPressed,
  });

  @override
  InfoMarqueeWidgetState createState() => InfoMarqueeWidgetState();
}

class InfoMarqueeWidgetState extends State<InfoMarqueeWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  bool _isGlowing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 24),
    )..repeat(reverse: false);

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(-2.0, 0.0),
    ).animate(_controller);

    _startGlowAnimation();
  }

  void _startGlowAnimation() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isGlowing = !_isGlowing;
        });
        _startGlowAnimation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Visual part of the text marquee and animated glow
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: [
          BoxShadow(
            color: _isGlowing ? widget.glowColor : Colors.transparent,
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(2.8, 2.8),
          ),
        ],
      ),
      child: Material(
        color: getButtonColor(),
        child: InkWell(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          onTap: widget.onPressed,
          child: Stack(
            children: [
              // Text part of the animated glow
              Positioned.fill(
                child: SlideTransition(
                  position: _offsetAnimation,
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 0,
                      ),
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.centerLeft,
                        child: DecoratedGoogleFontText(
                          widget.text,
                          fontMethod: GoogleFonts.kellySlab,
                          fillColor: widget.fontColor ?? Colors.black,
                          fontSize: widget.fontSize,
                          fontWeight: widget.fontWeight,
                          borderWidth: 0.4,
                          borderColor: Colors.white,
                        ),
                      )),
                ),
              ),

              // Visual part of the animated glow
              AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                width: _isGlowing ? 150 : 0,
                height: 2,
                color: widget.glowColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (mounted) {
      _controller.dispose();
      _offsetAnimation;
    }
    super.dispose();
  }
}
