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
import 'package:brn_ecommerce/models/users/users.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/models/views/home_manager.dart';
import 'package:brn_ecommerce/models/views/policy_and_documents.dart';
import 'package:brn_ecommerce/models/views/stores.dart';
import 'package:brn_ecommerce/models/views/stores_manager.dart';
import 'package:brn_ecommerce/models/views/who_we_are_manager.dart';
import 'package:brn_ecommerce/services/config/version_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// # Application Providers (Folder: helpers)
/// A provider class that initializes and manages multiple ChangeNotifierProvider instances.
///
/// This class is responsible for setting up and managing various providers for different parts of the application.
class AppProviders extends StatelessWidget {
  /// The main child widget of the application.
  final Widget child;

  /// Constructs a new instance of AppProviders with the specified parameters.
  ///
  /// The [child] parameter is required and represents the main child widget.
  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Providers for User and Authentication
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),

        // Providers for Products and Product Management
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

        // Providers for App Data and Settings
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

        // Proxy Providers for managing dependencies between providers
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
