import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/users.dart';
import 'package:ecommerce/models/users_manager.dart';
import 'package:flutter/material.dart';

class AdminUsersManager with ChangeNotifier {
  List<Users> userList = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription? _subscription;

  void updateUser(UserManager userManager) {
    _subscription?.cancel();
    if (userManager.adminEnable) {
      _listenToUsers();
    } else {
      userList.clear();
      notifyListeners();
    }
  }

  Future<void> _listenToUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('users')
        .get(const GetOptions(source: Source.cache));
    if (snapshot.metadata.isFromCache) {
      // If data is retrieved from the cache, update the UI immediately with cached data
      userList = snapshot.docs.map((d) => Users.fromDocument(d)).toList();
      notifyListeners();
    }
    // Listen to the stream for real-time updates and update the UI when necessary
    _subscription =
        firestore.collection('users').snapshots().listen((snapshot) async {
      userList = snapshot.docs.map((d) => Users.fromDocument(d)).toList();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}