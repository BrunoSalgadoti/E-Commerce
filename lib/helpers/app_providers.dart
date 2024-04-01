import 'package:brn_ecommerce/models/admin_area/admin_orders_manager.dart';
import 'package:brn_ecommerce/models/admin_area/admin_users_manager.dart';
import 'package:brn_ecommerce/models/admin_area/admin_users_search.dart';
import 'package:brn_ecommerce/models/products/categories/product_category.dart';
import 'package:brn_ecommerce/models/products/categories/product_category_manager.dart';
import 'package:brn_ecommerce/models/products/details_products.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:brn_ecommerce/models/sales/cart_manager.dart';
import 'package:brn_ecommerce/models/sales/orders_manager.dart';
import 'package:brn_ecommerce/models/screens/home_manager.dart';
import 'package:brn_ecommerce/models/screens/policy_and_documents.dart';
import 'package:brn_ecommerce/models/screens/stores.dart';
import 'package:brn_ecommerce/models/screens/stores_manager.dart';
import 'package:brn_ecommerce/models/screens/who_we_are_manager.dart';
import 'package:brn_ecommerce/models/users/users.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/services/config/version_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider(create: (_) => ProductCategory()),
        ChangeNotifierProvider(
          create: (_) => DetailsProducts(stock: 0),
        ),
        ChangeNotifierProvider(
          create: (_) => WhoWeAreManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => PolicyAndDocuments(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => VersionManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => AdminUsersSearch(),
        ),
        ChangeNotifierProvider(
          create: (_) => Stores(),
        ),
        ChangeNotifierProvider(
          create: (_) => StoresManager(),
        ),
        ChangeNotifierProxyProvider<UserManager, ProductCategoryManager>(
          create: (_) => ProductCategoryManager(),
          update: (_, userManager, productCategoryManager) =>
              productCategoryManager!..verifyUser(userManager),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          update: (_, userManager, cartManager) => cartManager!..updateUser(userManager),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          create: (_) => OrdersManager(),
          update: (_, userManager, ordersManager) =>
              ordersManager!..updateUser(userManager.users ?? Users(email: "")),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          update: (_, userManager, adminUsersManager) =>
              adminUsersManager!..updateUser(userManager),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
          create: (_) => AdminOrdersManager(),
          update: (_, userManager, adminOrdersManager) =>
              adminOrdersManager!..updateAdmin(adminEnable: userManager.adminEnable),
        ),
      ],
      child: child,
    );
  }
}
