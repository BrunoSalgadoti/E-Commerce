import 'dart:async';

import 'package:brn_ecommerce/core/monitoring/monitoring_logger.dart';
import 'package:brn_ecommerce/models/sales/order_client.dart';
import 'package:brn_ecommerce/models/users/users.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:brn_ecommerce/core/firestore_service.dart';

class AdminOrdersManager extends ChangeNotifier {
  // Properties

  final List<OrderClient> _orders = [];

  // ✅ NOVO (gateway controlado)
  final FirestoreService _firestoreService = FirestoreService.instance;

  Users? userFilter;

  List<StatusOfOrders> statusFilter = [
    StatusOfOrders.preparing,
    StatusOfOrders.transporting
  ];

  StreamSubscription<dynamic>? _subscription;

  // =========================
  // FILTER
  // =========================
  List<OrderClient> get filteredOrders {
    List<OrderClient> output = _orders.reversed.toList();

    if (userFilter != null) {
      output = output.where((o) => o.userId == userFilter!.id).toList();
    }

    return output =
        output.where((o) => statusFilter.contains(o.status)).toList();
  }

  // =========================
  // 🔥 LISTENER CONTROLADO
  // =========================
  Future<void> _listenToOrders() async {
    if (kDebugMode) {
      MonitoringLogger().logInfo('_listenToOrders');
    }

    PerformanceMonitoring().startTrace('listen-orders', shouldStart: true);

    // ✅ ALTERAÇÃO PRINCIPAL AQUI
    _subscription = _firestoreService.listenCollection(
      collection: "orders",
      onChange: (events) {
        for (final change in events.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              _orders.add(OrderClient.fromDocument(change.doc));
              break;

            case DocumentChangeType.modified:
              final modOrder = _orders.firstWhere(
                    (element) => element.orderId == change.doc.id,
              );
              modOrder.updateFromDocument(change.doc);
              break;

            case DocumentChangeType.removed:
              break;
          }
        }

        notifyListeners();
      },
    );

    PerformanceMonitoring().stopTrace('listen-orders');
  }

  // =========================
  // CONTROL
  // =========================
  void updateAdmin({required bool adminEnable}) {
    _orders.clear();

    _subscription?.cancel();

    if (adminEnable) {
      _listenToOrders();
    }
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
    _subscription?.cancel();
    super.dispose();
  }
}