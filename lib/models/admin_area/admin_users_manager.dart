import 'dart:async';

import 'package:brn_ecommerce/models/users/users.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AdminUsersManager with ChangeNotifier {
  List<Users> userList = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription<dynamic>? _subscription;

  void updateUser(UserManager userManager) {
    _subscription?.cancel();
    if (userManager.adminEnable) {
      _listenToUsers();
    } else {
      userList.clear();
      notifyListeners();
    }
  }

  Future<void> _listenToUsers() async {
    PerformanceMonitoring().startTrace('listen-users', shouldStart: true);
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Info message: Instance  _listenToUsers');
    }

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("users").get(const GetOptions(source: Source.cache));
    if (snapshot.metadata.isFromCache) {
      // If data is retrieved from the cache, update the UI...
      // immediately with cached data
      userList = snapshot.docs.map((d) => Users.fromDocument(d)).toList();
      notifyListeners();
    }
    // Listen to the stream for real-time updates and update...
    // the UI when necessary
    _subscription = firestore.collection("users").snapshots().listen((snapshot) async {
      userList = snapshot.docs.map((d) => Users.fromDocument(d)).toList();
      notifyListeners();
    });

    PerformanceMonitoring().stopTrace('listen-users');
  }

  @override
  void dispose() {
    _subscription?.cancel();
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Info message: Instance  $_subscription CANCELADO');
    }
    super.dispose();
  }
}
