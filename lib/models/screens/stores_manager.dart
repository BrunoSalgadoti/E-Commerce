import 'dart:async';

import 'package:brn_ecommerce/models/address_n_cep/address.dart';
import 'package:brn_ecommerce/models/screens/stores.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    PerformanceMonitoring().startTrace('load-store-list', shouldStart: true);

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("stores").get(const GetOptions(source: Source.cache));

    if (snapshot.metadata.isFromCache) {
      // If data is retrieved from the cache, update the UI...
      // immediately with cached data
      storesList = snapshot.docs.map((s) => Stores.fromDocument(s)).toList();
      notifyListeners();
    }

    PerformanceMonitoring().stopTrace('load-store-list');
  }

  void _startTime() async {
    PerformanceMonitoring().startTrace('start-time', shouldStart: true);

    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkOpening();
    });

    PerformanceMonitoring().stopTrace('start-time');
  }

  void _checkOpening() {
    for (final store in storesList) {
      store.updateStatus();
      notifyListeners();
    }
  }

  Future<void> _setupRealTimeUpdates() async {
    PerformanceMonitoring().startTrace('setup-rt-updates', shouldStart: true);
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Info message: _storesListener Start ');
    }

    // Configure real-time update listener
    _storesListener = firestore.collection("stores").snapshots().listen((event) {
      storesList = event.docs.map((s) => Stores.fromDocument(s)).toList();
      notifyListeners();
    });

    PerformanceMonitoring().stopTrace('setup-rt-updates');
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _storesListener?.cancel();
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('Info: ${_storesListener?.cancel()} ListenerCancel ');
    }
  }
}
