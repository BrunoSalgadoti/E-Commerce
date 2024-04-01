import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:logger/logger.dart';

class MonitoringLogger {
  // Variable that, if set to TRUE, DISABLES all PROJECT Monitoring.
  final stopAllLoggers = true;

  void logDebug(String message) {
    if (!kReleaseMode && stopAllLoggers == false) {
      final logger = Logger();
      logger.d(message);
    }
  }

  void logInfo(String message) {
    if (!kReleaseMode && stopAllLoggers == false) {
      final logger = Logger();
      logger.i(message);
    }
  }

  void logWarning(String message) {
    if (!kReleaseMode && stopAllLoggers == false) {
      final logger = Logger();
      logger.w(message);
    }
  }

  void logError(String message) {
    if (!kReleaseMode && stopAllLoggers == false) {
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
