import 'package:brn_ecommerce/common/advertising/components/products_recently_added.dart';
import 'package:brn_ecommerce/common/advertising/components/products_best_selling.dart';
import 'package:brn_ecommerce/common/drawer/components/page_manager.dart';
import 'package:brn_ecommerce/models/admin_area/admin_orders_manager.dart';
import 'package:brn_ecommerce/models/admin_area/admin_users_manager.dart';
import 'package:brn_ecommerce/models/admin_area/admin_users_search.dart';
import 'package:brn_ecommerce/models/favorites/favorites_manager.dart';
import 'package:brn_ecommerce/models/policy_documents/policy_and_documents.dart';
import 'package:brn_ecommerce/models/products/categories/product_category.dart';
import 'package:brn_ecommerce/models/products/categories/product_category_manager.dart';
import 'package:brn_ecommerce/models/products/details_products.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:brn_ecommerce/models/sales/cart_manager.dart';
import 'package:brn_ecommerce/models/sales/checkout_manager.dart';
import 'package:brn_ecommerce/models/sales/orders_manager.dart';
import 'package:brn_ecommerce/models/sections_home/home_manager.dart';
import 'package:brn_ecommerce/models/stores/stores.dart';
import 'package:brn_ecommerce/models/stores/stores_manager.dart';
import 'package:brn_ecommerce/models/users/users.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/models/who_we_are/who_we_are_manager.dart';
import 'package:brn_ecommerce/services/config/version_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// # Application Providers (Folder: helpers)
/// A provider class that initializes and manages multiple ChangeNotifierProvider instances.
///
/// This class is responsible for setting up and managing various providers for different parts of the application.
class ProvidersApp extends StatelessWidget {
  /// The main child widget of the application.
  final Widget child;

  /// Constructs a new instance of AppProviders with the specified parameters.
  ///
  /// The [child] parameter is required and represents the main child widget.
  const ProvidersApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Providers for User and Authentication
        ChangeNotifierProvider(create: (_) => UserManager(), lazy: false),

        // Providers for Products and Product Management
        ChangeNotifierProvider(create: (_) => PageManager(), lazy: false),
        ChangeNotifierProvider(create: (_) => Product()),
        ChangeNotifierProvider(create: (_) => ProductManager(), lazy: false),
        ChangeNotifierProvider(create: (_) => ProductCategory()),
        ChangeNotifierProvider(create: (_) => DetailsProducts(stock: 0)),
        ChangeNotifierProvider<CartManager>.value(value: CartManager.instance),
        ChangeNotifierProvider(
          create: (context) => FavoritesManager(
            userManager: context.read<UserManager>(),
          ),
        ),

        // Providers for App Data and Settings
        ChangeNotifierProvider(create: (_) => WhoWeAreManager()),
        ChangeNotifierProvider(create: (_) => PolicyAndDocuments()),
        ChangeNotifierProvider(create: (_) => HomeManager()),
        ChangeNotifierProvider(create: (_) => VersionManager()),
        ChangeNotifierProvider(create: (_) => AdminUsersSearch()),
        ChangeNotifierProvider(create: (_) => Stores()),
        ChangeNotifierProvider(create: (_) => StoresManager()),

        // Proxy Providers for managing dependencies between providers
        ChangeNotifierProxyProvider<UserManager, ProductCategoryManager>(
          lazy: false,
          create: (_) => ProductCategoryManager(),
          update: (_, userManager, productCategoryManager) =>
              productCategoryManager!..verifyUser(userManager),
        ),
        ChangeNotifierProxyProvider<ProductManager, ProductsBestSelling>(
          create: (context) => ProductsBestSelling(
            allProducts: context.read<ProductManager>().allProducts,
          ),
          update: (context, productManager, _) {
            return ProductsBestSelling(
              allProducts: productManager.allProducts,
            );
          },
        ),
        ChangeNotifierProxyProvider2<ProductManager, ProductCategory?, ProductsRecentlyAdded>(
          create: (context) => ProductsRecentlyAdded(
            allProducts: context.read<ProductManager>().allProducts,
          ),
          update: (context, productManager, productCategory, previous) {
            final instance =
                previous ?? ProductsRecentlyAdded(allProducts: productManager.allProducts);
            instance.updateRecentProducts(productCategory: productCategory);
            return instance;
          },
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          lazy: false,
          create: (_) => CartManager.instance,
          update: (_, userManager, cartManager) => cartManager!..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          lazy: false,
          create: (_) => OrdersManager(),
          update: (_, userManager, ordersManager) =>
              ordersManager!..updateUser(userManager.users ?? Users(email: "")),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          lazy: false,
          create: (_) => AdminUsersManager(),
          update: (_, userManager, adminUsersManager) =>
              adminUsersManager!..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
          lazy: false,
          create: (_) => AdminOrdersManager(),
          update: (_, userManager, adminOrdersManager) =>
              adminOrdersManager!..updateAdmin(adminEnable: userManager.adminEnable),
        ),
        ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
          lazy: false,
          create: (_) => CheckoutManager(),
          update: (_, cartManager, checkoutManager) => checkoutManager!..updateCart(cartManager),
        ),
      ],
      child: child,
    );
  }
}
