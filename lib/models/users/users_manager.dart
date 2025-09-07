import 'dart:async';

import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/helpers/firebase_errors.dart';
import 'package:brn_ecommerce/models/favorites/favorites_manager.dart';
import 'package:brn_ecommerce/models/sales/delivery.dart';
import 'package:brn_ecommerce/models/users/users.dart';
import 'package:brn_ecommerce/services/db_api/config_environment_variables.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

/// UserManager is responsible for user authentication, profile loading, and state management.
/// Handles email/password login, Google/Facebook login, sign-up, sign-out, and persistent login_.
class UserManager extends ChangeNotifier {
  // Proprieties

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _loading = false;
  bool _newUserAccount = false;
  bool _editingCategories = false;
  bool _loadingFace = false;
  bool _loadingGoogle = false;
  Users? users;

  /// Constructor
  UserManager() {
    _auth.setLanguageCode('pt-BR');
    // Attempt to load current user if already signed in
    if (_auth.currentUser != null) {
      initializeUser();
    }
  }

  // Getters and setters
  bool get loading => _loading;
  bool get editingCategories => _editingCategories;
  bool get loadingFace => _loadingFace;
  bool get loadingGoogle => _loadingGoogle;
  bool get isLoggedIn => users != null;
  bool get adminEnable => users != null && users!.admin;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  set editingCategories(bool value) {
    _editingCategories = value;
    notifyListeners();
  }

  set loadingFace(bool value) {
    _loadingFace = value;
    notifyListeners();
  }

  set loadingGoogle(bool value) {
    _loadingGoogle = value;
    notifyListeners();
  }

  // Methods

  /// Signs out the current user.
  void signOut(BuildContext context) {
    _auth.signOut();
    users = null;
    notifyListeners();

    // Update FavoritesManager to clear favorites when logging out
    final favoritesManager = Provider.of<FavoritesManager>(context, listen: false);
    favoritesManager.updateUser(null);
  }

  /// Loads the current user's data from Firestore.
  Future<void> _loadCurrentUser({BuildContext? context, User? user}) async {
    try {
      final currentUser = user ?? _auth.currentUser!;
      if (currentUser.uid.isNotEmpty) {
        final docUsers = await firestore.collection("users").doc(currentUser.uid).get();
        users = Users.fromDocument(docUsers);

        final docAdmin = await firestore.collection("admins").doc(users?.id).get();
        if (docAdmin.exists) users?.admin = true;

        // Only updates favorites if context was passed
        if (context != null) {
          final favoritesManager = Provider.of<FavoritesManager>(context, listen: false);
          favoritesManager.updateUser(users?.id);
        }

        notifyListeners();
      }
    } catch (error) {
      reportNoFatalErrorToCrashlytics(
        error: "$error",
        stackTrace: StackTrace.current,
        information: "Erro na Classe: UserManager no método _loadCurrentUser()",
      );
      MonitoringLogger().logError('Erro ao carregar CurrentUser: $error');
    }
  }

  /// Checks if necessary auxiliary documents and admin data exist in Firestore.
  Future<void> createAuxAndAdminsIfNotExists({required bool firstStart}) async {
    if (kDebugMode && firstStart) {
      MonitoringLogger().logInfo('Info: Verifier createAuxAndAdminsIfNotExists');

      // Check if the "admins" collection is empty
      final adminsQuery = await firestore.collection("admins").limit(1).get();
      final usersQuery = await firestore.collection("users").get();
      if (adminsQuery.docs.isEmpty && usersQuery.docs.isNotEmpty) {
        // Create document '{users.id}' in collection 'admins' with user id as admin
        await firestore.collection("admins").doc(users!.id).set({"user": users!.id});
        users!.admin = true; // Set user as administrator on first login
      }

      // Check if the "aux" collection contains the "delivery" document
      final deliveryDoc = firestore.collection("aux").doc("delivery");
      final doc = await deliveryDoc.get();
      if (!doc.exists)
        await deliveryDoc.set(Delivery().toMap()); // Create a new instance of the Delivery class

      // Check if the "aux" collection contains the "orderCounter" document
      final orderCounterDoc = firestore.collection("aux").doc("orderCounter");
      if (!(await orderCounterDoc.get()).exists) {
        // Create the "orderCounter" document with "current" field set to 1
        await orderCounterDoc.set({"current": 1});
      }
    }
  }

