import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/users.dart';
import 'package:ecommerce/models/users_manager.dart';
import 'package:flutter/material.dart';

class AdminUsersManager with ChangeNotifier {
  List<Users> userList = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateUser(UserManager userManager) {
    if (userManager.adminEnable) {
      _listenToUsers();
    }
  }

  Future<void> _listenToUsers() async {
    firestore.collection('users').get().then((snapshot) async {
      userList = snapshot.docs.map((d) => Users.fromDocument(d)).toList();
      notifyListeners();
    });
  }
}
