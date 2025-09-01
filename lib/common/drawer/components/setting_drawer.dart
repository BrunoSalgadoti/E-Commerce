import 'package:brn_ecommerce/common/drawer/components/drawer_pages_enum.dart';
import 'package:brn_ecommerce/common/drawer/components/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ## SettingsDrawer (Folder: common/drawer/components)
/// ### Components of CustomDrawer Widget
///Drawer area related to administrative settings in a PopupMenuItem (from the gear icon)
class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          //TODO: ADD more itens Settings
          value: 'Opção1',
          child: Text(
            'Gerenciar Categorias',
          ),
        ),
        const PopupMenuItem<String>(
          value: 'Opção2',
          child: Text('Configurações gerais'),
        ),

        // Add other menu options as needed
      ],
      onSelected: (String value) {
        if (value == 'Opção1') {
          context.read<PageManager>().setPage(DrawerPages.categories);
        }
      },
      // Add the conditions for the other selected options for ADM
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
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                'Configurações:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
