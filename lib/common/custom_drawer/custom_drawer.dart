import 'package:brn_ecommerce/common/custom_drawer/custom_drawer_header.dart';
import 'package:brn_ecommerce/common/custom_drawer/drawer_title.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              const DrawerTitle(
                iconData: Icons.list,
                title: "Produtos",
                page: 1,
              ),
              const DrawerTitle(
                iconData: Icons.playlist_add_check,
                title: "Meus Pedidos",
                page: 2,
              ),
              const DrawerTitle(
                iconData: Icons.location_on,
                title: "Lojas",
                page: 3,
              ),
              Consumer<UserManager>(
                builder: (_, userManager, __) {
                  if (userManager.adminEnable) {
                    return Column(
                      children: [
                        const Divider(),
                        const DrawerTitle(
                          iconData: Icons.supervised_user_circle,
                          title: 'Clientes',
                          page: 4,
                        ),
                        const DrawerTitle(
                          iconData: Icons.task_alt,
                          title: 'Pedidos',
                          page: 5,
                        ),
                        PopupMenuButton<String>(
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              //TODO: settings
                              value: 'Opção1',
                              child: Text(
                                'Opção 1',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Opção 2',
                              child: Text('Opção 2'),
                            ),
                            // AAdd other menu options as needed
                          ],
                          onSelected: (String value) {
                            if (value == 'Opção 1') {}
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
                        ),
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
    );
  }
}
