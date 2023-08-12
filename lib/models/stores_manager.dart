import 'dart:async';

import 'package:brn_ecommerce/models/address.dart';
import 'package:brn_ecommerce/models/stores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';

class StoresManager extends ChangeNotifier {
  StoresManager([this.stores, this.address]) {
    _loadStoreList();
    _startTime();
    _setupRealTimeUpdates();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stores? stores;
  Address? address;
  Timer? _timer;
  StreamSubscription<QuerySnapshot>? _storesListener;

  List<Stores> storesList = [];

  Future<void> _loadStoreList() async {
    // Start custom code tracing (TRACEPERFORMANCE)
      final trace = FirebasePerformance.instance.newTrace('load-store-list');
      await trace.start();


    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection("stores")
        .get(const GetOptions(source: Source.cache));

    if (snapshot.metadata.isFromCache) {
      // If data is retrieved from the cache, update the UI...
      // immediately with cached data
      storesList = snapshot.docs.map((s) => Stores.fromDocument(s)).toList();
      notifyListeners();
    }

    // Stop custom code trace
    await trace.stop();
  }

  void _startTime() async {
    // Start custom code tracing (TRACEPERFORMANCE)
    final trace = FirebasePerformance.instance.newTrace('start-time');
    await trace.start();

    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkOpening();
    });

    // Stop custom code trace
    await trace.stop();
  }

  void _checkOpening() {
    for (final store in storesList) {
      store.updateStatus();
      notifyListeners();
    }
  }

  Future<void> _setupRealTimeUpdates() async {
    // Start custom code tracing (TRACEPERFORMANCE)
    final trace = FirebasePerformance.instance.newTrace('stores-realtime-update');
    await trace.start();

    // Configure real-time update listener
    _storesListener =
        firestore.collection("stores").snapshots().listen((event) {
      storesList = event.docs.map((s) => Stores.fromDocument(s)).toList();
      notifyListeners();
    });

    // Stop custom code trace
    await trace.stop();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _storesListener?.cancel();
  }
}

// import 'dart:async';
//
// import 'package:brn_ecommerce/models/address.dart';
// import 'package:brn_ecommerce/models/stores.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
//
// class StoresManager extends ChangeNotifier {
//   StoresManager([this.stores, this.address]) {
//     _loadStoreList();
//     _startTime();
//   }
//
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//   Stores? stores;
//   Address? address;
//   Timer? _timer;
//   StreamSubscription<QuerySnapshot>? _storesListener;
//
//   List<Stores> storesList = [];
//
//   Future<void> _loadStoreList() async {
//     QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
//         .collection("stores")
//         .get(const GetOptions(source: Source.cache));
//
//     if (snapshot.metadata.isFromCache) {
//       // If data is retrieved from the cache, update the UI...
//       // immediately with cached data
//       storesList = snapshot.docs.map((s) => Stores.fromDocument(s)).toList();
//       notifyListeners();
//     }
//
//     // Listen to the stream for real-time updates and update...
//     // the UI when necessary
//     _storesListener = firestore.collection("stores").snapshots().listen((event) {
//       storesList = event.docs.map((s) => Stores.fromDocument(s)).toList();
//       notifyListeners();
//     });
//   }
//
//   void _startTime() {
//     _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
//       _checkOpening();
//     });
//   }
//
//   void _checkOpening() {
//     for (final store in storesList) {
//       store.updateStatus();
//       notifyListeners();
//     }
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _timer?.cancel();
//     _storesListener?.cancel();
//   }
// }
