import 'package:brn_ecommerce/common/button/custom_button.dart';
import 'package:brn_ecommerce/common/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionManager extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late PackageInfo _packageInfo;

  Future<void> _initPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  Future<bool> _checkVersion() async {
    try {
      final versionDoc =
          await firestore.collection('versionApp').doc('currentVersion').get();
      if (versionDoc.exists) {
        final storedVersion = versionDoc.data();
        final appVersion = _packageInfo.version;
        final buildNumber = _packageInfo.buildNumber;
        final storedAppVersion = storedVersion?['appVersion'] as String?;
        final storedBuildNumber = storedVersion?['buildNumber'] as String?;

        // Compare appVersion and buildNumber with stored values
        if (appVersion == storedAppVersion &&
            buildNumber == storedBuildNumber) {
          // Version is up-to-date
          return true;
        } else {
          // Version is outdated
          return false;
        }
      } else {
        // Version document doesn't exist, assume it's outdated
        return false;
      }
    } catch (error) {
      // Error occurred while checking version, assume it's outdated
      return false;
    }
  }

  Future<void> updateVersionInfo() async {
    await _initPackageInfo();
    final appVersion = _packageInfo.version;
    final buildNumber = _packageInfo.buildNumber;

    final versionData = {
      'appVersion': appVersion,
      'buildNumber': buildNumber,
    };

    await firestore
        .collection('versionApp')
        .doc('currentVersion')
        .set(versionData);
  }

  void alertDialog({BuildContext? context}) {
    final alertDialog = showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ShowAlertDialog(
          titleText: 'Atualização Necessária!',
          bodyText: 'Por favor, para continuar: \n'
              'é necessário atualizar o aplicativo para a versão mais recente!',
          actions: [
            CustomButton(
              text: 'Atualizar',
              onPressed: () {
                Navigator.pop(context);
                // You can redirect to the app store for updating the app
                // For Android, use:
                // launch('https://play.google.com/store/apps/details?id=com.example.app');
                // For iOS, use:
                // launch('https://apps.apple.com/app/id<your_app_id>');
              },
            )
          ],
        );
      },
    );
        alertDialog;
  }

  Future<void> checkAndHandleVersion() async {
    if (await _checkVersion()) {
      // Version is up-to-date, continue with the app
    } else {
      // Version is outdated, show an alert or prompt to update the app
      alertDialog();
    }
  }
}
