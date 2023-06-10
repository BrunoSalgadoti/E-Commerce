import 'package:flutter/material.dart';

class EmptyIndicator extends StatelessWidget {
  const EmptyIndicator(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.image})
      : super(key: key);

  final String title;
  final IconData? iconData;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image == null
                ? Container()
                : Image.asset(
                    image!,
                    width: 180,
                    height: 180,
                  ),
            iconData == null
                ? Container()
                : Icon(
                    iconData,
                    size: 80.0,
                    color: Colors.white,
                  ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
