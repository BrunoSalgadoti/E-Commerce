import 'package:brn_ecommerce/helpers/app_providers.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/my_app.dart';
import 'package:brn_ecommerce/services/config/debug_mode_and_first_start.dart';
import 'package:brn_ecommerce/services/config/firebase_automated_maps_update.dart';
import 'package:brn_ecommerce/services/db_api/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

import 'services/development_monitoring/firebase_performance.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Configured with the FlutterFire CLI
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  PerformanceMonitoring().startTrace('main', shouldStart: true);

  if (!kReleaseMode) {
    bool shouldStart = false; ///<- Change it! Only if you need to update
    /// Automatic fields in all documents of a class! (Default: false)

    /// This code snippet will only run in debug mode and
    /// Some functions of this class are only activated if firstStart == true
    debugModeAndFirstStart(firstStart: false);

    ///ATTENTION: See the documentation within the class
    ///to understand how it works!
    ///CAUTION: Understand the functionality before setting the
    ///variable to true.
    // This code snippet will only run in debug mode and
    // with the variable shouldStart == true
    if (shouldStart == false) { /// <- Don´t Change it!
      Product product = Product();
      FirebaseAutomatedMapsUpdate<Product>(
        collectionPath: 'products',
        toMap: (T) => T.toMap(),
      ).updateDocument(product);
    }
  }

  /// configure routing based on "history-based routing"
  setPathUrlStrategy();

  runApp(
    const AppProviders(
      child: MyApp(),
    ),
  );
  PerformanceMonitoring().stopTrace('main');
}
