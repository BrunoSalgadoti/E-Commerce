import 'package:brn_ecommerce/common/drawer/components/page_manager.dart';
import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../drawer/components/drawer_pages_enum.dart';

Widget customBottomNavigatorBar({
  required BuildContext context,
  required bool withDrawer,
}) {
  return SizedBox(
    height: 60,
    child: Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 900),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Material(
            elevation: 15,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: getCustomAppBarColorBackground(),
              selectedItemColor: getCustomAppBarColorIcons(),
              unselectedItemColor: getButtonColor(),
              showUnselectedLabels: true,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: 'Categorias',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Carrinho',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Meus Favoritos',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.personCircleCheck),
                  label: 'Minha área',
                ),
              ],
              onTap: (index) {
                switch (index) {
                  case 0:
                    withDrawer
                        ? Navigator.of(context).pop()
                        : navigateToPageWithDrawer(
                            context: context,
                            page: DrawerPages.categories,
                          );
                    break;
                  case 1:
                    Navigator.of(context).pushNamed(RoutesNavigator.cartScreen);
                    break;
                  case 2:
                    withDrawer
                        ? context.read<PageManager>().setPage(DrawerPages.favorites)
                        : navigateToPageWithDrawer(
                            context: context,
                            page: DrawerPages.favorites,
                          );
                    break;
                  case 3:
                    withDrawer
                        ? context.read<PageManager>().setPage(DrawerPages.home)
                        : navigateToPageWithDrawer(context: context, page: DrawerPages.home);
                    break;
                  case 4:
                    //TODO: Fazer rota
                    () => {};
                    break;
                }
              },
            ),
          ),
        ),
      ),
    ),
  );
}
