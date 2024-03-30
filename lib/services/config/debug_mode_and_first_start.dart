import 'package:brn_ecommerce/models/categories_of_products/product_category_manager.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:brn_ecommerce/models/version_manager.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// Performs specific operations during debug mode and on first start of the application.
///
/// This function is designed to be used during application development.
/// It performs operations that may only be useful in the debug environment,
/// such as updating version information and creating auxiliary tables.
///
/// [firstStart] - Indicates whether this is the first start of the application.
Future<void> debugModeAndFirstStart({required bool firstStart}) async {
  if (!kReleaseMode) {
    /// Updates the application version information.
    // This code snippet will only run in debug mode
    final versionManager = VersionManager();
    await versionManager.updateVersionInfo();

    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    ///Exemple of make a first error: for testing framework to Crashlytics:
    // TextButton(
    //   onPressed: () => throw Exception(),
    //   child: const Text("Throw Test Exception"),
    // );

    ///Creation of Auxiliary Tables
    ///
    /// In this part of the code, auxiliary tables, such as sales tables and
    /// administration, are created during the first start of the application. These tables
    /// can be used for application-specific functionality and are defined
    /// by the developer.
    ///
    /// IMPORTANT: This part of the code must be executed carefully, as it creates tables
    /// in Firestore that are not directly modified by users. Modifications
    /// further details on these tables should only be done by the developer, taking into account
    /// consideration of the impact on the application's functionalities.

    /// Create auxiliary user and administrator tables if they do not exist
    /// during the first application start.
    /// CASE: [firstStart = true] - in main.dart.
    // This code snippet will only run in debug mode and case [firstStart = true]
    // - in main.dart
    UserManager().createAuxAndAdminsIfNotExists(firstStart: firstStart);

    /// Create or update product categories in Firestore during first launch
    /// of the application or expressly requested by the Online Store Owner.
    /// CASO:  [firstStart = true] - no main.dart.
    // This code snippet will only run in debug mode and case [firstStart = true]
    // - in main.dart
    ProductCategoryManager().createProductCategoriesIfNotExists(firstStart: firstStart);
  }
}
