import 'dart:async';

import 'package:brn_ecommerce/models/sales/order_client.dart';
import 'package:brn_ecommerce/models/users/users.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// # Admin Orders Manager Model (Folder: models/admin_area)
/// ## AdminOrdersManager
/// A class responsible for managing orders in the admin panel, including filtering and listening to order updates.
///
/// This class handles the management of orders in the admin panel. It provides functionality for filtering orders
/// based on user ID and order status, as well as listening to real-time updates for orders from Firestore.
class AdminOrdersManager extends ChangeNotifier {
  // Properties

  /// The list of orders managed by the admin.
  final List<OrderClient> _orders = [];

  /// The instance of the Firestore database.
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// The user filter applied to orders (optional).
  Users? userFilter;

  /// The list of order statuses to filter by.
  List<StatusOfOrders> statusFilter = [StatusOfOrders.preparing, StatusOfOrders.transporting];

  /// The subscription to listen for order updates.
  StreamSubscription<dynamic>? _subscription;

  // Methods

  /// Gets the filtered list of orders based on the applied filters.
  List<OrderClient> get filteredOrders {
    List<OrderClient> output = _orders.reversed.toList();

    if (userFilter != null) {
      output = output.where((o) => o.userId == userFilter!.id).toList();
    }

    return output = output.where((o) => statusFilter.contains(o.status)).toList();
  }

  /// Listens to orders from Firestore and updates the internal order list accordingly.
  Future<void> _listenToOrders() async {
    if (kDebugMode) {
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

  /// Updates the admin orders based on the admin enable status.
  ///
  /// Clears the current orders list and cancels the subscription.
  /// If adminEnable is true, listens to orders from Firestore.
  void updateAdmin({required bool adminEnable}) {
    _orders.clear();

    _subscription?.cancel();
    if (adminEnable) {
      _listenToOrders();
    }
  }

  /// Sets the user filter for orders.
  void setUserFilter(Users? user) {
    userFilter = user;
    notifyListeners();
  }

  /// Sets the status filter for orders.
  ///
  /// The [status] parameter represents the order status to filter by.
  /// The [enabled] parameter specifies whether to add or remove the status filter.
  void setStatusFilter({StatusOfOrders? status, bool? enabled}) {
    if (enabled!) {
      statusFilter.add(status!);
      notifyListeners();
    } else {
      statusFilter.remove(status);
      notifyListeners();
    }
  }

  /// Disposes of resources when the object is no longer needed.
  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
