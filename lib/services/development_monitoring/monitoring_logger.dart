import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:logger/logger.dart';

class MonitoringLogger {

  void logDebug(String message) {
    if (!kReleaseMode) {
      final logger = Logger();
      logger.d(message);
    }
  }

  void logInfo(String message) {
    if (!kReleaseMode) {
      final logger = Logger();
      logger.i(message);
    }
  }

  void logWarning(String message) {
    if (!kReleaseMode) {
      final logger = Logger();
      logger.w(message);
    }
  }

  void logError(String message) {
    if (!kReleaseMode) {
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
