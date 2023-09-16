import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';

class PerformanceMonitoring {
  static final PerformanceMonitoring _instance = PerformanceMonitoring._();

  factory PerformanceMonitoring() => _instance;

  PerformanceMonitoring._();

  final FirebasePerformance _performance = FirebasePerformance.instance;

  void startTrace(String name, {bool shouldStart = true}) {
    if (shouldStart && !kIsWeb) {
      final trace = _performance.newTrace(name);
      trace.start();
    }
  }

  void stopTrace(String name) {
    if (!kIsWeb) {
      final trace = _performance.newTrace(name);
      trace.stop();
    }
  }
}

//Usage Example :

/*
PerformanceMonitoring().startTrace('load-store-list', shouldStart: condicao);
 (Code you want to track)
PerformanceMonitoring().stopTrace('load-store-list');
*/
