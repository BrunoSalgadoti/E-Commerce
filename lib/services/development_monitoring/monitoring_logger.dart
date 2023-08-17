import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:logger/logger.dart';

class LoggerService {
  final _logger = Logger();

  void logDebug(String message) {
    if (!kReleaseMode) {
      _logger.d(message);
    }
  }

  void logInfo(String message) {
    if (!kReleaseMode) {
      _logger.i(message);
    }
  }

  void logWarning(String message) {
    if (!kReleaseMode) {
      _logger.w(message);
    }
  }

  void logError(String message) {
    if (!kReleaseMode) {
      _logger.e(message);
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
