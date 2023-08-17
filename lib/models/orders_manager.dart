import 'dart:async';

import 'package:brn_ecommerce/models/order_client.dart';
import 'package:brn_ecommerce/models/users.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrdersManager extends ChangeNotifier {
  Users? users;

  List<OrderClient> orders = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription<dynamic>? _subscription;

  void updateUser(Users users) {
    this.users = users;
    orders.clear();

    _subscription?.cancel();
    if (users.id != null) {
      _listenToOrders();
    }
  }

  Future<void> _listenToOrders() async {
    PerformanceMonitoring().startTrace('listenToOrders', shouldStart: true);

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

    PerformanceMonitoring().stopTrace('listenToOrders');
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
