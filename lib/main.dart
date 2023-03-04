import 'package:ecommerce/helpers/route_generator.dart';
import 'package:ecommerce/models/cart_manager.dart';
import 'package:ecommerce/models/db_api/firebase_api_web.dart';
import 'package:ecommerce/models/product_manager.dart';
import 'package:ecommerce/models/users_manager.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:core';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

 final  ThemeData temaPadrao = ThemeData(
    primaryColor: const Color.fromARGB(255, 4, 125, 141),
    scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme:const AppBarTheme (
      backgroundColor: Color.fromARGB(255, 4, 125, 141),
      elevation: 0,
    ));


 Future<void> main() async {
   // Inicializando o Firebase APP e WEB
   WidgetsFlutterBinding.ensureInitialized();

   if (kIsWeb) {
     await Firebase.initializeApp( options:
     FirebaseOptions(
       apiKey: FirebaseApiWeb().apiKey,
       appId: FirebaseApiWeb().appId,
       messagingSenderId: FirebaseApiWeb().senderId,
       projectId: FirebaseApiWeb().projectId,
     ));
   } else {
     await Firebase.initializeApp();
   }

   runApp(MultiProvider(
     providers: [
       ChangeNotifierProvider(
         create:(_) => UserManager(),
         lazy: false,
       ),
       ChangeNotifierProvider(
         create: (_) => ProductManager(),
         lazy: false,
       ),
       ChangeNotifierProxyProvider<UserManager, CartManager>(
         create: (_) => CartManager(),
         update: (_, userManager, cartManager) =>
             CartManager()..updateUser(userManager),
         lazy: false,
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