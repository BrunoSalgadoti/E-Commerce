import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/helpers/firebase_errors.dart';
import 'package:ecommerce/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class UserManager with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Users? users;

  bool _loading = false;

  bool get loading => _loading;

  bool get isLoggedIn => users != null;

  UserManager() {
    _loadCurrentUser();
  }

  Future<void> signIn(
      {required Users users,
      required Function onFail,
      required Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
          email: users.email, password: users.password);

      await _loadCurrentUser(user: result.user);

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFail(getErrorString(error.code));
    }
    loading = false;
  }

  Future<void> singUp(
      {required Users users,
      required Function onFail,
      required Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: users.email, password: users.password);

      users.id = result.user!.uid;
      this.users = users;

      await users.saveData();

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFail(getErrorString(error.code));
    }
    loading = false;
  }

  void signOut() {
    _auth.signOut();
    users = null;
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User? user}) async {
    try {
      final User currentUser = user ?? _auth.currentUser!;
      if (currentUser != null) {
        final DocumentSnapshot docUsers =
            await firestore.collection('users').doc(currentUser.uid).get();
        users = Users.fromDocument(docUsers);

        final docAdmin = await firestore.collection('admins')
            .doc(users?.id).get();
        if(docAdmin.exists) {
          users?.admin = true;
        }

        notifyListeners();
      }
    } catch (noUser) {
      StackTrace.empty;
    }
  }

  bool get adminEnable => users != null && users!.admin;
}
