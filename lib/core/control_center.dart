import 'package:flutter/foundation.dart';

enum OperationType {
  read,
  write,
  upload,
  download,
  functionCall,
  auth,
}

class ControlCenter {
  ControlCenter._internal();

  static final ControlCenter instance = ControlCenter._internal();

  /// =========================
  /// 🔧 CONFIG (ajustável)
  /// =========================
  final int maxReads = 35000;
  final int maxWrites = 14000;
  final int maxUploads = 70;
  final int maxDownloads = 5000;
  final int maxFunctions = 2000;

  /// =========================
  /// 📊 USAGE (global)
  /// =========================
  int reads = 0;
  int writes = 0;
  int uploads = 0;
  int downloads = 0;
  int functions = 0;

  bool systemPaused = false;

  /// =========================
  /// 🚦 DECISÃO PRINCIPAL
  /// =========================
  bool canExecute(OperationType type) {
    if (systemPaused) return false;

    switch (type) {
      case OperationType.read:
        return reads < maxReads;
      case OperationType.write:
        return writes < maxWrites;
      case OperationType.upload:
        return uploads < maxUploads;
      case OperationType.download:
        return downloads < maxDownloads;
      case OperationType.functionCall:
        return functions < maxFunctions;
      case OperationType.auth:
        return true;
    }
  }

  /// =========================
  /// 📈 REGISTRO DE USO
  /// =========================
  void registerUsage(OperationType type, {int amount = 1}) {
    switch (type) {
      case OperationType.read:
        reads += amount;
        break;
      case OperationType.write:
        writes += amount;
        break;
      case OperationType.upload:
        uploads += amount;
        break;
      case OperationType.download:
        downloads += amount;
        break;
      case OperationType.functionCall:
        functions += amount;
        break;
      case OperationType.auth:
        break;
    }

    _checkLimits();
  }

  /// =========================
  /// 🚨 BLOQUEIO AUTOMÁTICO
  /// =========================
  void _checkLimits() {
    if (reads >= maxReads ||
        writes >= maxWrites ||
        uploads >= maxUploads ||
        downloads >= maxDownloads ||
        functions >= maxFunctions) {
      systemPaused = true;

      if (kDebugMode) {
        print('🚨 SYSTEM PAUSED (LIMIT REACHED)');
      }
    }
  }

  /// =========================
  /// 🔴 STATUS
  /// =========================
  bool isBlocked() => systemPaused;

  /// =========================
  /// 🧨 EMERGENCY STOP
  /// =========================
  void activateEmergencyStop() {
    systemPaused = true;
  }

  /// =========================
  /// 🔄 RESET (uso diário)
  /// =========================
  void resetUsage() {
    reads = 0;
    writes = 0;
    uploads = 0;
    downloads = 0;
    functions = 0;
    systemPaused = false;
  }
}