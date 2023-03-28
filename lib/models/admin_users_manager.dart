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
    }else {
      userList.clear();
      notifyListeners();
    }
  }

  Future<void> _listenToUsers() async {
    _subscription = firestore.collection('users')
        .snapshots()
        .listen((snapshot) async {
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
