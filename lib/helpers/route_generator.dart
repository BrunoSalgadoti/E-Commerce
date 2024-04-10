import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/products/categories/product_category.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/sales/order_client.dart';
import 'package:brn_ecommerce/models/views/stores.dart';
import 'package:brn_ecommerce/views/address/address_screen.dart';
import 'package:brn_ecommerce/views/base/base_screen.dart';
import 'package:brn_ecommerce/views/cart/cart_screen.dart';
import 'package:brn_ecommerce/views/checkout/checkout_screen.dart';
import 'package:brn_ecommerce/views/home/splash_screen.dart';
import 'package:brn_ecommerce/views/login/login_screen.dart';
import 'package:brn_ecommerce/views/policy_and_documents/components/terms_and_privacy_text_screen.dart';
import 'package:brn_ecommerce/views/product_categories/category_product_screen.dart';
import 'package:brn_ecommerce/views/product_details/product_details_screen.dart';
import 'package:brn_ecommerce/views/product_edit/edit_product_screen.dart';
import 'package:brn_ecommerce/views/product_selected/selected_product_screen.dart';
import 'package:brn_ecommerce/views/products/products_screen.dart';
import 'package:brn_ecommerce/views/products_share/share_product_screen.dart';
import 'package:brn_ecommerce/views/sales_confirmation/sales_confirmation_screen.dart';
import 'package:brn_ecommerce/views/sign_up/sign_up_screen.dart';
import 'package:brn_ecommerce/views/stores_edit/edit_stores_screen.dart';
import 'package:flutter/material.dart';

/// # Route Generator (Folder: helpers).
/// A class responsible for generating routes based on route settings.
///
/// The [RouteGenerator] class provides a static method [generateRoute] to handle route generation
/// based on the route settings provided.
class RouteGenerator {
  /// Generates a route based on the given route settings.
  ///
  /// The [generateRoute] method switches between different route names and returns corresponding
  /// MaterialPageRoute instances for each route.
  ///
  /// For example:
  /// * "/login" route leads to the [LoginScreen].
  /// * "/signup" route leads to the [SignUpScreen].
  /// * "/cart" route leads to the [CartScreen].
  /// * "/category_screen" route leads to the [CategoryProductScreen].
  /// * "/product_screen" route leads to the [ProductsScreen].
  /// * "/product" route leads to the [ProductDetailsScreen].
  /// * "/share_product" route leads to the [ShareProductScreen].
  /// * "/edit_product" route leads to the [EditProductScreen].
  /// * "/edit_stores" route leads to the [EditStoresScreen].
  /// * "/select_product" route leads to the [SelectProductScreen].
  /// * "/privacy_policy" route leads to the [TermsAndPrivacyTextScreen].
  /// * "/address" route leads to the [AddressScreen].
  /// * "/checkout" route leads to the [CheckoutScreen].
  /// * "/sales_confirmation" route leads to the [SalesConfirmationScreen].
  /// * "/home" route leads to the [BaseScreen].
  /// * "/" or unknown routes lead to the [SplashScreen].
  ///
  /// The [settings] parameter represents the route settings used to determine the route to generate.
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    //TODO: Rotas ativas em fase de transição:

    switch (settings.name) {
      case routesNavigator.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case routesNavigator.signupScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case routesNavigator.cartScreen:
        return MaterialPageRoute(builder: (_) => const CartScreen(), settings: settings);
      case routesNavigator.categoryProductsScreen:
        return MaterialPageRoute(
            builder: (_) => CategoryProductScreen(
                productCategory: settings.arguments as ProductCategory? ?? ProductCategory()),
            settings: settings);

        //TODO: Capturar link do produto para compartilhamento
      case routesNavigator.productScreen:
        return MaterialPageRoute(builder: (_) =>  const ProductsScreen(), settings: settings);
      case routesNavigator.productDetailsScreen:
        return MaterialPageRoute(
            builder: (_) =>
                ProductDetailsScreen(product: settings.arguments as Product? ?? Product()),
            settings: settings);
      case routesNavigator.shareProductScreen:
        return MaterialPageRoute(
            builder: (_) => ShareProductScreen(product: settings.arguments as Product));
      case routesNavigator.editProductScreen:
        return MaterialPageRoute(
            builder: (_) => EditProductScreen(
                product: settings.arguments != null
                    ? settings.arguments as Product
                    : Product().cloneProduct()));
      case routesNavigator.editStoresScreen:
        return MaterialPageRoute(
            builder: (_) => EditStoresScreen(store: settings.arguments as Stores? ?? Stores()));
      case routesNavigator.selectProductScreen:
        return MaterialPageRoute(builder: (_) => const SelectProductScreen());
      case routesNavigator.privacyAndPolicyScreen:
        return MaterialPageRoute(
            builder: (_) => TermsAndPrivacyTextScreen(content: settings.arguments as String));
      case routesNavigator.addressScreen:
        return MaterialPageRoute(builder: (_) => const AddressScreen());
      case routesNavigator.checkoutScreen:
        return MaterialPageRoute(builder: (_) => CheckoutScreen());
      case routesNavigator.salesConfirmationScreen:
        return MaterialPageRoute(
            builder: (_) => SalesConfirmationScreen(settings.arguments as OrderClient));
      case routesNavigator.homeScreen:
        return MaterialPageRoute(builder: (_) => const BaseScreen());
      case routesNavigator.rootScreen:
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
