import 'package:brn_ecommerce/models/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          //TODO: Settings
          value: 'Opção1',
          child: Text(
            'Gerenciar Categorias',
          ),
        ),
        const PopupMenuItem<String>(
          value: 'Opção2',
          child: Text('Opção 2'),
        ),
        // AAdd other menu options as needed
      ],
      onSelected: (String value) {
        if (value == 'Opção1') {
          context.read<PageManager>().setPage(2);
        }
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
              ),
            ),
            SizedBox(width: 4),
            Text(
              'Configurações',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
