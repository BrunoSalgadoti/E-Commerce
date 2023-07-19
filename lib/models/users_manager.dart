import 'package:brn_ecommerce/helpers/firebase_errors.dart';
import 'package:brn_ecommerce/models/users.dart';
import 'package:brn_ecommerce/services/db_api/facebook_app_id_for_web.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
    _auth.setLanguageCode('pt-BR');
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

  bool _loadingFace = false;

  bool get loadingFace => _loadingFace;

  set loadingFace(bool value) {
    _loadingFace = value;
    notifyListeners();
  }

  bool get isLoggedIn => users != null;

  bool get adminEnable => users != null && users!.admin;

  Image? image = Image.asset(
    "assets/logo/storeLogo.png",
    width: 15,
    height: 15,
  );

  Future<void> signInWithEmailAndPassword(
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

  Future<void> loginWithFacebook(
      {required Function? onFail, required Function? onSuccess}) async {
    try {
      loadingFace = true;
      // check if is running on Web
      if (kIsWeb) {
        await FacebookAuth.i.webAndDesktopInitialize(
          appId: FacebookAppIdForWeb().facebookAppId,
          cookie: true,
          xfbml: true,
          version: "v17.0",
        );
      }

      // Realize authentication for the Facebook
      final LoginResult result = await FacebookAuth.instance.login();

      switch (result.status) {
        case LoginStatus.success:
          // Gets the user's access token
          final AccessToken accessToken = result.accessToken!;

          // Converte o token de acesso em uma credencial do Firebase
          final OAuthCredential credential =
              FacebookAuthProvider.credential(accessToken.token);

          // Converts the access token to a Firebase credential
          final UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);

          // Get authenticated user
          final User? user = userCredential.user;

          if (user != null) {
            // Check if the user document already exists in Firestore
            final DocumentSnapshot userSnapshot =
                await firestore.collection("users").doc(user.uid).get();

            // Capture user data and save to FirebaseFirestore
            if (userSnapshot.exists) {
              users = Users.fromDocument(userSnapshot);
              await users?.updateUserData();
            } else {
              users = Users(
                email: user.email ?? "",
                userName: user.displayName,
                id: user.uid,
                phoneNumber: user.phoneNumber ?? "",
                userPhotoURL: user.photoURL ?? "",
              );
              await users?.saveUserData();
            }
          }

          loadingFace = false;
          onSuccess!();
          break;
        case LoginStatus.failed:
          onFail!("Erro ao Logar com Facebbok! ${result.status}");
          loadingFace = false;
          break;
        case LoginStatus.cancelled:
          onFail!("Login cancelado pelo Usuário! ${result.status}");
          loadingFace = false;
          break;
        case LoginStatus.operationInProgress:
          loadingFace = true;
          break;
      }
    } catch (error) {
      onFail!(error);
    }
  }

  void googleLogin() {
    //TODO: Acesso com o Google
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
      users.policyAndTerms = true;
      this.users = users;

      await users.saveUserData();

      // Check if this is the first user to register
      QuerySnapshot adminsQuery =
          await firestore.collection("admins").limit(1).get();
      if (adminsQuery.docs.isEmpty) {
        // Creates document '{users.id}' in collection 'admins'
        // with user id admin
        await firestore.collection("admins").doc(users.id).set({
          "user": users.id,
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
            await firestore.collection("users").doc(currentUser.uid).get();
        users = Users.fromDocument(docUsers);

        final docAdmin =
            await firestore.collection("admins").doc(users?.id).get();
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
