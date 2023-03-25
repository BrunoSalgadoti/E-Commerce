import 'package:flutter/material.dart';

class ShowAlertDialog extends StatelessWidget {
   ShowAlertDialog({Key? key,
     required this.titleText,
     required this.bodyText,
     required this.actions,
  }) : super(key: key);

  final String titleText;
  final String bodyText;
  List<Widget> actions;

  @override
  Widget build(BuildContext context) {
     return AlertDialog(
            title:  Text(
              titleText,
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
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

