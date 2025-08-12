import 'package:brn_ecommerce/common/drawer/components/page_manager.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/views/admin_orders/admin_orders_screen.dart';
import 'package:brn_ecommerce/views/admin_users/admin_users_screen.dart';
import 'package:brn_ecommerce/views/home/home_screen.dart';
import 'package:brn_ecommerce/views/orders/orders_screen.dart';
import 'package:brn_ecommerce/views/product_categories/categories_screen.dart';
import 'package:brn_ecommerce/views/products/products_screen.dart';
import 'package:brn_ecommerce/views/stores/stores_screen.dart';
import 'package:brn_ecommerce/views/who_we_are/who_we_are_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerPageView extends StatelessWidget {
  const DrawerPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageManager = context.watch<PageManager>();
    final userManager = context.watch<UserManager>();

    // garante que, caso o pageManager.page tenha um valor não zero
    // e o controller ainda não esteja com clients, tentamos sincronizar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageManager.pageController.hasClients) {
        pageManager.pageController.jumpToPage(pageManager.page);
      }
    });

    return PageView(
      controller: pageManager.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const HomeScreen(),
        const ProductsScreen(),
        const CategoriesScreen(),
        const OrdersScreen(),
        const StoresScreen(),
        const WhoWeArePage(),
        if (userManager.adminEnable) ...[
    const AdminUsersScreen(),
    const AdminOrdersScreen(),
      ]]);
  }
}