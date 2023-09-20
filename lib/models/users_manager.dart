import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/helpers/firebase_errors.dart';
import 'package:brn_ecommerce/models/delivery.dart';
import 'package:brn_ecommerce/models/users.dart';
import 'package:brn_ecommerce/services/db_api/config.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../services/development_monitoring/monitoring_logger.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    if(isLoggedIn || _newUserAccount == true) {
      _loadCurrentUser();
    }
    _auth.setLanguageCode('pt-BR');
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Users? users;

  bool _loading = false;

  bool _newUserAccount = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _editingCategories = false;

  bool get editingCategories => _editingCategories;

  set editingCategories(bool value) {
    _editingCategories = value;
    notifyListeners();
  }

  bool _loadingFace = false;

  bool get loadingFace => _loadingFace;

  set loadingFace(bool value) {
    _loadingFace = value;
    notifyListeners();
  }

  bool _loadingGoogle = false;

  bool get loadingGoogle => _loadingGoogle;

  set loadingGoogle(bool value) {
    _loadingGoogle = value;
    notifyListeners();
  }

  bool get isLoggedIn => users != null;

  bool get adminEnable => users != null && users!.admin;

  Image? image = Image.asset(
    "assets/logo/storeLogo.png",
    width: 15,
    height: 15,
  );

  Future<void> createAuxAndAdminsIfNotExists({required bool firstStart}) async {
    if (!kReleaseMode && firstStart == true) {
      MonitoringLogger()
          .logInfo('Info: Verifier createAuxAndAdminsIfNotExists');

      // Check if the "admins" collection is empty
      final adminsQuery = await firestore.collection("admins").limit(1).get();
      final usersQuery = await firestore.collection("users").get();
      if (adminsQuery.docs.isEmpty && usersQuery.docs.isNotEmpty) {
        // Create document '{users.id}' in collection 'admins' with user id as admin
        await firestore.collection("admins").doc(users!.id).set({
          "user": users!.id,
        });
        users!.admin = true; // Set user as administrator on first login
      }

      // Check if the "aux" collection contains the "delivery" document
      final deliveryDoc = firestore.collection("aux").doc("delivery");
      final doc = await deliveryDoc.get();
      if (!doc.exists) {
        final delivery =
            Delivery(); // Create a new instance of the Delivery class
        await deliveryDoc.set(delivery.toMap());
      }

      // Check if the "aux" collection contains the "orderCounter" document
      final orderCounterDoc = firestore.collection("aux").doc("orderCounter");
      final orderCounterDocExists = await orderCounterDoc.get();
      if (!orderCounterDocExists.exists) {
        // Create the "orderCounter" document with "current" field set to 1
        await orderCounterDoc.set({"current": 1});
      }
    }
  }

  Future<void> signInWithEmailAndPassword(
      {required Users users,
      required Function onFail,
      required Function onSuccess}) async {
    PerformanceMonitoring().startTrace('sign-in-email', shouldStart: true);

    _newUserAccount = true;
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
    PerformanceMonitoring().stopTrace('sign-in-email');
  }

  Future<void> loginOrSingUpWithFacebook(
      {required Function? onFail, required Function? onSuccess}) async {
    PerformanceMonitoring().startTrace('login-facebook', shouldStart: true);

    try {
      loadingFace = true;
      // check if is running on Web
      if (kIsWeb) {
        await FacebookAuth.i.webAndDesktopInitialize(
          appId: Config.facebookAppId,
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
    } on FirebaseAuthException catch (error) {
      onFail!(getErrorString(error.code));
      loadingFace = false;
    }
    PerformanceMonitoring().stopTrace('login-facebook');
  }

  Future<void> loginOrSingUpWithGoogle({
    required Function? onFail,
    required Function? onSuccess,
  }) async {
    PerformanceMonitoring().startTrace('login-google', shouldStart: true);

    try {
      loadingGoogle = true;

      // check if is running on Web
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
        return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
      }

      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

      // Realize authentication for the Google
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
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

        loadingGoogle = false;
        onSuccess!();
      } else {
        // Handle the case when the user cancels the login
        onFail!("Login cancelado pelo usuário!");
        loadingGoogle = false;
      }
    } on FirebaseAuthException catch (error) {
      onFail!(getErrorString(error.code));
      loadingGoogle = false;
    }
    PerformanceMonitoring().stopTrace('login-google');
  }

  Future<void> singUpWithEmailAndPassword(
      {required Users users,
      required Function onFail,
      required Function onSuccess}) async {
    PerformanceMonitoring().startTrace('sing-up-email', shouldStart: true);

    loading = true;

    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: users.email, password: users.password!);

      users.id = result.user!.uid;
      users.policyAndTerms = true;
      this.users = users;

      await users.saveUserData();

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFail(getErrorString(error.code));
    }
    loading = false;

    PerformanceMonitoring().stopTrace('sing-up-email');
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
    } catch (error) {
        reportNoFatalErrorToCrashlytics(
            error: "$error",
            stackTrace: StackTrace.current,
            information: "Erro na Classe: UserManager no método _loadCurrentUser()"
        );
        MonitoringLogger().logError('Erro ao carregar CurrentUser: $error');
    }
    notifyListeners();
  }
}
