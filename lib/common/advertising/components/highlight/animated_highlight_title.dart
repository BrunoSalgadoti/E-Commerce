import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:flutter/material.dart';

class AnimatedHighlightTitle extends StatefulWidget {
  final String title;
  final double fontSize;

  const AnimatedHighlightTitle({
    super.key,
    this.title = 'DESTAQUES',
    this.fontSize = 16,
  });

  @override
  State<AnimatedHighlightTitle> createState() => _AnimatedHighlightTitleState();
}

class _AnimatedHighlightTitleState extends State<AnimatedHighlightTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Center(
            child: textForGoogleDecorations(
              titleForDecorations: widget.title,
            ),
          ),
        ),
      ),
    );
  }
}
