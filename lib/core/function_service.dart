import 'package:brn_ecommerce/core/monitoring/monitoring_logger.dart';

import 'control_center.dart';

class FunctionService {
  FunctionService._internal();

  static final FunctionService instance = FunctionService._internal();

  final FirebaseFunctions _functions = FirebaseFunctions.instance;
  final ControlCenter _control = ControlCenter.instance;
  final MonitoringLogger _logger = MonitoringLogger();

  /// =========================
  /// ☁️ CALL FUNCTION
  /// =========================
  Future<dynamic> callFunction({
    required String name,
    Map<String, dynamic>? data,
  }) async {
    if (!_control.canExecute(OperationType.functionCall)) {
      _logger.logWarning('FUNCTION BLOCKED → $name');
      throw Exception('Function call blocked');
    }

    try {
      final callable = _functions.httpsCallable(
        name,
        options: HttpsCallableOptions(
          timeout: const Duration(seconds: 10),
        ),
      );

      final result = await callable.call(data ?? {});

      _control.registerUsage(OperationType.functionCall);

      return result.data;
    } catch (e) {
      _logger.logError('FUNCTION ERROR → $name → $e');
      rethrow;
    }
  }
}
