import 'package:brn_ecommerce/common/drawer/components/page_manager.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/views/admin_orders/admin_orders_screen.dart';
import 'package:brn_ecommerce/views/admin_settings/components/outdoor_admin_screen.dart';
import 'package:brn_ecommerce/views/admin_users/admin_users_screen.dart';
import 'package:brn_ecommerce/views/favorites/favorites_screen.dart';
import 'package:brn_ecommerce/views/home/home_screen.dart';
import 'package:brn_ecommerce/views/orders/orders_screen.dart';
import 'package:brn_ecommerce/views/product_categories/categories_screen.dart';
import 'package:brn_ecommerce/views/products/products_screen.dart' show ProductsScreen;
import 'package:brn_ecommerce/views/stores/stores_screen.dart';
import 'package:brn_ecommerce/views/who_we_are/who_we_are_screen.dart';
import 'package:brn_ecommerce/views/wish_list/wish_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerPageView extends StatelessWidget {
  const DrawerPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageManager = context.watch<PageManager>();
    final userManager = context.watch<UserManager>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageManager.pageController.hasClients) {
        pageManager.pageController.jumpToPage(
          pageManager.currentPage.index,
        );
      }
    });

    return PageView(
      controller: pageManager.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const HomeScreen(),             // 0
        const CategoriesScreen(),       // 1
        const OrdersScreen(),           // 2
        const FavoritesScreen(),        // 3
        const WishList(),               // 4
        const StoresScreen(),           // 5
        const WhoWeAreScreen(),         // 6
        userManager.adminEnable
            ? const AdminUsersScreen()
            : const SizedBox.shrink(), // 7
        userManager.adminEnable
            ? const AdminOrdersScreen()
            : const SizedBox.shrink(), // 8
        userManager.adminEnable
            ? const ProductsScreen()
            : const SizedBox.shrink(), // 9
        userManager.adminEnable
            ? const OutdoorAdminScreen()
            : const SizedBox.shrink(), // 10
      ],
    );
  }
}
