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
import 'package:brn_ecommerce/views/login_sing_up_screens/components/recover_password_screen.dart';
import 'package:brn_ecommerce/views/login_sing_up_screens/components/reset_password_screen.dart';
import 'package:brn_ecommerce/views/login_sing_up_screens/components/verify_email_screen.dart';
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
        return MaterialPageRoute(builder: (_) => LoginScreen(), settings: settings);
      case RoutesNavigator.signupScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case RoutesNavigator.cartScreen:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case RoutesNavigator.ordersClientScreen:
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      case RoutesNavigator.categoryProductsScreen:
        return MaterialPageRoute(
          builder: (_) => CategoryProductScreen(
              productCategory: settings.arguments as ProductCategory? ?? ProductCategory()),
        );
      case RoutesNavigator.resetPasswordScreen:
        final resetArgs = settings.arguments as Map<String, dynamic>?;
        final resetOobCode = resetArgs?['oobCode'] as String?;
        if (resetOobCode != null && resetOobCode.isNotEmpty) {
          return MaterialPageRoute(
            builder: (_) => ResetPasswordScreen(oobCode: resetOobCode),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text(
                  'Código de redefinição inválido ou ausente',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              ),
            ),
          );
        }
      case RoutesNavigator.recoverPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => const RecoverPasswordScreen(),
          settings: settings,
        );
      case RoutesNavigator.verifyEmailScreen:
        final verifyArgs = settings.arguments as Map<String, dynamic>?;
        final verifyOobCode = verifyArgs?['oobCode'] as String?;
        if (verifyOobCode != null && verifyOobCode.isNotEmpty) {
          return MaterialPageRoute(
            builder: (_) => VerifyEmailScreen(oobCode: verifyOobCode),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text(
                  'Código de verificação inválido ou ausente',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              ),
            ),
          );
        }
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
}
