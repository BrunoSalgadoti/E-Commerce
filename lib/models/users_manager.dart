import 'package:brn_ecommerce/helpers/firebase_errors.dart';
import 'package:brn_ecommerce/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Users? users;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get isLoggedIn => users != null;

  bool get adminEnable => users != null && users!.admin;

  Image? image = Image.asset(
    'assets/logo/storeLogo.png',
    width: 15,
    height: 15,
  );

  Future<void> signIn(
      {required Users users,
      required Function onFail,
      required Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
          email: users.email, password: users.password!);

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
          email: users.email, password: users.password!);

      users.id = result.user!.uid;
      this.users = users;

      await users.saveData();

      // Check if this is the first user to register
      QuerySnapshot adminsQuery =
          await firestore.collection('admins').limit(1).get();
      if (adminsQuery.docs.isEmpty) {
        // Creates document '{users.id}' in collection 'admins' with user id admin
        await firestore.collection('admins').doc(users.id).set({
          'user': users.id,
        });
        users.admin = true; // Set user as administrator on first login
      }

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

  Future<void> _loadCurrentUser({User? user}) async {
    try {
      final User currentUser = user ?? _auth.currentUser!;
      if (currentUser.uid.isNotEmpty) {
        final DocumentSnapshot docUsers =
            await firestore.collection('users').doc(currentUser.uid).get();
        users = Users.fromDocument(docUsers);

        final docAdmin =
            await firestore.collection('admins').doc(users?.id).get();
        if (docAdmin.exists) {
          users?.admin = true;
        }
        notifyListeners();
      }
    } catch (noUser) {
      StackTrace.empty;
    }
  }
}
