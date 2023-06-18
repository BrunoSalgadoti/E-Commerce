import 'package:flutter/material.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          //TODO: settings
          value: 'Opção1',
          child: Text(
            'Opção_1',
            style: TextStyle(color: Colors.black),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'Opção_2',
          child: Text('Opção 2'),
        ),
        // AAdd other menu options as needed
      ],
      onSelected: (String value) {
        if (value == 'Opção_1') {}
      },
      // Add the conditions for the other selected options
      child: const SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                Icons.settings,
                size: 33,
                color: Colors.green,
              ),
            ),
            SizedBox(width: 4),
            Text(
              'Configurações',
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
