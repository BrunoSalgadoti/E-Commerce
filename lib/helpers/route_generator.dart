import 'package:ecommerce/models/order_client.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/screens/address/address_screen.dart';
import 'package:ecommerce/screens/base/base_screen.dart';
import 'package:ecommerce/screens/cart/cart_creen.dart';
import 'package:ecommerce/screens/checkout/checkout_screen.dart';
import 'package:ecommerce/screens/edit_product/edit_product_screen.dart';
import 'package:ecommerce/screens/login/login_screen.dart';
import 'package:ecommerce/screens/product_details/product_details_screen.dart';
import 'package:ecommerce/screens/sales_confirmation/sales_confirmation_screen.dart';
import 'package:ecommerce/screens/select_product/selected_product_screen.dart';
import 'package:ecommerce/screens/sign_up/sign_up_Screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  
  static Route<dynamic>? generateRoute(RouteSettings settings){

    switch( settings.name ){

      case '/login' :
        return MaterialPageRoute(
          builder:(_) => LoginScreen(),
        );

      case '/signup' :
        return MaterialPageRoute(
          builder:(_) => SignUpScreen(),
        );

      case '/cart' :
        return MaterialPageRoute(
          builder:(_) => const CartScreen(),
          settings: settings
        );
        
      case '/product' :
        return MaterialPageRoute(
          builder:(_) => ProductDetailsScreen(
              product: settings.arguments as Product,
          ),
        );

      case '/edit_product' :
        return MaterialPageRoute(
          builder:(_) => EditProductScreen(
           product: settings.arguments != null
                ? settings.arguments as Product
                : Product().cloneProduct()
          ),
        );

      case '/select_product' :
        return MaterialPageRoute(
          builder:(_) => const SelectProductScreen(),
        );

      case '/address' :
        return MaterialPageRoute(
          builder:(_) => const AddressScreen(),
        );

      case '/checkout' :
        return MaterialPageRoute(
          builder:(_) => const CheckoutScreen(),
        );

      case '/sales_confirmation' :
        return MaterialPageRoute(
          builder:(_) => SalesConfirmationScreen(
            settings.arguments as OrderClient,
          ),
        );

    case '/base' :
      default:
      return MaterialPageRoute(
        builder:(_) => const BaseScreen(),
          settings: settings
      );
    }
  }
}