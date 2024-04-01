import 'dart:async';

import 'package:brn_ecommerce/models/sales/order_client.dart';
import 'package:brn_ecommerce/models/users/users.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class OrdersManager extends ChangeNotifier {
  Users? users;

  List<OrderClient> orders = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription<dynamic>? _subscription;

  void updateUser(Users users) {
    this.users = users;
    orders.clear();

    _subscription?.cancel();

    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Info: ${_subscription?.cancel()}_subscriptionCANCEL');
    }

    if (users.id != null) {
      _listenToOrders();
    }
  }

  Future<void> _listenToOrders() async {
    PerformanceMonitoring().startTrace('listen-orders', shouldStart: true);
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Info: listenToOrders');
    }

    _subscription = firestore
        .collection("orders")
        .where("user", isEqualTo: users!.id)
        .snapshots()
        .listen((events) {
      orders.clear();
      for (final document in events.docs) {
        orders.add(OrderClient.fromDocument(document));
      }
      notifyListeners();
    });

    PerformanceMonitoring().stopTrace('listen-orders');
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
