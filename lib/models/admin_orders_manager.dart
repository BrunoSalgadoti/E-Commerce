import 'dart:async';

import 'package:brn_ecommerce/models/order_client.dart';
import 'package:brn_ecommerce/models/users.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AdminOrdersManager extends ChangeNotifier {
  final List<OrderClient> _orders = [];

  Users? userFilter;
  List<StatusOfOrders> statusFilter = [StatusOfOrders.preparing, StatusOfOrders.transporting];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription<dynamic>? _subscription;

  void updateAdmin({required bool adminEnable}) {
    _orders.clear();

    _subscription?.cancel();
    if (adminEnable) {
      _listenToOrders();
    }
  }

  List<OrderClient> get filteredOrders {
    List<OrderClient> output = _orders.reversed.toList();

    if (userFilter != null) {
      output = output.where((o) => o.userId == userFilter!.id).toList();
    }

    return output = output.where((o) => statusFilter.contains(o.status)).toList();
  }

  Future<void> _listenToOrders() async {
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('_listenToOrders');
    }

    PerformanceMonitoring().startTrace('listen-orders', shouldStart: true);

    _subscription = firestore.collection("orders").snapshots().listen((events) {
      for (final change in events.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            _orders.add(OrderClient.fromDocument(change.doc));
            break;
          case DocumentChangeType.modified:
            final modOrder = _orders.firstWhere((element) => element.orderId == change.doc.id);
            modOrder.updateFromDocument(change.doc);
            break;
          case DocumentChangeType.removed:
            break;
        }
      }
      notifyListeners();
    });

    PerformanceMonitoring().stopTrace('listen-orders');
  }

  void setUserFilter(Users? user) {
    userFilter = user;
    notifyListeners();
  }

  void setStatusFilter({StatusOfOrders? status, bool? enabled}) {
    if (enabled!) {
      statusFilter.add(status!);
    } else {
      statusFilter.remove(status);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
