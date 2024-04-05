import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// # VersionManager (Folder: services/config)
///
/// A class responsible for managing the app version and checking compatibility.
class VersionManager extends ChangeNotifier {
  // Proprieties

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late PackageInfo _packageInfo;
  bool compatibleVersion = false;

  // Methods

  /// Initializes the package info from the platform.
  Future<void> _initPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  /// Checks the current app version against the stored version in Firestore.
  ///
  /// Returns `true` if the app version and build number match the stored values,
  /// indicating that the version is up-to-date. Otherwise, returns `false`.
  Future<bool> checkVersion() async {
    PerformanceMonitoring().startTrace('checkVersion', shouldStart: true);

    _initPackageInfo();
    try {
      final versionDoc = await firestore.collection('versionApp').doc('currentVersion').get();
      if (versionDoc.exists) {
        final storedVersion = versionDoc.data();
        final appVersion = _packageInfo.version;
        final buildNumber = _packageInfo.buildNumber;
        final storedAppVersion = storedVersion?['appVersion'] as String?;
        final storedBuildNumber = storedVersion?['buildNumber'] as String?;

        // Compare appVersion and buildNumber with stored values
        if (appVersion == storedAppVersion && buildNumber == storedBuildNumber) {
          // Version is up-to-date
          compatibleVersion = true;
        } else {
          // Version is outdated
          compatibleVersion = false;
        }
      } else {
        // Version document doesn't exist, assume it's outdated
        compatibleVersion = false;
      }
    } catch (error) {
      //TODO: tratar erro para exibir ao usuário
      // Error occurred while checking version, assume it's outdated
      compatibleVersion = false;
    }

    PerformanceMonitoring().stopTrace('checkVersion');

    return compatibleVersion;
  }

  /// Updates the version information in Firestore (debug mode only).
  Future<void> updateVersionInfo() async {
    if (kDebugMode) {
      await _initPackageInfo();
      final appVersion = _packageInfo.version;
      final buildNumber = _packageInfo.buildNumber;

      final versionData = {
        'appVersion': appVersion,
        'buildNumber': buildNumber,
      };

      await firestore.collection('versionApp').doc('currentVersion').set(versionData);
    }
  }
}
