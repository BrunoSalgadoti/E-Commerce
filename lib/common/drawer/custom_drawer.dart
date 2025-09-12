import 'package:brn_ecommerce/common/drawer/components/drawer_header.dart';
import 'package:brn_ecommerce/common/drawer/components/drawer_pages_enum.dart';
import 'package:brn_ecommerce/common/drawer/components/drawer_title.dart';
import 'package:brn_ecommerce/common/drawer/components/setting_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../helpers/themes/get_another_colors.dart'
    show getDrawerColorFirst, getDrawerColorSecond;
import '../../models/users/users_manager.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: constraints.maxWidth <= 600
              ? BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8)
              : BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
            child: Drawer(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          getDrawerColorFirst(),
                          getDrawerColorSecond(),
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
                      DrawerTitle(
                        iconData: Icons.home,
                        title: "Início",
                        page: DrawerPages.home,
                      ),
                      const Divider(thickness: 2),
                      const Text(
                        'P R O D U T O S:',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      DrawerTitle(
                        iconData: Icons.list_alt_sharp,
                        title: "Por Categorias",
                        page: DrawerPages.categories,
                      ),
                      const Divider(thickness: 2),
                      const Text(
                        'SEÇÕES DO CLIENTE:',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      DrawerTitle(
                          iconData: Icons.playlist_add_check,
                          title: "Meus pedidos",
                          page: DrawerPages.orders),
                      DrawerTitle(
                          iconData: Icons.favorite,
                          title: "Meus favoritos",
                          page: DrawerPages.favorites),
                      DrawerTitle(
                        iconData: FontAwesomeIcons.heartPulse,
                        title: "Meus de desejos",
                        page: DrawerPages.wishlist,
                      ),
                      const Divider(thickness: 2),
                      DrawerTitle(
                        iconData: Icons.location_on,
                        title: "Lojas",
                        page: DrawerPages.stores,
                      ),
                      DrawerTitle(
                          iconData: FontAwesomeIcons.peopleGroup,
                          title: "Quem Somos?",
                          page: DrawerPages.whoWeAre),

                      /// Área administrativa
                      Consumer<UserManager>(
                        builder: (_, userManager, __) {
                          if (userManager.adminEnable) {
                            return Column(
                              children: [
                                const Divider(thickness: 3),
                                const Text(
                                  'ÁREA ADMINISTRATIVA:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                                DrawerTitle(
                                    iconData: Icons.supervised_user_circle,
                                    title: 'Clientes',
                                    page: DrawerPages.adminUsers),
                                DrawerTitle(
                                    iconData: Icons.task_alt,
                                    title: 'Pedidos',
                                    page: DrawerPages.adminOrders),
                                DrawerTitle(
                                    iconData: Icons.list,
                                    title: "Listar todos",
                                    page: DrawerPages.products),
                                const SettingsDrawer(),
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
      },
    );
  }
}
