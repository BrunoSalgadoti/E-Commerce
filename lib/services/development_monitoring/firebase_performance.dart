import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';

/// # PerformanceMonitoring (Folder: services/development_monitoring)
///
/// Manages performance monitoring using Firebase Performance Monitoring.
///
/// This class provides methods to start and stop performance traces.
class PerformanceMonitoring {
  // Proprieties

  final FirebasePerformance _performance = FirebasePerformance.instance;
  static final PerformanceMonitoring _instance = PerformanceMonitoring._();

  // Constructors

  /// Constructs a PerformanceMonitoring instance.
  factory PerformanceMonitoring() => _instance;

  PerformanceMonitoring._();

  // Methods

  /// Starts a performance trace with the given [name].
  ///
  /// [shouldStart] indicates whether the trace should start immediately.
  void startTrace(String name, {bool shouldStart = true}) {
    if (shouldStart && !kIsWeb) {
      final trace = _performance.newTrace(name);
      trace.start();
    }
  }

  /// Stops a performance trace with the given [name].
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
