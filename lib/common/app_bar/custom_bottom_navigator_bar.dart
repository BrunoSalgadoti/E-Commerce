import 'package:brn_ecommerce/common/drawer/components/page_manager.dart';
import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget customBottomNavigatorBar({required BuildContext context, required bool withDrawer}) {
  return BottomNavigationBar(
    backgroundColor: getCustomAppBarColorBackground(),
    showUnselectedLabels: true,
    selectedItemColor: getCustomAppBarColorIcons(),
    unselectedItemColor: getButtonColor(),
    enableFeedback: true,
    items: [
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
    ],
    onTap: (index) {
      switch (index) {
        case 0:
          withDrawer
              ? Navigator.of(context).pop()
              : navigateToPageWithDrawer(context: context, pageIndex: 2);
          break;
        case 1:
          Navigator.of(context).pushNamed(RoutesNavigator.cartScreen);
          break;
        case 2:
          //TODO or not TODO: Tela e Rota para a tela
          // Navigator.of(context).pushNamed('/favoritos');
          () => {};
        case 3:
          withDrawer
              ? context.read<PageManager>().setPage(0)
              : navigateToPageWithDrawer(context: context, pageIndex: 0);
          break;
      }
    },
  );
}
