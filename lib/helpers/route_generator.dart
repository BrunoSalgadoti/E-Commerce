import 'package:brn_ecommerce/common/drawer/components/drawer_page_view.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/products/categories/product_category.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/sales/order_client.dart';
import 'package:brn_ecommerce/models/stores/stores.dart';
import 'package:brn_ecommerce/views/address/address_screen.dart';
import 'package:brn_ecommerce/views/cart/cart_screen.dart';
import 'package:brn_ecommerce/views/checkout/checkout_screen.dart';
import 'package:brn_ecommerce/views/home/splash_screen.dart';
import 'package:brn_ecommerce/views/login_sing_up_screens/login_screen.dart';
import 'package:brn_ecommerce/views/login_sing_up_screens/sign_up_screen.dart';
import 'package:brn_ecommerce/views/orders/orders_screen.dart';
import 'package:brn_ecommerce/views/policy_and_documents/components/terms_and_privacy_text_screen.dart';
import 'package:brn_ecommerce/views/product_categories/category_product_screen.dart';
import 'package:brn_ecommerce/views/product_details/product_details_screen.dart';
import 'package:brn_ecommerce/views/product_edit/edit_product_screen.dart';
import 'package:brn_ecommerce/views/product_selected/selected_product_screen.dart';
import 'package:brn_ecommerce/views/products_share/share_product_screen.dart';
import 'package:brn_ecommerce/views/sales_confirmation/sales_confirmation_screen.dart';
import 'package:brn_ecommerce/views/stores_edit/edit_stores_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    //TODO: Rotas ativas em fase de transição:

    switch (settings.name) {
      case RoutesNavigator.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RoutesNavigator.signupScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case RoutesNavigator.cartScreen:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case RoutesNavigator.ordersClientScreen:
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      case RoutesNavigator.categoryProductsScreen:
        return MaterialPageRoute(
            builder: (_) => CategoryProductScreen(
                productCategory: settings.arguments as ProductCategory? ?? ProductCategory()));

      // TODO: Capturar link do produto para compartilhamento
      // case routesNavigator.productScreen:
      //   return MaterialPageRoute(builder: (_) => const ProductsScreen());
      case RoutesNavigator.productDetailsScreen:
        return MaterialPageRoute(
            builder: (_) =>
                ProductDetailsScreen(product: settings.arguments as Product? ?? Product()));
      case RoutesNavigator.shareProductScreen:
        return MaterialPageRoute(
            builder: (_) => ShareProductScreen(product: settings.arguments as Product));
      case RoutesNavigator.editProductScreen:
        return MaterialPageRoute(
            builder: (_) => EditProductScreen(
                product: settings.arguments != null
                    ? settings.arguments as Product
                    : Product().cloneProduct()));
      case RoutesNavigator.editStoresScreen:
        return MaterialPageRoute(
            builder: (_) => EditStoresScreen(store: settings.arguments as Stores? ?? Stores()));
      case RoutesNavigator.selectProductScreen:
        return MaterialPageRoute(builder: (_) => const SelectProductScreen());
      case RoutesNavigator.privacyAndPolicyScreen:
        return MaterialPageRoute(
            builder: (_) => TermsAndPrivacyTextScreen(content: settings.arguments as String));
      case RoutesNavigator.addressScreen:
        return MaterialPageRoute(builder: (_) => const AddressScreen());
      case RoutesNavigator.checkoutScreen:
        return MaterialPageRoute(builder: (_) => CheckoutScreen());
      case RoutesNavigator.salesConfirmationScreen:
        return MaterialPageRoute(
            builder: (_) => SalesConfirmationScreen(settings.arguments as OrderClient));
      case RoutesNavigator.homeScreen:
        return MaterialPageRoute(builder: (_) => const DrawerPageView());
      case RoutesNavigator.rootScreen:
      default:
        return MaterialPageRoute(
            builder: (_) => kIsWeb ? const DrawerPageView() : const SplashScreen());
    }
  }

//TODO: Rotas em fase de teste e implementação:

// final argumentsRoute = ModalRoute.of(context)?.settings.arguments as Map<String, List<String>>;

