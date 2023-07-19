import 'package:brn_ecommerce/models/order_client.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/screens/address/address_screen.dart';
import 'package:brn_ecommerce/screens/base/base_screen.dart';
import 'package:brn_ecommerce/screens/cart/cart_screen.dart';
import 'package:brn_ecommerce/screens/checkout/checkout_screen.dart';
import 'package:brn_ecommerce/screens/edit_product/edit_product_screen.dart';
import 'package:brn_ecommerce/screens/login/login_screen.dart';
import 'package:brn_ecommerce/screens/policy_and_documents/components/terms_and_privacy_text_screen.dart';
import 'package:brn_ecommerce/screens/product_details/product_details_screen.dart';
import 'package:brn_ecommerce/screens/products/components/share_product_screen.dart';
import 'package:brn_ecommerce/screens/sales_confirmation/sales_confirmation_screen.dart';
import 'package:brn_ecommerce/screens/select_product/selected_product_screen.dart';
import 'package:brn_ecommerce/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case "/signup":
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case "/cart":
        return MaterialPageRoute(
            builder: (_) => const CartScreen(), settings: settings);
      case "/product":
        return MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(
                  product: settings.arguments as Product,
                ),
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
      case '/select_product':
        return MaterialPageRoute(builder: (_) => const SelectProductScreen());
      case '/privacy_policy':
        return MaterialPageRoute(
            builder: (_) => TermsAndPrivacyTextScreen(
                content: settings.arguments as String));
      case "/address":
        return MaterialPageRoute(builder: (_) => const AddressScreen());
      case "/checkout":
        return MaterialPageRoute(builder: (_) => const CheckoutScreen());
      case "/sales_confirmation":
        return MaterialPageRoute(
            builder: (_) => SalesConfirmationScreen(
                  settings.arguments as OrderClient,
                ));
      case "/":
      default:
        return MaterialPageRoute(
            builder: (_) => const BaseScreen(), settings: settings);
    }
  }
}
