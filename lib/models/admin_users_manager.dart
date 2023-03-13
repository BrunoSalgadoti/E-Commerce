import 'package:ecommerce/models/users.dart';
import 'package:ecommerce/models/users_manager.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class AdminUsersManager extends ChangeNotifier {
  List<Users> users = [];

  void updateUser(UserManager userManager) {
    if (userManager.adminEnable) {
      _listenToUsers();
    }
  }

  void _listenToUsers() {
    final faker = Faker();

    for (int i = 0; i < 1000; i++) {
      users.add(Users(
        userName: faker.person.name(),
        email: faker.internet.email(),
      ));
      users.sort((a, b) =>
          a.userName!.toLowerCase().compareTo(b.userName!.toLowerCase()));
    }

    notifyListeners();
  }

  List<String> get names => users.map((e) => e.userName!).toList();
}
