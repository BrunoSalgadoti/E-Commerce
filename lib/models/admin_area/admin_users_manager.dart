import 'dart:async';

import 'package:brn_ecommerce/models/users/users.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// # Admin Users Manager Model (Folder: models/admin_area)
/// ## AdminUsersManager
/// A class responsible for managing users in the admin panel, including listening to user updates.
///
/// This class handles the management of users in the admin panel. It provides functionality for listening to
/// real-time updates for users from Firestore and updating the user list accordingly.
class AdminUsersManager with ChangeNotifier {
  // Properties

  /// The instance of the Firestore database.
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// The list of users managed by the admin.
  List<Users> userList = [];

  /// The subscription to listen for user updates.
  StreamSubscription<dynamic>? _subscription;

  // Methods

  /// Listens to users from Firestore and updates the internal user list accordingly.
  Future<void> _listenToUsers() async {
    PerformanceMonitoring().startTrace('listen-users', shouldStart: true);
    if (kDebugMode) {
      MonitoringLogger().logInfo('Info message: Instance  _listenToUsers');
    }

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("users").get(const GetOptions(source: Source.cache));
    if (snapshot.metadata.isFromCache) {
      // If data is retrieved from the cache, update the UI...
      // immediately with cached data
      userList = snapshot.docs.map((d) => Users.fromDocument(d)).toList();
      notifyListeners();
    }
    // Listen to the stream for real-time updates and update...
    // the UI when necessary
    _subscription = firestore.collection("users").snapshots().listen((snapshot) async {
      userList = snapshot.docs.map((d) => Users.fromDocument(d)).toList();
      notifyListeners();
    });

    PerformanceMonitoring().stopTrace('listen-users');
  }

  /// Updates the user list based on the admin's user manager.
  ///
  /// If adminEnable is true, listens to users from Firestore and updates the user list.
  /// If adminEnable is false, clears the user list.
  void updateUser(UserManager userManager) {
    if (userManager.adminEnable) {
      _listenToUsers();
    } else {
      userList.clear();
    }
    notifyListeners();
  }

  /// Disposes of resources when the object is no longer needed.
  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
