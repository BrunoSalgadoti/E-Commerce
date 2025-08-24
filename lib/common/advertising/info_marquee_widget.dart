import 'package:decorated_text/decorated_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoMarqueeWidget extends StatefulWidget {
  final String text;
  final Color color;
  final Color glowColor;
  final Color fontColor;
  final Color fontBorderColor;
  final double borderRadius;
  final double marqueeHeight;
  final double marqueeSpeed;
  final double marqueeStart;
  final double marqueeEnd;
  final double marqueeWidth;
  final double fontSize;
  final double fontBorderWidth;
  final double textMaxWidth;
  final FontWeight fontWeight;
  final VoidCallback? onPressed;

  const InfoMarqueeWidget({
    super.key,
    required this.text,
    required this.color,
    required this.glowColor,
    required this.marqueeWidth,
    required this.marqueeSpeed,
    required this.marqueeStart,
    required this.marqueeEnd,
    this.marqueeHeight = 30,
    this.borderRadius = 10,
    this.textMaxWidth = 800,
    this.fontSize = 15.0,
    this.fontBorderWidth = 0.4,
    this.fontColor = Colors.black,
    this.fontBorderColor = Colors.transparent,
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
      duration: Duration(seconds: widget.marqueeSpeed.toInt()),
    )..repeat(reverse: false);

    _offsetAnimation = Tween<Offset>(
      begin: Offset(widget.marqueeStart, 0.0),
      end: Offset(widget.marqueeEnd, 0.0),
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
    return Container(
      height: widget.marqueeHeight,
      width: widget.marqueeWidth,
      clipBehavior: Clip.hardEdge,
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
        color: widget.color,
        child: InkWell(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          onTap: widget.onPressed,
          child: Stack(
            children: [
              SlideTransition(
                position: _offsetAnimation,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 0,
                  ),
                  child: OverflowBox(
                    maxWidth: widget.textMaxWidth,
                    minWidth: widget.textMaxWidth,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: DecoratedGoogleFontText(
                        widget.text,
                        fontMethod: GoogleFonts.roboto,
                        // widget.fontGoogleStyle,
                        fillColor: widget.fontColor,
                        fontSize: widget.fontSize,
                        fontWeight: widget.fontWeight,
                        borderWidth: widget.fontBorderWidth,
                        borderColor: widget.fontBorderColor,
                      ),
                    ),
                  ),
                ),
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
