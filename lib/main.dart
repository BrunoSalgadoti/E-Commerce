import 'package:ecommerce/models/db_api/FirebaseApiWeb.dart';
import 'package:ecommerce/models/users_manager.dart';
import 'package:ecommerce/screens/base/base_screen.dart';
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
  runApp(const MyApp());

// Inicializando o Firebase APP e WEB
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp( options:
     FirebaseOptions(
      apiKey: FirebaseApiWeb().ApiKey,
      appId: FirebaseApiWeb().AppId,
      messagingSenderId: FirebaseApiWeb().SenderId,
      projectId: FirebaseApiWeb().ProjectId,
    ));
  } else {
    await Firebase.initializeApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return Provider(
      create: (_) => UserManager(),
      child: MaterialApp(
        title: 'Loja Virtual BRN-Info_Dev',

        theme: temaPadrao,

        home: BaseScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}