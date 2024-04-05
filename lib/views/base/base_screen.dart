import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/models/views/page_manager.dart';
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

class BaseScreen extends StatefulWidget {
  const BaseScreen({
    super.key,
  });

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return PageView(
            controller: pageController,
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
              ]
            ],
          );
        },
      ),
    );
  }
}
