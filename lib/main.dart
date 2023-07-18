import 'package:brn_ecommerce/helpers/app_providers.dart';
import 'package:brn_ecommerce/models/version_manager.dart';
import 'package:brn_ecommerce/my_app.dart';
import 'package:brn_ecommerce/services/db_api/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configurado com o FlutterFire CLI
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Carrega as informações de versão assincronamente
  final versionManager = VersionManager();
  await versionManager.updateVersionInfo();

  runApp(
    const AppProviders(
      child: MyApp(),
    ),
  );
}
