import 'dart:async';

import 'package:brn_ecommerce/models/sales/order_client.dart';
import 'package:brn_ecommerce/models/users/users.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// # OrdersManager (Folder: models/sales)
///
/// A class responsible for managing orders, including updating user data and listening to order changes.
///
/// This class handles user updates, order subscription, and order data management.
class OrdersManager extends ChangeNotifier {
  // Proprieties

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<OrderClient> orders = [];
  Users? users;
  StreamSubscription<dynamic>? _subscription;

  // Methods

  /// Updates the user data and starts listening to orders.
  void updateUser(Users users) {
    this.users = users;
    orders.clear();

    _subscription?.cancel();

    if (kDebugMode) {
      MonitoringLogger().logInfo('Info: ${_subscription?.cancel()}_subscriptionCANCEL');
    }

    if (users.id != null) {
      _listenToOrders();
    }
  }

  /// Listens to changes in orders for the current user.
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
