import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/helpers/firebase_errors.dart';
import 'package:ecommerce/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserManager with ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user;

  bool _loading = false;
  bool get loading => _loading;

   UserManager(){
    _loadCurrentUser();
  }

  Future<void> signIn({required Users users, required Function onFail, required Function onSuccess}) async {
    loading = true;
    try{
      final UserCredential result = await _auth.signInWithEmailAndPassword(
          email: users.email, password: users.password);

      user = result.user!;

      onSuccess();
    } on FirebaseAuthException catch(error){
      onFail(getErrorString(error.code));
    }
    loading = false;
  }

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser() async {
    final User currentUser =  _auth.currentUser!;
      user = currentUser;
      debugPrint('Printe de teste de usuário = ${user!.uid}');
      notifyListeners();
    }
  }