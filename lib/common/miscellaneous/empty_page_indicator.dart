import 'dart:async';

import 'package:flutter/material.dart';

class EmptyPageIndicator extends StatefulWidget {
  const EmptyPageIndicator({
    super.key,
    required this.title,
    required this.iconData,
    required this.image,
    this.duration = const Duration(seconds: 17),
    this.iconColor,
    this.iconSize,
    this.titleSize,
    this.titleColor,
  });

  final String title;
  final double? titleSize;
  final Color? titleColor;
  final IconData? iconData;
  final Color? iconColor;
  final double? iconSize;
  final String? image;
  final Duration? duration;

  @override
  EmptyPageIndicatorState createState() => EmptyPageIndicatorState();
}

class EmptyPageIndicatorState extends State<EmptyPageIndicator> {
  bool _showFirst = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.duration != null) {
      // Starts a timer to switch between indicators after the specified time.
      Future.delayed(widget.duration!, () {
        if (mounted) {
          setState(() {
            _showFirst = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: _showFirst,
            child: Column(
              children: [
                widget.image == null
                    ? Container()
                    : Image.asset(
                        widget.image!,
                        width: 180,
                        height: 180,
                      ),
                widget.iconData == null
                    ? Container()
                    : Icon(
                        widget.iconData,
                        size: widget.iconSize ?? 80.0,
                        color: widget.iconColor ?? Colors.white,
                      ),
                const SizedBox(height: 16),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: widget.iconSize ?? 20,
                    fontWeight: FontWeight.bold,
                    color: widget.titleColor ?? Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Visibility(
            visible: !_showFirst,
            child: Column(
              children: [
                Icon(
                  Icons.wifi_sharp,
                  size: widget.iconSize ?? 100.0,
                  color: widget.iconColor ?? Colors.white,
                ),
                Text(
                  'Verifique a sua conexão com a internet!\n'
                  'Se o erro persistir entre em contato com a Loja',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: widget.titleColor ?? Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
    }
  }
}
