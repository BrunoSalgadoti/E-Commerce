import 'package:brn_ecommerce/brn_e_commerce.dart';
import 'package:brn_ecommerce/helpers/app_providers.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/services/config/debug_mode_and_first_start.dart';
import 'package:brn_ecommerce/services/config/firebase_automated_maps_update.dart';
import 'package:brn_ecommerce/services/db_api/firebase_options.dart';
// Package device_preview installed in Dev_Dependencies
// ignore: depend_on_referenced_packages
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

import 'services/development_monitoring/firebase_performance.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Configured with the FlutterFire CLI
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  PerformanceMonitoring().startTrace('main', shouldStart: true);

  if (kDebugMode) {
    bool shouldStart = false; //<- Change it! Only if you need to update...
    /// automatic fields in all documents of a class! (Default: false)

    /// This code snippet will only run in debug mode and
    /// Some functions of this class are only activated if firstStart == true
    debugModeAndFirstStart(firstStart: false);

    ///ATTENTION: See the documentation within the class
    ///to understand how it works!
    ///CAUTION: Understand the functionality before setting the
    ///variable to true.
    // This code snippet will only run in debug mode and
    // with the variable shouldStart == true
    if (shouldStart == true) {
      // <- Don´t Change it! (Default: true)
      Product product = Product();
      FirebaseAutomatedMapsUpdate<Product>(
        collectionPath: 'products',
        toMap: (T) => T.toMap(),
      ).updateDocument(product);
    }
  }

  /// configure routing based on "history-based routing"
  /// TODO: Em fase de teste e nova implementação
  // setPathUrlStrategy();

  /// Package configuration: Device Preview
  /// "Multiple Emulators in a single Emulator, Ios, Mac, Windows, Android, Linux"
  // With a single emulator we can simulate various screen sizes, languages and other
  // screen size and font settings... (To test responsiveness)
  runApp(kDebugMode
      ? DevicePreview(
          builder: (_) => const AppProviders(child: BrnEcommerce()),
          enabled: false) // <- Change this if you won´t START...
      // ...DevicePreview for TRUE or FALSE to ENABLE or DISABLED
      : const AppProviders(child: BrnEcommerce()));

  PerformanceMonitoring().stopTrace('main');
}
