import 'package:brn_ecommerce/models/admin_orders_manager.dart';
import 'package:brn_ecommerce/models/admin_users_manager.dart';
import 'package:brn_ecommerce/models/admin_users_search.dart';
import 'package:brn_ecommerce/models/cart_manager.dart';
import 'package:brn_ecommerce/models/details_products.dart';
import 'package:brn_ecommerce/models/home_manager.dart';
import 'package:brn_ecommerce/models/orders_manager.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/models/product_manager.dart';
import 'package:brn_ecommerce/models/users.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:brn_ecommerce/models/who_we_are_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => Product(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => DetailsProducts(stock: 0),
        ),
        ChangeNotifierProvider(
          create: (_) => WhoWeAreManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => AdminUsersSearch(),
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          update: (_, userManager, cartManager) =>
              cartManager!..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          create: (_) => OrdersManager(),
          lazy: false,
          update: (_, userManager, ordersManager) =>
              ordersManager!..updateUser(userManager.users ?? Users(email: '')),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          update: (_, userManager, adminUsersManager) =>
              adminUsersManager!..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
          create: (_) => AdminOrdersManager(),
          update: (_, userManager, adminOrdersManager) => adminOrdersManager!
            ..updateAdmin(adminEnable: userManager.adminEnable),
        ),
      ],
      child: child,
    );
  }
}
