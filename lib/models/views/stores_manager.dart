import 'dart:async';

import 'package:brn_ecommerce/models/locations_services/address.dart';
import 'package:brn_ecommerce/models/views/stores.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// # StoresManager (Folder: models/views)
///
/// Manages the state and operations related to stores within the application.
///
/// This class provides methods to load store data, set up real-time updates,
/// and handle timers for periodic tasks.
class StoresManager extends ChangeNotifier {
  // Proprieties

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Stores> storesList = [];
  Stores? stores;
  Address? address;
  Timer? _timer;
  StreamSubscription<QuerySnapshot>? _storesListener;

  // Constructors

  /// Constructs a StoresManager instance with optional initial stores and address.
  StoresManager([this.stores, this.address]) {
    _loadStoreList();
    _startTime();
    _setupRealTimeUpdates();
  }

  // Methods

  /// Loads the list of stores from Firestore and initializes the store list.
  Future<void> _loadStoreList() async {
    PerformanceMonitoring().startTrace('load-store-list', shouldStart: true);

    // Fetch store data from Firestore
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

  /// Starts a timer to perform periodic checks on store statuses.
  void _startTime() async {
    PerformanceMonitoring().startTrace('start-time', shouldStart: true);

    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkOpening();
    });

    PerformanceMonitoring().stopTrace('start-time');
  }

  /// Checks and updates the opening status of all stores in the list.
  void _checkOpening() {
    for (final store in storesList) {
      store.updateStatus();
      notifyListeners();
    }
  }

  /// Sets up real-time updates for the list of stores from Firestore.
  Future<void> _setupRealTimeUpdates() async {
    PerformanceMonitoring().startTrace('setup-rt-updates', shouldStart: true);
    if (kDebugMode) {
      MonitoringLogger().logInfo('Info message: _storesListener Start ');
    }

    // Configure a real-time update listener for store data changes
    _storesListener = firestore.collection("stores").snapshots().listen((event) {
      storesList = event.docs.map((s) => Stores.fromDocument(s)).toList();
      notifyListeners();
    });

    PerformanceMonitoring().stopTrace('setup-rt-updates');
  }

  @override
  void dispose() {
    _timer?.cancel();
    _storesListener?.cancel();
    super.dispose();
  }
}
