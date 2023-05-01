import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/screens/base/base_screen.dart';
import 'package:ecommerce/screens/cart/cart_creen.dart';
import 'package:ecommerce/screens/edit_product/edit_product_screen.dart';
import 'package:ecommerce/screens/login/login_screen.dart';
import 'package:ecommerce/screens/product_details/product_details_screen.dart';
import 'package:ecommerce/screens/select_product/selected_product_screen.dart';
import 'package:ecommerce/screens/sign_up/sign_up_Screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  
  static Route<dynamic>? generateRoute(RouteSettings settings){

    switch( settings.name ){

      case '/login' :
        return MaterialPageRoute(
          builder:(_) => const LoginScreen(),
        );

      case '/signup' :
        return MaterialPageRoute(
          builder:(_) => SignUpScreen(),
        );

      case '/cart' :
        return MaterialPageRoute(
          builder:(_) => const CartScreen(),
        );
        
      case '/product' :
        return MaterialPageRoute(
          builder:(_) => ProductDetailsScreen(
              product: settings.arguments as Product
          ),
        );

      case '/edit_product' :
        return MaterialPageRoute(
          builder:(_) => EditProductScreen(
           product: settings.arguments != null
                ? settings.arguments as Product
                : Product().clone()
          ),
        );

      case '/select_product' :
        return MaterialPageRoute(
          builder:(_) => const SelectProductScreen(),
        );

    case '/base' :
      default:
      return MaterialPageRoute(
        builder:(_) => BaseScreen(),
      );
    }
  }
}