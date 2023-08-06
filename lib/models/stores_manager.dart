import 'dart:async';

import 'package:brn_ecommerce/models/address.dart';
import 'package:brn_ecommerce/models/stores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class StoresManager extends ChangeNotifier {
  StoresManager([this.stores, this.address]) {
    _loadStoreList();
    _startTime();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stores? stores;
  Address? address;
  Timer? _timer;
  StreamSubscription<QuerySnapshot>? _storesListener;

  List<Stores> storesList = [];

  Future<void> _loadStoreList() async {
    // Add a listener to the "stores" collection for real-time updates
    _storesListener =
        firestore.collection("stores").snapshots().listen((event) {
      storesList = event.docs.map((s) => Stores.fromDocument(s)).toList();
      notifyListeners();
    });
  }

  void _startTime() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkOpening();
    });
  }

  void _checkOpening() {
    for (final store in storesList) {
      store.updateStatus();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _storesListener?.cancel();
  }
}
