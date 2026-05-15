import 'package:firebase_crashlytics/firebase_crashlytics.dart' show FirebaseCrashlytics;

/// ## reportNoFatalErrorToCrashlytics
/// Reports non-fatal errors to Firebase Crashlytics for monitoring.
///
/// Takes required parameters: [error], [stackTrace], and [information].
Future<void> reportNoFatalErrorToCrashlytics(
    {required String error,
      String? reason,
      required StackTrace stackTrace,
      required String information}) async {
  await FirebaseCrashlytics.instance.recordError(
    error,
    stackTrace,
    reason: reason ?? 'Monitoramento Try-Catch',
    information: [information, 'version 1.0'],
  );
}