import 'package:brn_ecommerce/common/drawer/components/drawer_header.dart';
import 'package:brn_ecommerce/common/drawer/components/drawer_title.dart';
import 'package:brn_ecommerce/common/drawer/components/setting_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/users/users_manager.dart';

/// # Widgets of the Custom Drawer reused in the project (Folder: common/drawer)
/// ## CustomDrawer
/// Widget that represents a custom drawer for navigation in the app.
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.8),
      child: Drawer(
        semanticLabel: "Menu de opções",
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 203, 236, 241),
                      Colors.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              ListView(
                children: [
                  const CustomDrawerHeader(),
                  const Divider(),
                  const DrawerTitle(
                    iconData: Icons.home,
                    title: "Início",
                    page: 0,
                  ),
                  const Divider(thickness: 2),
                  const Text(
                    'P R O D U T O S:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const DrawerTitle(
                    iconData: Icons.list,
                    title: "Listar todos",
                    page: 1,
                  ),
                  const DrawerTitle(
                    iconData: Icons.list_alt_sharp,
                    title: "Por Categorias",
                    page: 2,
                  ),
                  const Divider(thickness: 2),
                  const Text(
                    'Seções do Cliente:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const DrawerTitle(
                    iconData: Icons.playlist_add_check,
                    title: "Meus Pedidos",
                    page: 3,
                  ),
                  const Divider(thickness: 2),
                  const DrawerTitle(
                    iconData: Icons.location_on,
                    title: "Lojas",
                    page: 4,
                  ),
                  const DrawerTitle(
                    iconData: FontAwesomeIcons.peopleGroup,
                    title: "Quem Somos?",
                    page: 5,
                  ),

                  /// Start of the Drawer referring to users with administrative access only.
                  Consumer<UserManager>(
                    builder: (_, userManager, __) {
                      if (userManager.adminEnable) {
                        return const Column(
                          children: [
                            Divider(thickness: 3),
                            Text(
                              'Área Administrativa:',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            DrawerTitle(
                              iconData: Icons.supervised_user_circle,
                              title: 'Clientes',
                              page: 6,
                            ),
                            DrawerTitle(
                              iconData: Icons.task_alt,
                              title: 'Pedidos',
                              page: 7,
                            ),
                            ...[SettingsDrawer()]
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
