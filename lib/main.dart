import 'package:ecommerce/helpers/route_generator.dart';
import 'package:ecommerce/models/admin_orders_manager.dart';
import 'package:ecommerce/models/admin_users_manager.dart';
import 'package:ecommerce/models/admin_users_search.dart';
import 'package:ecommerce/models/cart_manager.dart';
import 'package:ecommerce/models/home_manager.dart';
import 'package:ecommerce/models/orders_manager.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/product_manager.dart';
import 'package:ecommerce/models/users.dart';
import 'package:ecommerce/models/users_manager.dart';
import 'dart:core';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/db_api/firebase_options.dart';

 final  ThemeData temaPadrao = ThemeData(
    primaryColor: const Color.fromARGB(255, 4, 125, 141),
    scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme:const AppBarTheme (
      backgroundColor: Color.fromARGB(255, 4, 125, 141),
      elevation: 0,
    ));


 Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();

   //Configurado com o FlutterFire CLI
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );

   runApp(MultiProvider(
     providers: [
       ChangeNotifierProvider(
         create:(_) => UserManager(),
         lazy: false,
       ),
       ChangeNotifierProvider(
         create:(_) => Product(),
       ),
       ChangeNotifierProvider(
         create: (_) => ProductManager(),
       ),
       ChangeNotifierProvider(
         create: (_) => HomeManager(),
         lazy: false,
       ),
       ChangeNotifierProvider(
         create: (_) => AdminUsersSearch(),
       ),
       ChangeNotifierProxyProvider<UserManager, CartManager>(
         create: (_) => CartManager(),
         update: (_, userManager, cartManager) =>
             cartManager!..updateUser(userManager),
       ),
       ChangeNotifierProxyProvider<UserManager, OrdersManager>(
         create: (_) => OrdersManager(),
         lazy: false,
         update: (_, userManager, ordersManager) =>
         ordersManager!..updateUser(userManager.users ?? Users(email: '')),
       ),
       ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
         create: (_) => AdminUsersManager(),
         update: (_, userManager, adminUsersManager) =>
         adminUsersManager!..updateUser(userManager),
       ),
       ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
         create: (_) => AdminOrdersManager(),
         update: (_, userManager, adminOrdersManager) =>
         adminOrdersManager!..updateAdmin(
             adminEnable: userManager.adminEnable
         ),
       ),
     ],
     child: const MyApp())
   );
 }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Loja Virtual BRN-Info_Dev',

        theme: temaPadrao,

      initialRoute: "/base",
      onGenerateRoute: RouteGenerator.generateRoute,

        debugShowCheckedModeBanner: false,
      );
  }
}