import 'package:brn_ecommerce/models/categories_of_products/product_category.dart';
import 'package:brn_ecommerce/models/order_client.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/models/stores.dart';
import 'package:brn_ecommerce/screens/address/address_screen.dart';
import 'package:brn_ecommerce/screens/base/base_screen.dart';
import 'package:brn_ecommerce/screens/cart/cart_screen.dart';
import 'package:brn_ecommerce/screens/checkout/checkout_screen.dart';
import 'package:brn_ecommerce/screens/home/splash_screen.dart';
import 'package:brn_ecommerce/screens/login/login_screen.dart';
import 'package:brn_ecommerce/screens/policy_and_documents/components/terms_and_privacy_text_screen.dart';
import 'package:brn_ecommerce/screens/product_details/product_details_screen.dart';
import 'package:brn_ecommerce/screens/product_edit/edit_product_screen.dart';
import 'package:brn_ecommerce/screens/product_selected/selected_product_screen.dart';
import 'package:brn_ecommerce/screens/products_share/share_product_screen.dart';
import 'package:brn_ecommerce/screens/sales_confirmation/sales_confirmation_screen.dart';
import 'package:brn_ecommerce/screens/sign_up/sign_up_screen.dart';
import 'package:brn_ecommerce/screens/stores_edit/edit_stores_screen.dart';
import 'package:flutter/material.dart';

import '../screens/product_categories/category_product_screen.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case "/signup":
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case "/cart":
        return MaterialPageRoute(
            builder: (_) => const CartScreen(), settings: settings);
      case "/category_screen":
        return MaterialPageRoute(
            builder: (_) => CategoryProductScreen(
                productCategory: settings.arguments as ProductCategory? ??
                    ProductCategory()),
            settings: settings);
      case "/product":
        return MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(
                product: settings.arguments as Product? ?? Product()),
            settings: settings);
      case "/share_product":
        return MaterialPageRoute(
            builder: (_) =>
                ShareProductScreen(product: settings.arguments as Product));
      case "/edit_product":
        return MaterialPageRoute(
            builder: (_) => EditProductScreen(
                product: settings.arguments != null
                    ? settings.arguments as Product
                    : Product().cloneProduct()));
      case "/edit_stores":
        return MaterialPageRoute(
            builder: (_) => EditStoresScreen(
                store: settings.arguments as Stores? ?? Stores()));
      case "/select_product":
        return MaterialPageRoute(builder: (_) => const SelectProductScreen());
      case "/privacy_policy":
        return MaterialPageRoute(
            builder: (_) => TermsAndPrivacyTextScreen(
                content: settings.arguments as String));
      case "/address":
        return MaterialPageRoute(builder: (_) => const AddressScreen());
      case "/checkout":
        return MaterialPageRoute(builder: (_) => CheckoutScreen());
      case "/sales_confirmation":
        return MaterialPageRoute(
            builder: (_) =>
                SalesConfirmationScreen(settings.arguments as OrderClient));
      case "/home":
        return MaterialPageRoute(builder: (_) => const BaseScreen());
      case "/":
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