  Future<void> verifyEmailWithCode(BuildContext context, String oobCode) async {
    try {
      await _auth.checkActionCode(oobCode);
      await _auth.applyActionCode(oobCode);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('E-mail verificado com sucesso!')),
        );
      }
    } catch (e) {
      debugPrint('Erro ao verificar e-mail: $e');
    }
  }

  /// Send password reset email (send only)
  Future<void> sendPasswordResetEmailRequest({
    required String email,
    required VoidCallback onSuccess,
    required Function(String) onFail,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          url: AppConfigKey.linkRecoverPasswordInWeb,
          handleCodeInApp: false,
          iOSBundleId: null,
          androidPackageName: null,
          androidInstallApp: false,
        ),
      );
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(e.message ?? "Erro desconhecido");
    } catch (e) {
      onFail("Erro inesperado: $e");
    }
  }

  /// Confirm the new password using the oobCode
  Future<void> confirmNewPassword({
    required String oobCode,
    required String newPassword,
    required VoidCallback onSuccess,
    required Function(String) onFail,
  }) async {
    try {
      await _auth.confirmPasswordReset(code: oobCode, newPassword: newPassword);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(e.message ?? "Erro desconhecido");
    } catch (e) {
      onFail("Erro inesperado: $e");
    }
  }

  /// Initializes user data
  Future<void> initializeUser({BuildContext? context}) async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      try {
        final docUsers = await firestore.collection("users").doc(currentUser.uid).get();
        users = Users.fromDocument(docUsers);
        notifyListeners();
      } catch (error) {
        debugPrint('Erro ao inicializar usuário: $error');
      }
    }
  }

  /// Signs in with email and password.
  Future<void> signInWithEmailAndPassword({
    required Users users,
    required Function onFail,
    required Function onSuccess,
    BuildContext? context,
  }) async {
    PerformanceMonitoring().startTrace('sign-in-email', shouldStart: true);
    loading = true;
    try {
      final result =
          await _auth.signInWithEmailAndPassword(email: users.email, password: users.password!);
      await _loadCurrentUser(user: result.user, context: context);
      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFail(getErrorString(error.code));
    }
    loading = false;
    PerformanceMonitoring().stopTrace('sign-in-email');
  }

  /// Signs up with email and password.
  Future<void> singUpWithEmailAndPassword({
    required Users users,
    required Function onFail,
    required Function onSuccess,
    BuildContext? context,
  }) async {
    PerformanceMonitoring().startTrace('sing-up-email', shouldStart: true);
    loading = true;

    try {
      final result =
          await _auth.createUserWithEmailAndPassword(email: users.email, password: users.password!);

      users.id = result.user!.uid;
      users.policyAndTerms = true;
      this.users = users;

      await users.saveUserData();
      _newUserAccount = true;
      await _updateMonthlyNewUsers();

      if (context != null) {
        final favoritesManager = Provider.of<FavoritesManager>(context, listen: false);
        favoritesManager.updateUser(users.id);
      }

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFail(getErrorString(error.code));
    }

    loading = false;
    PerformanceMonitoring().stopTrace('sing-up-email');
  }

  /// Signs in or signs up with Facebook authentication.
  Future<void> loginOrSingUpWithFacebook({
    required Function? onFail,
    required Function? onSuccess,
    BuildContext? context,
  }) async {
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
      final result = await FacebookAuth.instance.login();

      switch (result.status) {
        case LoginStatus.success:
          // Gets the user's access token
          final accessToken = result.accessToken!;
          // Converte o token de acesso em uma credencial do Firebase
          final credential = FacebookAuthProvider.credential(accessToken.tokenString);
          // Converts the access token to a Firebase credential
          final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
          // Get authenticated user
          final user = userCredential.user;

          if (user != null) {
            // Check if the user document already exists in Firestore
            final doc = await firestore.collection("users").doc(user.uid).get();
            // Capture user data and save to FirebaseFirestore
            if (doc.exists) {
              users = Users.fromDocument(doc);
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
              _newUserAccount = true;
              await _updateMonthlyNewUsers();
            }

            if (context != null) {
              final favManager = Provider.of<FavoritesManager>(context, listen: false);
              favManager.updateUser(users?.id);
            }

            loadingFace = false;
            onSuccess?.call();
          }
          break;
        case LoginStatus.failed:
          onFail!("Facebook login failed! ${result.status}");
          loadingFace = false;
          break;
        case LoginStatus.cancelled:
          onFail!("Login cancelled by user! ${result.status}");
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

  /// Signs in or signs up with Google authentication.
  Future<void> loginOrSingUpWithGoogle({
    required Function? onFail,
    required Function? onSuccess,
    BuildContext? context,
  }) async {
    PerformanceMonitoring().startTrace('login-google', shouldStart: true);
    try {
      loadingGoogle = true;

      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        provider.addScope('https://www.googleapis.com/auth/contacts.readonly');
        provider.setCustomParameters({'login_hint': 'user@example.com'});

        await FirebaseAuth.instance.signInWithRedirect(provider);
        return;
      }

      // Initializes GoogleSignIn (new v7+ format)
      await GoogleSignIn.instance.initialize();
      // Get authentication
      final googleUser = await GoogleSignIn.instance.authenticate();
      final googleAuth = googleUser.authentication;
      // Create credential for Firebase
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.idToken,
      );

      // Login to Firebase
      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final doc = await firestore.collection("users").doc(user.uid).get();
        if (doc.exists) {
          users = Users.fromDocument(doc);
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
          _newUserAccount = true;
          await _updateMonthlyNewUsers();
        }

        if (context != null) {
          final favManager = Provider.of<FavoritesManager>(context, listen: false);
          favManager.updateUser(users?.id);
        }

        onSuccess?.call();
      } else {
        onFail?.call("Erro ao autenticar usuário.");
      }

      loadingGoogle = false;
    } on FirebaseAuthException catch (error) {
      onFail?.call(getErrorString(error.code));
      loadingGoogle = false;
    } catch (e) {
      onFail?.call("Erro inesperado: $e");
      loadingGoogle = false;
    }

    PerformanceMonitoring().stopTrace('login-google');
  }

  Future<void> _updateMonthlyNewUsers() async {
    if (!_newUserAccount || users == null) return;

    final now = DateTime.now();
    final monthKey = "${now.year}-${now.month.toString().padLeft(2, '0')}";
    final docRef = firestore.collection('aux').doc('NewUsers').collection('monthly').doc(monthKey);

    final doc = await docRef.get();
    if (doc.exists) {
      await docRef.update({'count': FieldValue.increment(1)});
    } else {
      await docRef.set({'count': 1});
    }
    // Marks that the user has already been counted
    _newUserAccount = false;
  }
//TODO: Criação de método para capturar cookies e dados do Analytics
/* Future<void> _loadUserVisitor ({User? user}) async {

} */
}
