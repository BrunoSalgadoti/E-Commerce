import 'dart:async';

import 'package:brn_ecommerce/core/monitoring/monitoring_logger.dart';
import 'package:brn_ecommerce/models/users/users.dart';
import 'package:brn_ecommerce/features/auth/managers/users_manager.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:brn_ecommerce/core/firestore_service.dart';

class AdminUsersManager with ChangeNotifier {


  // ✅ CORE
  final FirestoreService _firestoreService = FirestoreService.instance;

  bool _isListening = false;
  List<Users> userList = [];

  StreamSubscription<dynamic>? _subscription;

  // =========================
  // 🔥 LISTENER CONTROLADO
  // =========================
  Future<void> _listenToUsers() async {
    if (_isListening) return;
    _isListening = true;

    PerformanceMonitoring().startTrace('listen-users', shouldStart: true);

    if (kDebugMode) {
      MonitoringLogger().logInfo('Info message: Instance _listenToUsers');
    }

    /// =========================
    /// 🔎 CACHE READ (CONTROLADO)
    /// =========================
    try {
      final snapshot = await _firestoreService.getCollection(
        collection: "users",
        useCache: true,
      );

      userList = snapshot.docs.map((d) => Users.fromDocument(d)).toList();
      notifyListeners();
    } catch (e) {
      MonitoringLogger().logWarning('CACHE READ BLOCKED → users');
    }

    /// =========================
    /// 🔥 REALTIME CONTROLADO
    /// =========================
    _subscription = _firestoreService.listenCollection(
      collection: "users",
      onChange: (snapshot) {
        userList = snapshot.docs.map((d) => Users.fromDocument(d)).toList();
        notifyListeners();
      },
    );

    PerformanceMonitoring().stopTrace('listen-users');
  }

  // =========================
  // CONTROL
  // =========================
  void updateUser(UserManager userManager) {
    _subscription?.cancel(); // ✅ importante evitar duplicação

    if (userManager.adminEnable) {
      _listenToUsers();
    } else {
      userList.clear();
    }

    notifyListeners();
  }

  // =========================
  // DISPOSE
  // =========================
  @override
  void dispose() {
    _subscription?.cancel();
    _isListening = false;
    super.dispose();
  }
}