import 'dart:async';

import 'package:brn_ecommerce/models/address.dart';
import 'package:brn_ecommerce/models/stores.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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

  final logger = LoggerService();

  Future<void> _loadStoreList() async {
    PerformanceMonitoring().startTrace('load-store-list', shouldStart: true);

    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection("stores")
        .get(const GetOptions(source: Source.cache));

    if (snapshot.metadata.isFromCache) {
      // If data is retrieved from the cache, update the UI...
      // immediately with cached data
      storesList = snapshot.docs.map((s) => Stores.fromDocument(s)).toList();
      notifyListeners();
    }

    PerformanceMonitoring().stopTrace('load-store-list');
  }

  void _startTime() async {
    PerformanceMonitoring().startTrace('startTime', shouldStart: true);

    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkOpening();
    });

    PerformanceMonitoring().stopTrace('startTime');
  }

  void _checkOpening() {
    for (final store in storesList) {
      store.updateStatus();
      notifyListeners();
    }
  }

  Future<void> _setupRealTimeUpdates() async {
    PerformanceMonitoring()
        .startTrace('setupRealTimeUpdates', shouldStart: true);
    logger.logInfo('Info message: _storesListener Start ');

    // Configure real-time update listener
    _storesListener =
        firestore.collection("stores").snapshots().listen((event) {
      storesList = event.docs.map((s) => Stores.fromDocument(s)).toList();
      notifyListeners();
    });

    PerformanceMonitoring().stopTrace('setupRealTimeUpdates');
    logger.logInfo('Info message: _storesListener END ');
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _storesListener?.cancel();
    logger.logInfo('Info message: _storesListener Cancel ');
  }
}
