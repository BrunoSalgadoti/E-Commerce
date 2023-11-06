import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionManager extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late PackageInfo _packageInfo;
  bool compatibleVersion = false;

  Future<void> _initPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

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
      // Error occurred while checking version, assume it's outdated
      compatibleVersion = false;
    }

    PerformanceMonitoring().stopTrace('checkVersion');

    return compatibleVersion;
  }

  Future<void> updateVersionInfo() async {
    if (!kReleaseMode) {
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
