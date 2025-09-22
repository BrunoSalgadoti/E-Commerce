import 'package:auto_size_text/auto_size_text.dart';
import 'package:brn_ecommerce/common/drawer/components/drawer_header.dart';
import 'package:brn_ecommerce/common/drawer/components/drawer_pages_enum.dart';
import 'package:brn_ecommerce/common/drawer/components/drawer_title.dart';
import 'package:brn_ecommerce/common/drawer/components/setting_drawer.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../helpers/themes/get_another_colors.dart'
    show getDrawerColorFirst, getDrawerColorSecond;
import '../../models/users/users_manager.dart';

class DrawerItem {
  final IconData icon;
  final String title;
  final DrawerPages page;
  final bool Function()? visible;

  const DrawerItem({
    required this.icon,
    required this.title,
    required this.page,
    this.visible,
  });
}

class CustomDrawer extends StatelessWidget {
  final bool isCollapsed;

  const CustomDrawer({super.key, this.isCollapsed = false});

  List<DrawerItem> drawerItemsClient(BuildContext context) {
    return const [
      DrawerItem(icon: Icons.home, title: "Início", page: DrawerPages.home),
      DrawerItem(icon: Icons.list_alt_sharp, title: "Por Categorias", page: DrawerPages.categories),
      DrawerItem(icon: Icons.playlist_add_check, title: "Meus pedidos", page: DrawerPages.orders),
      DrawerItem(icon: Icons.favorite, title: "Meus favoritos", page: DrawerPages.favorites),
      DrawerItem(
          icon: FontAwesomeIcons.heartPulse, title: "Meus de desejos", page: DrawerPages.wishlist),
    ];
  }

  List<DrawerItem> drawerItemsStores(BuildContext context) {
    return const [
      DrawerItem(icon: Icons.location_on, title: "Lojas", page: DrawerPages.stores),
      DrawerItem(
          icon: FontAwesomeIcons.peopleGroup, title: "Quem Somos?", page: DrawerPages.whoWeAre),
    ];
  }

  List<DrawerItem> adminItemsAdm(BuildContext context) {
    final userManager = Provider.of<UserManager>(context, listen: false);
    if (!userManager.adminEnable) return [];
    return const [
      DrawerItem(
          icon: Icons.supervised_user_circle, title: "Clientes", page: DrawerPages.adminUsers),
      DrawerItem(icon: Icons.task_alt, title: "Pedidos", page: DrawerPages.adminOrders),
      DrawerItem(icon: Icons.list, title: "Listar todos", page: DrawerPages.products),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final itemsClient = drawerItemsClient(context);
    final admin = adminItemsAdm(context);
    final itemsStores = drawerItemsStores(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: constraints.maxWidth <= mobileBreakpoint
              ? BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7)
              : BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
            child: Drawer(
              child: Stack(
                children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [getDrawerColorFirst(), getDrawerColorSecond()],
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
                          iconData: itemsClient[0].icon,
                          title: itemsClient[0].title,
                          page: itemsClient[0].page),
                      const Divider(thickness: 2),
                      const AutoSizeText(
                        'P r o d u t o s:',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        softWrap: true,
                        minFontSize: 2,
                        maxFontSize: 18,
                      ),
                      DrawerTitle(
                        iconData: itemsClient[1].icon,
                        title: itemsClient[1].title,
                        page: itemsClient[1].page,
                      ),
                      const Divider(thickness: 2),
                      const AutoSizeText(
                        'Seções do Cliente:',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        softWrap: true,
                        minFontSize: 2,
                        maxFontSize: 18,
                      ),
                      ...itemsClient.sublist(2).map((item) => DrawerTitle(
                            iconData: item.icon,
                            title: item.title,
                            page: item.page,
                          )),
                      const Divider(thickness: 2),
                      AutoSizeText(
                        'Nossa Loja:',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        softWrap: true,
                        minFontSize: 2,
                        maxFontSize: 18,
                      ),
                      ...itemsStores.map((item) => DrawerTitle(
                            iconData: item.icon,
                            title: item.title,
                            page: item.page,
                          )),
                      if (admin.isNotEmpty) ...[
                        const Divider(thickness: 3),
                        const AutoSizeText(
                          'ÁREA ADMINISTRATIVA:',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          softWrap: true,
                          minFontSize: 2,
                          maxFontSize: 18,
                        ),
                        ...admin.map(
                          (item) => DrawerTitle(
                            iconData: item.icon,
                            title: item.title,
                            page: item.page,
                          ),
                        ),
                        const SettingsDrawer(),
                      ],
                    ],
                  ),
                ],
              ),
            ),
        );
      },
    );
  }
}