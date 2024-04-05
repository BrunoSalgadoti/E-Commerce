import 'package:flutter/foundation.dart';

// ignore: depend_on_referenced_packages
import 'package:logger/logger.dart';

/// # MonitoringLogger (Folder: services/development_monitoring)
///
/// Manages logging for debug, info, warning, and error messages.
///
/// This class provides methods to log messages using the `logger` package.
class MonitoringLogger {
  // Proprieties

  // Variable that, if set to TRUE STOP in all PROJECT Monitoring.
  final stopAllLoggers = true;

  // Methods

  /// Logs a debug [message] if [kDebugMode] is true and [stopAllLoggers] is false.
  void logDebug(String message) {
    if (kDebugMode && stopAllLoggers == false) {
      final logger = Logger();
      logger.d(message);
    }
  }

  /// Logs an info [message] if [kDebugMode] is true and [stopAllLoggers] is false.
  void logInfo(String message) {
    if (kDebugMode && stopAllLoggers == false) {
      final logger = Logger();
      logger.i(message);
    }
  }

  /// Logs a warning [message] if [kDebugMode] is true and [stopAllLoggers] is false.
  void logWarning(String message) {
    if (kDebugMode && stopAllLoggers == false) {
      final logger = Logger();
      logger.w(message);
    }
  }

  /// Logs an error [message] if [kDebugMode] is true and [stopAllLoggers] is false.
  void logError(String message) {
    if (kDebugMode && stopAllLoggers == false) {
      final logger = Logger();
      logger.e(message);
    }
  }
}

//Usage Example:
/*

final logger = LoggerService();
logger.logDebug('Debug message');
logger.logInfo('Info message');
logger.logWarning('Warning message');
logger.logError('Error message');

*/
