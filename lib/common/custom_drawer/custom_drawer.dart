import 'package:ecommerce/common/custom_drawer/custom_drawer_header.dart';
import 'package:ecommerce/common/custom_drawer/drawer_title.dart';
import 'package:ecommerce/models/users_manager.dart';
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
              )
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
                    if(userManager.adminEnable) {
                      return Column(
                        children: const [
                          Divider(),
                          DrawerTitle(
                            iconData: Icons.supervised_user_circle,
                            title: 'Clientes',
                            page: 4,
                          ),
                          DrawerTitle(
                            iconData: Icons.task_alt,
                            title: 'Pedidos',
                            page: 5,
                          )
                        ],
                      );
                    }else {
                      return Container();
                    }
                  },
              )
            ],
          ),
        ],
      ),
    );
  }
}
