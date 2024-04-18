import 'dart:async';

import 'package:brn_ecommerce/common/messengers/components/text_of_alerts_and_messengers.dart';
import 'package:flutter/material.dart';

/// # Widget for displaying an empty page indicator with alternating content (Folder: common/miscellaneous)
/// ## EmptyPageIndicator
/// A widget that displays different content based on a timer, providing visual feedback to the user.
///
/// This widget is stateful, allowing for dynamic content changes based on a specified duration.
class EmptyPageIndicator extends StatefulWidget {
  /// The title text to be displayed.
  final String title;

  /// The size of the title text.
  final double? titleSize;

  /// The color of the title text.
  final Color? titleColor;

  /// The icon data to be displayed.
  final IconData? iconData;

  /// The color of the icon.
  final Color? iconColor;

  /// The size of the icon.
  final double? iconSize;

  /// The image path to be displayed.
  final String? image;

  /// The duration for switching between indicators.
  final Duration? duration;

  /// Creates an [EmptyPageIndicator] widget with the specified parameters.
  ///
  /// The [title] parameter is required and represents the title text to be displayed.
  ///
  /// The [iconData] parameter is the icon data to be displayed.
  ///
  /// The [image] parameter is the image path to be displayed.
  ///
  /// The [duration] parameter is the duration for switching between indicators, defaulting to 17 seconds.
  ///
  /// The [iconColor] parameter sets the color of the icon.
  ///
  /// The [iconSize] parameter sets the size of the icon.
  ///
  /// The [titleSize] parameter sets the size of the title text.
  ///
  /// The [titleColor] parameter sets the color of the title text.
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

  @override
  EmptyPageIndicatorState createState() => EmptyPageIndicatorState();
}

/// The state class for the [EmptyPageIndicator] widget.
class EmptyPageIndicatorState extends State<EmptyPageIndicator> {
  /// Flag to track which content to show.
  bool _showFirst = true;

  /// Timer for switching between indicators.
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
                  alertsMessengersText.erroEmptyPageIndicator,
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
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
    }
    super.dispose();
  }
}
