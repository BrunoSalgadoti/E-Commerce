import 'package:brn_ecommerce/common/buttons/custom_icon_button.dart';
import 'package:brn_ecommerce/common/drawer/components/drawer_pages_enum.dart';
import 'package:brn_ecommerce/common/drawer/components/page_manager.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart' show RoutesNavigator;
import 'package:brn_ecommerce/models/sections_home/home_manager.dart' show HomeManager;
import 'package:brn_ecommerce/models/users/users_manager.dart' show UserManager;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ContentHomeAppBar extends StatelessWidget {
  const ContentHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double iconsSize = 33;
    final goToPage = context.read<PageManager>();
    final userIsLoggedIn = context.watch<UserManager>().isLoggedIn;
    final getUsers = context.watch<UserManager>();

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
              CustomIconButton(
                iconData: Icons.menu,
                semanticLabel: 'Ícone do Drawer',
                size: iconsSize,
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconButton(
                      iconData: FontAwesomeIcons.heartPulse,
                      semanticLabel: 'Meus Desejos',
                      color: Colors.red,
                      size: iconsSize,
                      onTap: () => goToPage.setPage(DrawerPages.wishlist)),
                  CustomIconButton(
                      iconData: Icons.favorite,
                      semanticLabel: 'Meus Favoritos',
                      color: Colors.red,
                      size: iconsSize,
                      onTap: () => goToPage.setPage(DrawerPages.favorites)),
                  CustomIconButton(
                    iconData: userIsLoggedIn ? Icons.shopping_cart : Icons.account_circle,
                    size: iconsSize,
                    semanticLabel: 'Login ou Cart Logo',
                    onTap: () => userIsLoggedIn
                        ? Navigator.pushNamed(context, RoutesNavigator.cartScreen)
                        : Navigator.pushNamed(context, RoutesNavigator.loginScreen),
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
                            : CustomIconButton(
                                iconData: Icons.edit,
                                size: iconsSize,
                                semanticLabel: 'Editar Tela',
                                onTap: homeManager.enterEditing,
                              );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  userIsLoggedIn
                      ? // User avatar
                      getUsers.users?.userPhotoURL == null || getUsers.users?.userPhotoURL == ''
                          ? CircleAvatar(
                              backgroundImage: AssetImage(RootAssets.iconUserNoImage),
                            )
                          : CircleAvatar(
                              backgroundImage: NetworkImage(getUsers.users?.userPhotoURL ?? ''))
                      : Container()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