//   final uri = Uri.parse(settings.name!);
//   debugPrint(uri.path);
//   debugPrint(uri.queryParametersAll.toString());
//
//
//   if (uri.path == "/login") {
//     return MaterialPageRoute(builder: (_) => LoginScreen(), settings: RouteSettings(
//       arguments: uri.queryParametersAll,
//       name: settings.name
//     ));
//   }
//   else if (uri.path == "/signup") {
//     return MaterialPageRoute(builder: (_) => const SignUpScreen(), settings: RouteSettings(
//         arguments: uri.queryParametersAll,
//         name: settings.name
//     ));
//   }
//   else if (uri.path == "/cart") {
//     return MaterialPageRoute(builder: (_) => const CartScreen(), settings: RouteSettings(
//         arguments: uri.queryParametersAll,
//         name: settings.name
//     ));
//   }
//   else if (uri.path == "/product_screen") {
//   return MaterialPageRoute(builder: (_) => const CartScreen(), settings: RouteSettings(
//       arguments: uri.queryParametersAll,
//       name: settings.name
//   ));
//   }
//   else if (uri.path == "/category_screen") {
//     return MaterialPageRoute(builder: (_) => CategoryProductScreen(
//                   productCategory: settings.arguments as ProductCategory? ?? ProductCategory()), settings: RouteSettings(
//         arguments: uri.queryParametersAll,
//         name: settings.name
//     ));
//   }
//
// // -----------------------------------------------------------------------
//
//   else if (uri.path == "/product") {
//     return MaterialPageRoute(builder: (_) =>
//                     ProductDetailsScreen(product: settings.arguments as Product? ?? Product()), settings: RouteSettings(
//         arguments: uri.queryParametersAll,
//         name: settings.name
//     ));
//   }
//
// // -----------------------------------------------------------------------
//
//
//   else if (uri.path == "/share_product") {
//     return MaterialPageRoute(builder: (_) => ShareProductScreen(product: settings.arguments as Product), settings: RouteSettings(
//         arguments: uri.queryParametersAll,
//         name: settings.name
//     ));
//   }
//   else if (uri.path == "/edit_product") {
//     return MaterialPageRoute(builder: (_) => EditProductScreen(
//                   product: settings.arguments != null
//                       ? settings.arguments as Product
//                       : Product().cloneProduct()), settings: RouteSettings(
//         arguments: uri.queryParametersAll,
//         name: settings.name
//     ));
//   }
//   else if (uri.path == "/edit_stores") {
//     return MaterialPageRoute(builder: (_) => EditStoresScreen(store: settings.arguments as Stores? ?? Stores()), settings: RouteSettings(
//         arguments: uri.queryParametersAll,
//         name: settings.name
//     ));
//   }
//   else if (uri.path == "/select_product") {
//     return MaterialPageRoute(builder: (_) => const SelectProductScreen(), settings: RouteSettings(
//         arguments: uri.queryParametersAll,
//         name: settings.name
//     ));
//   }
//   else if (uri.path == "/privacy_policy") {
//     return MaterialPageRoute(builder: (_) => TermsAndPrivacyTextScreen(content: settings.arguments as String), settings: RouteSettings(
//         arguments: uri.queryParametersAll,
//         name: settings.name
//     ));
//   }
//   else if (uri.path == "/address") {
//     return MaterialPageRoute(builder: (_) => const AddressScreen(), settings: RouteSettings(
//         arguments: uri.queryParametersAll,
//         name: settings.name
//     ));
//   }
//   else if (uri.path == "/checkout") {
//     return MaterialPageRoute(builder: (_) => CheckoutScreen(), settings: RouteSettings(
//         arguments: uri.queryParametersAll,
//         name: settings.name
//     ));
//   }
//   else if (uri.path == "/sales_confirmation") {
//     return MaterialPageRoute(builder: (_) => SalesConfirmationScreen(settings.arguments as OrderClient), settings: RouteSettings(
//         arguments: uri.queryParametersAll,
//         name: settings.name
//     ));
//   }
//   else if (uri.path == "/home") {
//     return MaterialPageRoute(builder: (_) => const BaseScreen(), settings: RouteSettings(
//         arguments: uri.queryParametersAll,
//         name: settings.name
//     ));
//   }
//   // else if (settings.name?.contains("/ ") ?? false) {
//   //   return MaterialPageRoute(builder: (_) => const BaseScreen());
//   // }
//   else{
//     return MaterialPageRoute(builder: (_) => const SplashScreen());
//   }
// }
}
