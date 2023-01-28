import 'package:ecommerce/helpers/firebase_errors.dart';
import 'package:ecommerce/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserManager{

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signIn({required Users users, required Function onFail, required Function onSuccess}) async {
    try{
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: users.email, password: users.password);

      onSuccess();
      //print(result.user!.uid);
    } on FirebaseAuthException catch(e){
      onFail(getErrorString(e.code));
    }
  }
}