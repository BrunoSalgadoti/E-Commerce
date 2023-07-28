import 'package:brn_ecommerce/helpers/app_providers.dart';
import 'package:brn_ecommerce/models/version_manager.dart';
import 'package:brn_ecommerce/my_app.dart';
import 'package:brn_ecommerce/services/db_api/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configured with the FlutterFire CLI
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Load version information asynchronously
  if (!kReleaseMode) {
    // This code snippet will only run in debug mode
    final versionManager = VersionManager();
    await versionManager.updateVersionInfo();
  }

  // configure routing based on "history-based routing"
  setPathUrlStrategy();

  runApp(
    const AppProviders(
      child: MyApp(),
    ),
  );
}
