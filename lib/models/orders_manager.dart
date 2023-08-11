import 'dart:async';

import 'package:brn_ecommerce/models/order_client.dart';
import 'package:brn_ecommerce/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrdersManager extends ChangeNotifier {
  Users? users;

  List<OrderClient> orders = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription? _subscription;

  void updateUser(Users users) {
    this.users = users;
    orders.clear();

    _subscription?.cancel();
    if (users.id != null) {
      _listenToOrders();
    }
  }

  void _listenToOrders() {
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
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
