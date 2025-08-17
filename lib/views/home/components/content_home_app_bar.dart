import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart' show RoutesNavigator;
import 'package:brn_ecommerce/models/users/users_manager.dart' show UserManager;
import 'package:brn_ecommerce/models/views/home_manager.dart' show HomeManager;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContentHomeAppBar extends StatelessWidget {
  const ContentHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double iconsSize = 33;

    return SliverAppBar(
      primary: false,
      snap: true,
      floating: true,
      elevation: 10,
      shadowColor: Colors.yellow,
      backgroundColor: Colors.yellow.withAlpha(20),

      // prevents Scaffold from creating the default icon
      automaticallyImplyLeading: false,

      flexibleSpace: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Manually created Drawer icon
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      if (context.read<UserManager>().isLoggedIn) {
                        Navigator.pushNamed(context, RoutesNavigator.cartScreen);
                      } else {
                        Navigator.pushNamed(context, RoutesNavigator.loginScreen);
                      }
                    },
                    icon: Consumer<UserManager>(
                      builder: (_, userManager, __) {
                        return userManager.isLoggedIn
                            ? Icon(Icons.shopping_cart, size: iconsSize)
                            : Icon(Icons.account_circle, size: iconsSize);
                      },
                    ),
                  ),
                  Consumer2<UserManager, HomeManager>(
                    builder: (_, userManager, homeManager, __) {
                      if (userManager.adminEnable && !homeManager.loading) {
                        return homeManager.editing
                            ? PopupMenuButton(
                                onSelected: (e) {
                                  if (e == 'Salvar') {
                                    homeManager.saveEditing();
                                  } else {
                                    homeManager.discardEditing();
                                  }
                                },
                                itemBuilder: (_) {
                                  return ['Salvar', 'Descartar'].map((e) {
                                    return PopupMenuItem(
                                      value: e,
                                      child: Text(e),
                                    );
                                  }).toList();
                                },
                              )
                            : IconButton(
                                icon: Icon(Icons.edit, size: iconsSize),
                                onPressed: homeManager.enterEditing,
                              );
                      } else {
                        return const SizedBox();
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
