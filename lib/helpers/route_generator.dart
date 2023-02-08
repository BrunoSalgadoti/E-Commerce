import 'package:ecommerce/screens/base/base_screen.dart';
import 'package:ecommerce/screens/login/login_screen.dart';
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

        //TODO: Detalhes de anúncios
      // case "/detalhes-anuncio" :
      //   return MaterialPageRoute(
      //     builder:(_) => DetalhesAnuncio(args),
      //   );

    case '/base' :
      default:
      return MaterialPageRoute(
        builder:(_) => const BaseScreen(),
      );
    }
  }
}