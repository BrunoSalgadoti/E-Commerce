import 'package:flutter/material.dart';

class ShowAlertDialog extends StatelessWidget {
   const ShowAlertDialog({Key? key,
     required this.titleText,
     required this.bodyText,
     required this.actions,
     this.content,
  }) : super(key: key);

  final String titleText;
  final String bodyText;
  final List<Widget> actions;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
     return AlertDialog(
            title:  Text(
              titleText,
              textAlign: TextAlign.center,
            ),
             content: content ?? SingleChildScrollView(
              child: ListBody(
                children:  <Widget>[
                  Text(
                    bodyText,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            actions: actions,
          );
        }
  }

