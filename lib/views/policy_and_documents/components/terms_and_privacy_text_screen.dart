import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsAndPrivacyTextScreen extends StatelessWidget {
  final String content;

  const TermsAndPrivacyTextScreen({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.98;
    final maxHeight = MediaQuery.of(context).size.height * 0.88;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Image.asset(
            "assets/logo/storeLogo2.png",
            width: 150,
            fit: BoxFit.fill,
          ),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
              SizedBox(width: maxWidth, height: maxHeight, child: Markdown(data: content)),
            ])));
  }
}
