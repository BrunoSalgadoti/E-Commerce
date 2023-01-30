import 'package:ecommerce/helpers/firebase_errors.dart';
import 'package:ecommerce/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserManager with ChangeNotifier{

  final FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

  Future<void> signIn({required Users users, required Function onFail, required Function onSuccess}) async {
    setLoading(true);
    try{
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: users.email, password: users.password);

      await Future.delayed(const Duration (seconds: 4)); //Teste temporal

      onSuccess();
    } on FirebaseAuthException catch(error){
      onFail(getErrorString(error.code));
    }
    setLoading(false);
  }
  void setLoading(bool value){
    loading = value;
    notifyListeners();
  }
}