import 'package:ecommerce/common/custom_drawer/custom_drawer_header.dart';
import 'package:ecommerce/common/custom_drawer/drawer_title.dart';
import 'package:flutter/material.dart';

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
              )
            ),
          ),
          ListView(
            children: const [
              CustomDrawerHeader(),
              Divider(),
              DrawerTitle(
                iconData: Icons.home,
                title: "Início",
                page: 0,
              ),
              DrawerTitle(
                iconData: Icons.list,
                title: "Produtos",
                page: 1,
              ),
              DrawerTitle(
                iconData: Icons.playlist_add_check,
                title: "Meus Pedidos",
                page: 2,
              ),
              DrawerTitle(
                iconData: Icons.location_on,
                title: "Lojas",
                page: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
