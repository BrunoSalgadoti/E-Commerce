import 'package:flutter/material.dart';

class CustomProgressButton extends StatefulWidget {
  final double height;
  final double width;

  const CustomProgressButton({
    super.key,
    this.height = 48,
    this.width = double.infinity,
  });

  @override
  State<CustomProgressButton> createState() => _CustomProgressButtonState();
}

class _CustomProgressButtonState extends State<CustomProgressButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // fica em loop até você parar
    _progressAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: AnimatedBuilder(
        animation: _progressAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.6),
                  blurRadius: 8,
                  spreadRadius: 3,
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.green.withOpacity(0.6),
                  Colors.green.withOpacity(0.9),
                ],
                stops: [
                  (_progressAnimation.value - 0.2).clamp(0.0, 1.0),
                  _progressAnimation.value,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
