import 'dart:io';

import 'package:brn_ecommerce/helpers/themes/themes.dart';
import 'package:brn_ecommerce/helpers/app_providers.dart';
import 'package:brn_ecommerce/helpers/route_generator.dart';
import 'package:brn_ecommerce/services/db_api/firebase_options.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Configurado com o FlutterFire CLI
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const AppProviders(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loja Virtual BRN-Info_Dev',
      theme: _getThemeData(context),
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData _getThemeData(BuildContext context) {
    final themes = Themes();

    if (kIsWeb) {
      return themes.themeWeb;
    } else if (Platform.isAndroid) {
      return themes.themeAndroid;
    } else if (Platform.isIOS) {
      return themes.themeIos;
    } else {
      // Fallback theme
      return ThemeData.light();
    }
  }
}
